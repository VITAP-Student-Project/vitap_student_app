use crate::api::vtop::{
    types::{
        ComprehensiveDataResponse,
        FacultyDetails, GetFaculty, GradeHistory, Marks,
        SemesterData,
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
/// A serialized JSON string containing all student data on success, or a `VtopError` on failure.
#[flutter_rust_bridge::frb()]
pub async fn fetch_all_data(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<String, VtopError> {
    // Fetch all data sequentially due to Rust borrowing rules
    let profile = client.get_student_profile().await?;
    let attendance = client.get_attendance(&semester_id).await?;
    let timetable = client.get_timetable(&semester_id).await?;
    let exam_schedule = client.get_exam_schedule(&semester_id).await?;
    let marks = client.get_marks(&semester_id).await?;

    let comprehensive_data = ComprehensiveDataResponse {
        profile,
        attendance,
        timetable,
        exam_schedule,
        marks,
    };

    serde_json::to_string(&comprehensive_data)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize comprehensive data: {}", e)))
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
) -> Result<String, VtopError> {
    let attendance_detail_records = client
        .get_attendance_detail(&semester_id, &course_id, &course_type)
        .await?;
    serde_json::to_string(&attendance_detail_records)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize detailed attendance data: {}", e)))
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_timetable(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<String, VtopError> {
    let timetable = client.get_timetable(&semester_id).await?;
    serde_json::to_string(&timetable)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize timetable data: {}", e)))
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_marks(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<String, VtopError> {
    let marks_record: Vec<Marks> = client.get_marks(&semester_id).await?;
    serde_json::to_string(&marks_record)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize marks data: {}", e)))
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_exam_shedule(
    client: &mut VtopClient,
    semester_id: String,
) -> Result<String, VtopError> {
    let exam_schedule_records = client.get_exam_schedule(&semester_id).await?;
serde_json::to_string(&exam_schedule_records)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize exam schedule data: {}", e)))
}

#[flutter_rust_bridge::frb()]
#[cfg(not(target_arch = "wasm32"))]
pub async fn fetch_cookies(client: &mut VtopClient) -> Result<Vec<u8>, VtopError> {
    client.get_cookie().await.clone()
}

#[flutter_rust_bridge::frb()]
pub fn fetch_csrf_token(client: &VtopClient) -> Option<String> {
    client.session.get_csrf_token()
}

#[flutter_rust_bridge::frb()]
pub fn fetch_username(client: &VtopClient) -> String {
    client.username.clone()
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
) -> Result<String, VtopError> {
    let biometric_records = client.get_biometric_data(date).await?;
    serde_json::to_string(&biometric_records)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize biometric data: {}", e)))
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
pub async fn fetch_weekend_outing_reports(client: &mut VtopClient) -> Result<String, VtopError> {
    let weekend_outing_records = client.get_weekend_outing_reports().await?;
    serde_json::to_string(&weekend_outing_records)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize weekend outing data: {}", e)))
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_weekend_outing_pdf(
    client: &mut VtopClient,
    booking_id: String,
) -> Result<Vec<u8>, VtopError> {
    client.get_hostel_outing_pdf(booking_id).await
}

#[flutter_rust_bridge::frb()]
pub async fn submit_general_outing_form(
    client: &mut VtopClient,
    out_place: String,
    purpose_of_visit: String,
    outing_date: String,
    out_time: String,
    in_date: String,
    in_time: String,
) -> Result<String, VtopError> {
    client
        .submit_general_outing_form(
            out_place,
            purpose_of_visit,
            outing_date,
            out_time,
            in_date,
            in_time,
        )
        .await
}

#[flutter_rust_bridge::frb()]
pub async fn submit_weekend_outing_form(
    client: &mut VtopClient,
    out_place: String,
    purpose_of_visit: String,
    outing_date: String,
    out_time: String,
    contact_number: String,
) -> Result<String, VtopError> {
    client
        .submit_weekend_outing_form(
            out_place,
            purpose_of_visit,
            outing_date,
            out_time,
            contact_number,
        )
        .await
}

#[flutter_rust_bridge::frb()]
pub async fn delete_general_outing(
    client: &mut VtopClient,
    leave_id: String,
) -> Result<String, VtopError> {
    client.delete_general_outing(leave_id).await
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_general_outing_reports(client: &mut VtopClient) -> Result<String, VtopError> {
    let general_outing_reports = client.get_general_outing_reports().await?;
    serde_json::to_string(&general_outing_reports)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize weekend outing data: {}", e)))
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
pub async fn fetch_general_outing_pdf(
    client: &mut VtopClient,
    leave_id: String,
) -> Result<Vec<u8>, VtopError> {
    client.get_general_outing_pdf(leave_id).await
}

/// Deletes a weekend outing booking from VTOP.
///
/// Cancels a previously submitted weekend outing booking.
///
/// # Examples
///
/// ```
/// let response = delete_weekend_outing(&mut client, "W24044341477".to_string()).await?;
/// ```
#[flutter_rust_bridge::frb()]
pub async fn delete_weekend_outing(
    client: &mut VtopClient,
    booking_id: String,
) -> Result<String, VtopError> {
    client.delete_weekend_outing(booking_id).await
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
pub async fn fetch_student_profile(client: &mut VtopClient) -> Result<String, VtopError> {
    let student_prof = client.get_student_profile().await?;
    serde_json::to_string(&student_prof)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize student profile data: {}", e)))
}

/// Retrieves the student's overall grade history and detailed course-wise grade records.
///
/// Returns a `GradeHistory` struct containing the student's grade history summary and course grade histories.
///
/// # Examples
///
/// ```
/// let grade_history = fetch_grade_history(&mut client).await.unwrap();
/// assert!(!grade_history.courses.is_empty());
/// ```
#[flutter_rust_bridge::frb()]
pub async fn fetch_grade_history(client: &mut VtopClient) -> Result<GradeHistory, VtopError> {
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
) -> Result<String, VtopError> {
    let pending_payment_records= client.get_pending_payment().await?;
    serde_json::to_string(&pending_payment_records)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize pending payments data: {}", e)))
}

#[flutter_rust_bridge::frb()]
pub async fn fetch_payment_receipts(
    client: &mut VtopClient,
) -> Result<String, VtopError> {
   let payment_receipts_record = client.get_payment_receipts().await?;
   serde_json::to_string(&payment_receipts_record)
        .map_err(|e| VtopError::ParseError(format!("Failed to serialize pending payments data: {}", e)))
}

/// Downloads a specific payment receipt as a PDF file.
pub async fn student_payment_receipt_download(
    client: &mut VtopClient,
    receipt_no: String,
    applno: String,
) -> Result<String, VtopError> {
    client.download_payment_receipt(receipt_no, applno).await
}
