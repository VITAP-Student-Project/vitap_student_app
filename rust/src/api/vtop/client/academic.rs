use crate::api::vtop::{
    parser, types::*, vtop_client::VtopClient, vtop_errors::VtopError, vtop_errors::VtopResult,
    vtop_errors::{map_reqwest_error, map_response_read_error},
};
use chrono::Utc;
use reqwest::multipart;

impl VtopClient {
    /// Retrieves the list of available semesters for the authenticated student.
    ///
    /// This method fetches all semester data including semester IDs, names, and other metadata
    /// that can be used to query semester-specific information like timetables, attendance, and marks.
    ///
    /// # Returns
    /// 
    /// Returns a `VtopResult<SemesterData>` containing:
    /// - A list of all available semesters with their IDs and descriptions
    /// - Current semester information
    /// - Semester enrollment details
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The CSRF token is missing or invalid (`VtopError::SessionExpired`)
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let semester_data = client.get_semesters().await?;
    /// for semester in semester_data.semesters {
    ///     println!("Semester: {} (ID: {})", semester.name, semester.id);
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_semesters(&mut self) -> VtopResult<SemesterData> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/academics/common/StudentTimeTable",
            self.config.base_url
        );

        let body = format!(
            "verifyMenu=true&authorizedID={}&_csrf={}&nocache=@(new Date().getTime())",
            self.username,
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
        );
        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(map_reqwest_error)?;
        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;

        let text = res.text().await.map_err(map_response_read_error)?;
        Ok(parser::semested_id_parser::parse_semid_from_timetable(text))
    }

    /// Retrieves the complete timetable for a specific semester.
    ///
    /// Fetches the weekly class schedule including course details, timings, venues,
    /// faculty information, and class types (Theory/Lab/Tutorial) for the specified semester.
    ///
    /// # Arguments
    ///
    /// * `semester_id` - The unique identifier for the semester (obtained from `get_semesters()`)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Timetable>` containing:
    /// - Weekly schedule organized by days and time slots
    /// - Course codes, names, and types
    /// - Venue and room information
    /// - Faculty names assigned to each course
    /// - Slot timings and duration
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The provided semester ID is invalid or not found
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let semesters = client.get_semesters().await?;
    /// if let Some(current_sem) = semesters.semesters.first() {
    ///     let timetable = client.get_timetable(&current_sem.id).await?;
    ///     println!("Monday classes: {:?}", timetable.monday);
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_timetable(&mut self, semester_id: &str) -> VtopResult<Timetable> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/processViewTimeTable", self.config.base_url);
        let body = format!(
            "_csrf={}&semesterSubId={}&authorizedID={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            semester_id,
            self.username
        );
        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(map_reqwest_error)?;
        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;
        let text = res.text().await.map_err(map_response_read_error)?;
        Ok(parser::timetable_parser::parse_timetable(text))
    }

    /// Retrieves the attendance summary for all courses in a specific semester.
    ///
    /// Fetches attendance statistics for each registered course including total classes,
    /// attended classes, and attendance percentage. This provides an overview of attendance
    /// across all courses without detailed session-by-session breakdown.
    ///
    /// # Arguments
    ///
    /// * `semester_id` - The unique identifier for the semester (obtained from `get_semesters()`)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<AttendanceRecord>>` containing a vector of attendance records where each record includes:
    /// - Course code and name
    /// - Course type (Theory/Lab/Tutorial)
    /// - Total number of classes conducted
    /// - Number of classes attended
    /// - Attendance percentage
    /// - Faculty name
    /// - Slot information
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The provided semester ID is invalid
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let attendance = client.get_attendance("AP2425SEM1234").await?;
    /// for record in attendance {
    ///     println!("{}: {}% ({}/{})", 
    ///         record.course_name, 
    ///         record.percentage,
    ///         record.attended, 
    ///         record.total
    ///     );
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_attendance(&mut self, semester_id: &str) -> VtopResult<Vec<AttendanceRecord>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/processViewStudentAttendance", self.config.base_url);
        let body = format!(
            "_csrf={}&semesterSubId={}&authorizedID={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            semester_id,
            self.username
        );
        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(map_reqwest_error)?;
        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;
        let text = res.text().await.map_err(map_response_read_error)?;
        Ok(parser::attendance_parser::parse_attendance(text))
    }

    /// Retrieves detailed attendance records for a specific course.
    ///
    /// Fetches session-by-session attendance details for a particular course, including
    /// individual class dates, timings, attendance status, and any remarks. This provides
    /// a granular view of attendance beyond the summary statistics.
    ///
    /// # Arguments
    ///
    /// * `semester_id` - The unique identifier for the semester
    /// * `course_id` - The course code (e.g., "CSE1001", "MAT2001")
    /// * `course_type` - The type of course ("Theory", "Lab", "Embedded Theory", "Embedded Lab", etc.)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<AttendanceDetailRecord>>` containing detailed attendance information:
    /// - Date and time of each class session
    /// - Attendance status (Present/Absent/OD/Medical Leave)
    /// - Session number and slot information
    /// - Faculty who took the class
    /// - Any remarks or notes for the session
    /// - Topic covered in the session
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The provided semester ID, course ID, or course type is invalid
    /// - The student is not registered for the specified course
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let details = client.get_attendance_detail(
    ///     "AP2425SEM1234",
    ///     "CSE1001",
    ///     "Theory"
    /// ).await?;
    /// 
    /// for session in details {
    ///     println!("Date: {}, Status: {}, Topic: {}", 
    ///         session.date, 
    ///         session.status, 
    ///         session.topic
    ///     );
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_attendance_detail(
        &mut self,
        semester_id: &str,
        course_id: &str,
        course_type: &str,
    ) -> VtopResult<Vec<AttendanceDetailRecord>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/processViewAttendanceDetail", self.config.base_url);
        let timestamp = Utc::now().format("%a, %d %b %Y %H:%M:%S GMT").to_string();
        let body = format!(
            "_csrf={}&semesterSubId={}&registerNumber={}&courseId={}&courseType={}&authorizedID={}&x={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            semester_id,
            self.username,
            course_id,
            course_type,
            self.username,
            timestamp
        );
        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(map_reqwest_error)?;
        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;
        let text = res.text().await.map_err(map_response_read_error)?;
        Ok(parser::attendance_parser::parse_full_attendance(text))
    }

    /// Retrieves marks and assessment scores for all courses in a specific semester.
    ///
    /// Fetches detailed marks information including CAT (Continuous Assessment Test) scores,
    /// assignment marks, quiz scores, and final assessment marks for each registered course.
    /// This provides comprehensive academic performance data for the semester.
    ///
    /// # Arguments
    ///
    /// * `semester_id` - The unique identifier for the semester (obtained from `get_semesters()`)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<Marks>>` containing marks information for each course:
    /// - Course code, name, and credits
    /// - CAT 1, CAT 2, and other periodic test scores
    /// - Assignment and quiz marks
    /// - Digital assignment scores
    /// - Final assessment marks
    /// - Total marks obtained and maximum marks
    /// - Grade status and evaluation status
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The provided semester ID is invalid
    /// - Marks have not been published for the semester
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let marks = client.get_marks("AP2425SEM1234").await?;
    /// for course_marks in marks {
    ///     println!("{}: Total {}/{}", 
    ///         course_marks.course_name,
    ///         course_marks.total_marks_obtained,
    ///         course_marks.total_marks_maximum
    ///     );
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_marks(&mut self, semester_id: &str) -> VtopResult<Vec<Marks>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/examinations/doStudentMarkView",
            self.config.base_url
        );
        let form = multipart::Form::new()
            .text("authorizedID", self.username.clone())
            .text("semesterSubId", semester_id.to_string())
            .text(
                "_csrf",
                self.session
                    .get_csrf_token()
                    .ok_or(VtopError::SessionExpired)?,
            );

        let res = self
            .client
            .post(url)
            .multipart(form)
            .send()
            .await
            .map_err(map_reqwest_error)?;
        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;

        let text = res.text().await.map_err(map_response_read_error)?;

        Ok(parser::marks_parser::parse_marks(text))
    }

    /// Retrieves the examination schedule for all courses in a specific semester.
    ///
    /// Fetches comprehensive exam schedule information including exam dates, timings,
    /// venues, exam types, and seating arrangements for all registered courses in the semester.
    /// This helps students plan and prepare for upcoming examinations.
    ///
    /// # Arguments
    ///
    /// * `semester_id` - The unique identifier for the semester (obtained from `get_semesters()`)
    ///
    /// # Returns
    ///
    /// Returns a `VtopResult<Vec<PerExamScheduleRecord>>` containing exam details for each course:
    /// - Course code and name
    /// - Exam type (CAT-1, CAT-2, FAT, Mid-term, End-term, etc.)
    /// - Exam date and time
    /// - Duration of the examination
    /// - Exam venue and room number
    /// - Seating arrangement details (row, column, seat number)
    /// - Slot information
    /// - Any special instructions or requirements
    ///
    /// # Errors
    ///
    /// This function will return an error if:
    /// - The session is not authenticated (`VtopError::SessionExpired`)
    /// - The provided semester ID is invalid
    /// - Exam schedule has not been published yet
    /// - Network communication fails (`VtopError::NetworkError`)
    /// - The VTOP server returns an error response (`VtopError::VtopServerError`)
    /// - Session expires during the request and re-authentication fails
    ///
    /// # Examples
    ///
    /// ```
    /// # async fn example(client: &mut VtopClient) -> Result<(), Box<dyn std::error::Error>> {
    /// let schedule = client.get_exam_schedule("AP2425SEM1234").await?;
    /// for exam in schedule {
    ///     println!("{} - {} on {} at {}", 
    ///         exam.course_name,
    ///         exam.exam_type,
    ///         exam.exam_date,
    ///         exam.exam_time
    ///     );
    ///     println!("Venue: {}, Seat: {}", exam.venue, exam.seat_number);
    /// }
    /// # Ok(())
    /// # }
    /// ```
    pub async fn get_exam_schedule(
        &mut self,
        semester_id: &str,
    ) -> VtopResult<Vec<PerExamScheduleRecord>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/examinations/doSearchExamScheduleForStudent",
            self.config.base_url
        );
        let form = multipart::Form::new()
            .text("authorizedID", self.username.clone())
            .text("semesterSubId", semester_id.to_string())
            .text(
                "_csrf",
                self.session
                    .get_csrf_token()
                    .ok_or(VtopError::SessionExpired)?,
            );
        let res = self
            .client
            .post(url)
            .multipart(form)
            .send()
            .await
            .map_err(map_reqwest_error)?;
        // Check for session expiration and auto re-authenticate if needed
        self.handle_session_check(&res).await?;
        let text = res.text().await.map_err(map_response_read_error)?;
        Ok(parser::exam_schedule_parser::parse_schedule(text))
    }
}
