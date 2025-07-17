use crate::api::vtop::{parser, types};

pub use super::session_manager::SessionManager;
pub use super::types::*;
pub use super::vtop_config::VtopConfig;
pub use super::vtop_errors::VtopError;
pub use super::vtop_errors::VtopResult;

use base64::{engine::general_purpose::URL_SAFE, Engine as _};
#[cfg(not(target_arch = "wasm32"))]
pub use reqwest::cookie::{CookieStore, Jar};
use reqwest::{
    header::{HeaderMap, HeaderValue, USER_AGENT},
    multipart, Client, Url,
};

use scraper::{Html, Selector};
use serde::Serialize;
use std::sync::Arc;

pub struct VtopClient {
    client: Client,
    config: VtopConfig,
    session: SessionManager,
    current_page: Option<String>,
    username: String,
    password: String,
    captcha_data: Option<String>,
}

impl VtopClient {
    /// Retrieves the current session's cookies as a byte vector.
    ///
    /// Returns an error if the session is not authenticated.
    ///
    /// # Returns
    /// A vector of bytes representing the session cookies, or an error if the session has expired.
    ///
    /// # Examples
    ///
    /// ```
    /// let cookies = client.get_cookie().await?;
    /// assert!(!cookies.is_empty());
    /// ```
    #[cfg(not(target_arch = "wasm32"))]
    pub async fn get_cookie(&self) -> VtopResult<Vec<u8>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }

        let mut data = vec![];
        let url = format!("{}/vtop", self.config.base_url);
        let k = self
            .session
            .get_cookie_store()
            .cookies(&Url::parse(&url).unwrap());
        if let Some(cookie) = k {
            data = cookie.as_bytes().to_vec();
        }
        Ok(data)
    }

    pub async fn download_payment_receipt(
        &mut self,
        receipt_no: String,
        applno: String,
    ) -> VtopResult<String> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/finance/dupReceiptNewP2P?receitNo={}&authorizedID={}&_csrf={}&x={}&registerNumber={}&applno={}",
            self.config.base_url,
            receipt_no,
            self.username,
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            chrono::Utc::now().to_rfc2822(),
            self.username,
            applno // This should be replaced with the actual application number if needed
        );

        let res = self
            .client
            .get(url)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(text)
    }

    /// Retrieves the list of payment receipts for the authenticated user.
    ///
    /// Returns a vector of `PaidPaymentReceipt` objects parsed from the VTOP system. If the session is expired or authentication fails, returns a `SessionExpired` error. Network or server errors are also reported as appropriate.
    ///
    /// # Returns
    /// A vector of `PaidPaymentReceipt` on success.
    ///
    /// # Errors
    /// Returns `VtopError::SessionExpired` if the session is not authenticated or has expired, `VtopError::NetworkError` on network failure, and `VtopError::VtopServerError` on server response errors.
    ///
    /// # Examples
    ///
    /// ```
    /// let receipts = client.get_payment_receipts().await?;
    /// assert!(!receipts.is_empty());
    /// ```
    pub async fn get_payment_receipts(&mut self) -> VtopResult<Vec<PaidPaymentReceipt>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/p2p/getReceiptsApplno", self.config.base_url);
        let body = format!(
            "verifyMenu=true&_csrf={}&authorizedID={}&nocache=@(new Date().getTime())",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let receipts: Vec<PaidPaymentReceipt> =
            parser::payment_receipts_parser::parse_payment_receipts(text);
        Ok(receipts)
    }

    /// Retrieves the list of pending payments for the authenticated user.
    ///
    /// Returns a vector of `PendingPaymentReceipt` records if the session is valid. If the session has expired or the network/server fails, an appropriate error is returned.
    ///
    /// # Returns
    /// A `VtopResult` containing a vector of `PendingPaymentReceipt` items on success.
    ///
    /// # Errors
    /// Returns `VtopError::SessionExpired` if the session is not authenticated or has expired, `VtopError::NetworkError` on network failure, or `VtopError::VtopServerError` if the server response cannot be parsed.
    ///
    /// # Examples
    ///
    /// ```
    /// let mut client = VtopClient::with_config(config, session, username, password);
    /// let pending = client.get_pending_payment().await?;
    /// assert!(!pending.is_empty());
    /// ```
    pub async fn get_pending_payment(&mut self) -> VtopResult<Vec<PendingPaymentReceipt>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/finance/Payments", self.config.base_url);
        let body = format!(
            "verifyMenu=true&_csrf={}&authorizedID={}&nocache=@(new Date().getTime())",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let pending_payment = parser::pending_payments_parser::parse_pending_payments(text);
        Ok(pending_payment)
    }

    /// Retrieves the student's grade history and detailed course grade records.
    ///
    /// Returns a `GradeHistory` struct containing the overall grade history and course-specific grade histories for the authenticated session.
    ///
    /// # Errors
    ///
    /// Returns `VtopError::SessionExpired` if the session is not authenticated or has expired, `VtopError::NetworkError` on network failure, or `VtopError::VtopServerError` if the server response cannot be parsed.
    ///
    /// # Examples
    ///
    /// ```
    /// let grade_history = client.get_grade_history().await?;
    /// assert!(!grade_history.courses.is_empty());
    /// ```
    pub async fn get_grade_history(&mut self) -> VtopResult<GradeHistory> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/examinations/examGradeView/StudentGradeHistory",
            self.config.base_url
        );
        let body = format!(
            "verifyMenu=true&_csrf={}&authorizedID={}&nocache=@(new Date().getTime())",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let grade_history = parser::grade_history_parser::parse_grade_history(text);
        Ok(grade_history)
    }

    /// Retrieves the full student profile for the authenticated user, including grade history.
    ///
    /// Sends a POST request to the VTOP student profile endpoint using the current session's CSRF token and authorized ID,
    /// then fetches the grade history and combines them into a complete student profile. Returns the parsed student profile
    /// data with grade history on success, or a session/network error if authentication fails or the server is unreachable.
    ///
    /// # Returns
    /// The student's complete profile information as a `StudentProfile` object with grade history included.
    ///
    /// # Errors
    /// Returns `VtopError::SessionExpired` if the session is not authenticated or has expired, or `VtopError::NetworkError`/`VtopError::VtopServerError` on network or server failure.
    ///
    /// # Examples
    ///
    /// ```
    /// let profile = client.get_student_profile().await?;
    /// println!("Student name: {}", profile.student_name);
    /// println!("CGPA: {}", profile.grade_history.cgpa);
    /// ```
    pub async fn get_student_profile(
        &mut self,
    ) -> VtopResult<crate::api::vtop::types::student_profile::StudentProfile> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }

        // Fetch basic profile data
        let url = format!(
            "{}/vtop/studentsRecord/StudentProfileAllView",
            self.config.base_url
        );
        let body = format!(
            "_csrf={}&authorizedID={}&nocache=@(new Date().getTime())",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let mut profile = crate::api::vtop::parser::profile_parser::parse_student_profile(text);

        // Fetch grade history and add it to the profile
        let grade_history = self.get_grade_history().await?;
        profile.grade_history = grade_history;

        Ok(profile)
    }

    // Hostel Get Leave Report
    /// Retrieves the student's hostel leave report from the VTOP system.
    ///
    /// Returns the parsed hostel leave data if the session is authenticated. Returns a session expired error if authentication has expired or a network/server error if the request fails.
    ///
    /// # Examples
    ///
    /// ```
    /// let leave_report = client.get_hostel_leave_report().await?;
    /// println!("{:?}", leave_report);
    /// ```
    pub async fn get_hostel_leave_report(&mut self) -> VtopResult<HostelLeaveData> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/hostel/StudentGeneralOuting", self.config.base_url);
        let body = format!(
            "_csrf={}&authorizedID={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let leave_data = parser::hostel::parseleave::parse_hostel_leave(text);
        Ok(leave_data)
    }

    // Hostel Get Leave PDF
    pub async fn get_hostel_leave_pdf(&mut self, leave_id: String) -> VtopResult<Vec<u8>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/hostel/downloadLeavePass/{}?authorizedID={}&_csrf={}&x={}",
            self.config.base_url,
            leave_id,
            self.username,
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            chrono::Utc::now().to_rfc2822()
        );

        let res = self
            .client
            .get(url)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let bytes = res.bytes().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(bytes.to_vec())
    }

    // Hostel Get Report

    pub async fn get_hostel_report(&mut self) -> VtopResult<HostelOutingData> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/hostel/StudentWeekendOuting", self.config.base_url);
        let body = format!(
            "_csrf={}&authorizedID={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        let hostel_data = parser::hostel::parseoutings::parse_hostel_outing(text);
        Ok(hostel_data)
    }

    // Hostel Get Outing PDF
    pub async fn get_hostel_outing_pdf(&mut self, booking_id: String) -> VtopResult<Vec<u8>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/hostel/downloadOutingForm/{}?authorizedID={}&_csrf={}&x={}",
            self.config.base_url,
            booking_id,
            self.username,
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            chrono::Utc::now().to_rfc2822()
        );

        let res = self
            .client
            .get(url)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let bytes = res.bytes().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(bytes.to_vec())
    }

    // Submit Outing form
    pub async fn submit_outing_form(
        &mut self,
        purpose_of_visit: String,
        outing_date: String,
        contact_number: String,
        out_place: String,
        out_time: String,
    ) -> VtopResult<String> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/hostel/saveOutingForm", self.config.base_url);

        let form = multipart::Form::new()
            .text(
                "_csrf",
                self.session
                    .get_csrf_token()
                    .ok_or(VtopError::SessionExpired)?,
            )
            .text("authorizedID", self.username.clone())
            .text("regNo", self.username.clone())
            .text("name", "") // This might need to be dynamic
            .text("applicationNo", "") // This might need to be dynamic
            .text("gender", "") // This might need to be dynamic
            .text("hostelBlock", "") // This might need to be dynamic
            .text("roomNo", "") // This might need to be dynamic
            .text("outPlace", out_place)
            .text("purposeOfVisit", purpose_of_visit)
            .text("outingDate", outing_date)
            .text("outTime", out_time)
            .text("contactNumber", contact_number)
            .text("parentContactNumber", "") // This might need to be dynamic
            .text("x=", chrono::Utc::now().to_rfc2822());

        let res = self
            .client
            .post(url)
            .multipart(form)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(text)
    }

    // faculty search
    pub async fn get_faculty_search(
        &mut self,
        search_term: String,
    ) -> VtopResult<types::GetFaculty> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/hrms/EmployeeSearchForStudent",
            self.config.base_url
        );
        let body = format!(
            "_csrf={}&empId={}&authorizedID={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            urlencoding::encode(&search_term),
            self.username
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        // print!("Fetched faculty search data: {}", text);
        Ok(parser::faculty::parsesearch::parse_faculty_search(text))
    }

    // faculty get data from search
    pub async fn get_faculty_data(&mut self, emp_id: String) -> VtopResult<FacultyDetails> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!(
            "{}/vtop/hrms/EmployeeSearch1ForStudent",
            self.config.base_url
        );
        let body = format!(
            "_csrf={}&empId={}&authorizedID={}&x={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            emp_id,
            self.username,
            chrono::Utc::now().to_rfc2822()
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        print!("Fetched faculty data: {}", text);
        let faculty_details = parser::faculty::parseabout::parse_faculty_data(text);
        Ok(faculty_details)
    }

    pub async fn get_biometric_data(
        &mut self,
        date: String,
    ) -> VtopResult<Vec<types::BiometricRecord>> {
        if !self.session.is_authenticated() {
            return Err(VtopError::SessionExpired);
        }
        let url = format!("{}/vtop/getStudBioHistory", self.config.base_url);
        let body = format!(
            "_csrf={}&fromDate={}&authorizedID={}&x={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            date,
            self.username,
            chrono::Utc::now().to_rfc2822()
        );

        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        // Using println! instead of print! for better formatting

        Ok(parser::parsebiometric::parse_biometric_data(text))
    }

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
            .map_err(|_| VtopError::NetworkError)?;
        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(parser::semested_id_parser::parse_semid_from_timetable(text))
    }



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
            .map_err(|_| VtopError::NetworkError)?;
        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }
        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(parser::timetable_parser::parse_timetable(text))
    }

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
            .map_err(|_| VtopError::NetworkError)?;
        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        };
        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(parser::attendance_parser::parse_attendance(text))
    }

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
        let body = format!(
            "_csrf={}&semesterSubId={}&registerNumber={}&courseId={}&courseType={}&authorizedID={}",
            self.session
                .get_csrf_token()
                .ok_or(VtopError::SessionExpired)?,
            semester_id,
            self.username,
            course_id,
            course_type,
            self.username
        );
        let res = self
            .client
            .post(url)
            .body(body)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;
        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }
        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(parser::attendance_parser::parse_full_attendance(text))
    }

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
            .map_err(|_| VtopError::NetworkError)?;
        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }

        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;

        Ok(parser::marks_parser::parse_marks(text))
    }

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
            .map_err(|_| VtopError::NetworkError)?;
        if !res.status().is_success() || res.url().to_string().contains("login") {
            self.session.set_authenticated(false);
            return Err(VtopError::SessionExpired);
        }
        let text = res.text().await.map_err(|_| VtopError::VtopServerError)?;
        Ok(parser::exam_schedule_parser::parse_schedule(text))
    }
    pub fn is_authenticated(&mut self) -> bool {
        self.session.is_authenticated()
    }
}
// for login
impl VtopClient {
    pub async fn login(&mut self) -> VtopResult<()> {
        #[allow(non_snake_case)]
        let MAX_CAP_TRY = 4;
        for i in 0..MAX_CAP_TRY {
            if i == 0 {
                self.load_login_page(true).await?;
            } else {
                self.load_login_page(false).await?;
            }

            let captcha_answer = if let Some(captcha_data) = &self.captcha_data {
                self.solve_captcha(captcha_data).await?
            } else {
                return Err(VtopError::CaptchaRequired);
            };
            match self.perform_login(&captcha_answer).await {
                Ok(_) => {
                    self.session.set_authenticated(true);
                    return Ok(());
                }
                Err(VtopError::AuthenticationFailed(msg)) if msg.contains("Invalid Captcha") => {
                    continue;
                }
                Err(e) => return Err(e),
            }
        }
        Err(VtopError::AuthenticationFailed(
            "Max login attempts exceeded".to_string(),
        ))
    }
    async fn perform_login(&mut self, captcha_answer: &str) -> VtopResult<()> {
        let csrf = self
            .session
            .get_csrf_token()
            .ok_or(VtopError::SessionExpired)?;

        let login_data = format!(
            "_csrf={}&username={}&password={}&captchaStr={}",
            csrf,
            urlencoding::encode(&self.username),
            urlencoding::encode(&self.password),
            captcha_answer
        );
        let url = format!("{}/vtop/login", self.config.base_url);

        let response = self
            .client
            .post(url)
            .body(login_data)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;
        let response_url = response.url().to_string();
        let response_text = response.text().await.map_err(|_| VtopError::NetworkError)?;

        if response_url.contains("error") {
            if response_text.contains("Invalid Captcha") {
                return Err(VtopError::AuthenticationFailed(
                    "Invalid Captcha".to_string(),
                ));
            } else if response_text.contains("Invalid LoginId/Password")
                || response_text.contains("Invalid  Username/Password")
            {
                return Err(VtopError::InvalidCredentials);
            } else {
                Err(VtopError::AuthenticationFailed(Self::get_login_page_error(
                    &response_text,
                )))
            }
        } else {
            self.current_page = Some(response_text);
            self.extract_csrf_token()?;
            self.get_regno()?;

            self.current_page = None;
            self.captcha_data = None;
            Ok(())
        }
    }
    async fn load_login_page(&mut self, k: bool) -> VtopResult<()> {
        if k {
            self.load_initial_page().await?;
            self.extract_csrf_token()?;
        }
        #[allow(non_snake_case)]
        let Max_RELOAD_ATTEMPTS = 8;
        let csrf = self
            .session
            .get_csrf_token()
            .ok_or(VtopError::SessionExpired)?;
        let url = format!("{}/vtop/prelogin/setup", self.config.base_url);
        let body = format!("_csrf={}&flag=VTOP", csrf);
        for _ in 0..Max_RELOAD_ATTEMPTS {
            let response = self
                .client
                .post(&url)
                .body(body.clone())
                .send()
                .await
                .map_err(|_| VtopError::NetworkError)?;
            if !response.status().is_success() {
                return Err(VtopError::VtopServerError);
            }
            let text = response.text().await.map_err(|_| VtopError::NetworkError)?;
            if text.contains("base64,") {
                self.current_page = Some(text);
                self.extract_captcha_data()?;
                break;
            }
            println!("No captcha found Reloading the page ");
        }
        Ok(())
    }
    fn extract_captcha_data(&mut self) -> VtopResult<()> {
        let document = Html::parse_document(&self.current_page.as_ref().ok_or(
            VtopError::ParseError("Current page not found at captcha extration".into()),
        )?);
        let selector = Selector::parse("img.form-control.img-fluid.bg-light.border-0").unwrap();
        let captcha_src = document
            .select(&selector)
            .next()
            .and_then(|element| element.value().attr("src"))
            .ok_or(VtopError::CaptchaRequired)?;

        if captcha_src.contains("base64,") {
            self.captcha_data = Some(captcha_src.to_string());
        } else {
            return Err(VtopError::CaptchaRequired);
        }

        Ok(())
    }

