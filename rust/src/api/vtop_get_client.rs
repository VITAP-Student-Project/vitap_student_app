use crate::api::vtop::{
    types::{
        AttendanceDetailRecord, BiometricRecord, ComprehensiveDataResponse,
        FacultyDetails, GetFaculty, GradeHistory, HostelLeaveData, HostelOutingData, MarksRecord,
        PaidPaymentReceipt, PendingPaymentReceipt, PerExamScheduleRecord, SemesterData,
        StudentProfile, Timetable,
    },
    vtop_client::{VtopClient, VtopError},
    vtop_config::VtopClientBuilder,
    wifi::*,
};

#[flutter_rust_bridge::frb(sync)]
pub fn get_vtop_client(username: String, password: String) -> VtopClient {
    VtopClientBuilder::new().build(username, password)
}

#[flutter_rust_bridge::frb()]
pub async fn vtop_client_login(client: &mut VtopClient) -> Result<(), VtopError> {
    client.login().await
}
#[flutter_rust_bridge::frb()]
pub async fn fetch_semesters(client: &mut VtopClient) -> Result<SemesterData, VtopError> {
    client.get_semesters().await
}

/// Fetches comprehensive student data including profile, attendance, timetable,
/// exam schedule, grade history, and marks for a specific semester.
///
/// This function consolidates multiple API calls into a single request, providing
/// all essential student data in one response structure.
///
/// # Returns
/// A `ComprehensiveDataResponse` containing all student data on success, or a `VtopError` on failure.
#[flutter_rust_bridge::frb()]
pub async fn fetch_all_data(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<ComprehensiveDataResponse, VtopError> {
    // Fetch all data sequentially due to Rust borrowing rules
    let profile = client.get_student_profile().await?;
    let attendance = client.get_attendance(&semester_id).await?;
    let timetable = client.get_timetable(&semester_id).await?;
    let exam_schedule = client.get_exam_schedule(&semester_id).await?;
    let (_grade_history, grade_course_history) = client.get_grade_history().await?;
    let marks = client.get_marks(&semester_id).await?;

    Ok(ComprehensiveDataResponse {
        profile,
        attendance,
        timetable,
        exam_schedule,
        grade_course_history,
        marks,
    })
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_attendance(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<String, VtopError> {
    let attendance_records = client.get_attendance(&semester_id).await?;
    serde_json::to_string(&attendance_records)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize attendance data: {}", e)))
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_attendance_detail(
    client: &mut VtopClient,
    semester_id: String,
    course_id: String,
    course_type: String,
) -> Result<Vec<AttendanceDetailRecord>, VtopError> {
    client
        .get_attendance_detail(&semester_id, &course_id, &course_type)
        .await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_timetable(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<Timetable, VtopError> {
    client.get_timetable(&semester_id).await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_marks(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<Vec<MarksRecord>, VtopError> {
    client.get_marks(&semester_id).await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_exam_shedule(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<Vec<PerExamScheduleRecord>, VtopError> {
    client.get_exam_schedule(&semester_id).await
}

#[flutter_rust_bridge::frb()]
#[cfg(not(target_arch = "wasm32"))]
pub async fn fetch_cookies(client: &mut VtopClient) -> Result<Vec<u8>, VtopError> {
    client.get_cookie().await.clone()
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_is_auth(client: &mut VtopClient) -> bool {
    client.is_authenticated().clone()
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_wifi(username: String, password: String, i: i32) -> (bool, String) {
    university_wifi_login_logout(i, username, password).await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_biometric_data(
    client: &mut VtopClient,
    date: String,
) -> Result<Vec<BiometricRecord>, VtopError> {
    client.get_biometric_data(date).await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_faculty_search(
    client: &mut VtopClient,
    search_term: String,
) -> Result<GetFaculty, VtopError> {
    client.get_faculty_search(search_term).await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_faculty_data(
    client: &mut VtopClient,
    emp_id: String,
) -> Result<FacultyDetails, VtopError> {
    client.get_faculty_data(emp_id).await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_hostel_report(client: &mut VtopClient) -> Result<HostelOutingData, VtopError> {
    client.get_hostel_report().await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_hostel_outing(
    client: &mut VtopClient,
    booking_id: String,
) -> Result<Vec<u8>, VtopError> {
    client.get_hostel_outing_pdf(booking_id).await
}

#[flutter_rust_bridge::frb()]
pub async fn submit_hostel_outing_form(
    client: &mut VtopClient,
    purpose_of_visit: String,
    outing_date: String,
    contact_number: String,
    out_place: String,
    out_time: String,
) -> Result<String, VtopError> {
    client
        .submit_outing_form(
            purpose_of_visit,
            outing_date,
            contact_number,
            out_place,
            out_time,
        )
        .await
}

#[flutter_rust_bridge::frb()]
pub async fn leave_report(client: &mut VtopClient) -> Result<HostelLeaveData, VtopError> {
    client.get_hostel_leave_report().await
}

/// Downloads the PDF report for a specific hostel leave request.
///
/// Returns the PDF file as a byte vector if successful, or a `VtopError` on failure.
///
/// # Examples
///
/// ```
/// let pdf_bytes = leave_report_download(&mut client, "LEAVE123".to_string()).await?;
/// assert!(!pdf_bytes.is_empty());
/// ```
#[flutter_rust_bridge::frb()]
pub async fn leave_report_download(
    client: &mut VtopClient,
    leave_id: String,
) -> Result<Vec<u8>, VtopError> {
    client.get_hostel_leave_pdf(leave_id).await
}

/// Retrieves the complete student profile for the authenticated user.
///
/// Returns a `StudentProfile` containing detailed profile information on success, or a `VtopError` if the operation fails.
///
/// # Examples
///
/// ```
/// let mut client = get_vtop_client("username".to_string(), "password".to_string());
/// let profile = student_profile(&mut client).await.unwrap();
/// assert_eq!(profile.name, "John Doe");
/// ```
#[flutter_rust_bridge::frb()]
pub async fn fetch_student_profile(client: &mut VtopClient) -> Result<StudentProfile, VtopError> {
    client.get_student_profile().await
}

/// Retrieves the student's overall grade history and detailed course-wise grade records.
///
/// Returns a tuple containing the student's grade history summary and a list of individual course grade histories.
///
/// # Examples
///
/// ```
/// let (grade_history, course_histories) = student_grade_history(&mut client).await.unwrap();
/// assert!(!course_histories.is_empty());
/// ```
#[flutter_rust_bridge::frb()]
pub async fn fetch_grade_history(
    client: &mut VtopClient,
) -> Result<
    (
        GradeHistory,
        Vec<crate::api::vtop::types::GradeCourseHistory>,
    ),
    VtopError,
> {
    client.get_grade_history().await
}

/// Retrieves a list of pending payments for the student.
///
/// Returns a vector of `PendingPaymentReceipt` records on success, or a `VtopError` if the operation fails.
///
/// # Examples
///
/// ```
/// let payments = student_pending_payments(&mut client).await?;
/// assert!(!payments.is_empty() || payments.is_empty());
/// ```
#[flutter_rust_bridge::frb()]
pub async fn fetch_pending_payments(
    client: &mut VtopClient,
) -> Result<Vec<PendingPaymentReceipt>, VtopError> {
    client.get_pending_payment().await
}

/// Retrieves the student's payment receipt records.
///
/// Returns a vector of `PaidPaymentReceipt` objects on success, or a `VtopError` if retrieval fails.
///
/// # Examples
///
/// ```
/// let receipts = student_payment_receipts(&mut client).await?;
/// assert!(!receipts.is_empty());
/// ```
#[flutter_rust_bridge::frb()]
pub async fn fetch_payment_receipts(
    client: &mut VtopClient,
) -> Result<Vec<PaidPaymentReceipt>, VtopError> {
    client.get_payment_receipts().await
}

/// Downloads a specific payment receipt as a PDF file.
pub async fn student_payment_receipt_download(
    client: &mut VtopClient,
    receipt_no: String,
    applno: String,
) -> Result<String, VtopError> {
    client.download_payment_receipt(receipt_no, applno).await
}