    fn get_regno(&mut self) -> VtopResult<()> {
        let document = Html::parse_document(&self.current_page.as_ref().ok_or(
            VtopError::ParseError("Current page not found at captcha extration".into()),
        )?);
        let selector = Selector::parse("input[type=hidden][name=authorizedIDX]").unwrap();
        let k = document
            .select(&selector)
            .next()
            .and_then(|element| element.value().attr("value").map(|value| value.to_string()))
            .ok_or(VtopError::RegistrationParsingError)?;

        self.username = k;
        Ok(())
    }
    async fn solve_captcha(&self, captcha_data: &str) -> VtopResult<String> {
        let url_safe_encoded = URL_SAFE.encode(captcha_data.as_bytes());
        let captcha_url = format!("https://cap.va.synaptic.gg/captcha");

        #[derive(Serialize)]
        struct PostData {
            imgstring: String,
        }

        let client_for_post = reqwest::Client::new();
        let post_data = PostData {
            imgstring: url_safe_encoded,
        };
        let response = client_for_post
            .post(captcha_url)
            .json(&post_data)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !response.status().is_success() {
            return Err(VtopError::NetworkError);
        }
        response.text().await.map_err(|_| VtopError::NetworkError)
    }
    fn extract_csrf_token(&mut self) -> VtopResult<()> {
        let document = Html::parse_document(&self.current_page.as_ref().ok_or(
            VtopError::ParseError("Current page not found at csrf extration".into()),
        )?);
        let selector = Selector::parse("input[name='_csrf']").unwrap();
        let csrf_token = document
            .select(&selector)
            .next()
            .and_then(|element| element.value().attr("value"))
            .ok_or(VtopError::ParseError("CSRF token not found".to_string()))?;
        self.session.set_csrf_token(csrf_token.to_string());
        Ok(())
    }
    async fn load_initial_page(&mut self) -> VtopResult<()> {
        let url = format!("{}/vtop/open/page", self.config.base_url);
        let response = self
            .client
            .get(url)
            .send()
            .await
            .map_err(|_| VtopError::NetworkError)?;

        if !response.status().is_success() {
            return Err(VtopError::VtopServerError);
        }
        self.current_page = Some(response.text().await.map_err(|_| VtopError::NetworkError)?);

        Ok(())
    }
    fn get_login_page_error(data: &str) -> String {
        let ptext = r#"span.text-danger.text-center[role="alert"]"#;
        let document = Html::parse_document(data);
        let selector = Selector::parse(&ptext).unwrap();
        if let Some(element) = document.select(&selector).next() {
            let error_message = element.text().collect::<Vec<_>>().join(" ");
            error_message.trim().into()
        } else {
            "Unknown login error".into()
        }
    }
}
// for building
impl VtopClient {
    pub fn with_config(
        config: VtopConfig,
        session: SessionManager,
        username: String,
        password: String,
    ) -> Self {
        #[cfg(not(target_arch = "wasm32"))]
        {
            let client = Self::make_client(session.get_cookie_store());
            Self {
                client: client,
                config: config,
                session: session,
                current_page: None,
                username: username,
                password: password,
                captcha_data: None,
            }
        }
        #[cfg(target_arch = "wasm32")]
        {
            let mut headers = HeaderMap::new();
            headers.insert(
                "Content-Type",
                HeaderValue::from_static("application/x-www-form-urlencoded"),
            );
            let client = reqwest::Client::builder()
                .default_headers(headers)
                .build()
                .unwrap();
            Self {
                client: client,
                config: config,
                session: session,
                current_page: None,
                username: username,
                password: password,
                captcha_data: None,
            }
        }
    }
    #[cfg(not(target_arch = "wasm32"))]
    fn make_client(cookie_store: Arc<Jar>) -> Client {
        let mut headers = HeaderMap::new();

        headers.insert(
            USER_AGENT,
            HeaderValue::from_static(
                "Mozilla/5.0 (Linux; U; Linux x86_64; en-US) Gecko/20100101 Firefox/130.5",
            ),
        );
        headers.insert(
            "Accept",
            HeaderValue::from_static(
                "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            ),
        );
        headers.insert(
            "Accept-Language",
            HeaderValue::from_static("en-US,en;q=0.5"),
        );
        headers.insert(
            "Content-Type",
            HeaderValue::from_static("application/x-www-form-urlencoded"),
        );
        headers.insert("Upgrade-Insecure-Requests", HeaderValue::from_static("1"));
        headers.insert("Sec-Fetch-Dest", HeaderValue::from_static("document"));
        headers.insert("Sec-Fetch-Mode", HeaderValue::from_static("navigate"));
        headers.insert("Sec-Fetch-Site", HeaderValue::from_static("same-origin"));
        headers.insert("Sec-Fetch-User", HeaderValue::from_static("?1"));
        headers.insert("Priority", HeaderValue::from_static("u=0, i"));

        let client = reqwest::Client::builder()
            .default_headers(headers)
            .cookie_store(true)
            .cookie_provider(cookie_store)
            .build()
            .unwrap();
        return client;
    }
}
