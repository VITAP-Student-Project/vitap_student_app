use lib_vtop::api::vtop::parser::attendance_parser::has_capstone_attendance;
use lib_vtop::api::vtop::parser::capstone_attendance_parser::parse_capstone_attendance;

/// The shape `processSdpAttendance` actually returns: a registration info table,
/// a tally table whose last column is a "View" button rather than data, and the
/// day-by-day calendar under a stable id. The calendar's "Description" column is
/// commented out by VTOP in both the header and every row.
fn response() -> String {
    r#"
    <!-- <table class="table table-bordered">
           <tr><th>Title</th><td th:text="${sdp.title}">TEMPLATE</td></tr>
         </table> -->
    <table class="table table-bordered">
      <tr><th>Title</th><td>Capstone</td></tr>
      <tr><th>Guide Evaluation Status</th><td>Registered, Invoice Generated,</td></tr>
      <tr><th>Date of Registration</th><td>2026-07-06 00:00:00.0</td></tr>
    </table>
    <table class="table table-bordered text-center">
      <tr>
        <th>Present</th><th>On Duty (OD)</th><th>Absent</th>
        <th>Percentage</th><th>Punch Details</th>
      </tr>
      <tr>
        <td>14</td><td>4</td><td>12</td><td>60%</td>
        <td><button class="btn btn-primary">View</button></td>
      </tr>
    </table>
    <table id="sdpCalendarTable" class="table table-bordered table-hover">
      <tr>
        <th>Sl.No.</th><th>Date</th><th>Day</th><th>Day Type</th>
        <!-- <th>Description</th> -->
        <th>Status</th><th>Punch Time</th>
      </tr>
      <tr><td>1</td><td>17-07-2026</td><td>FRIDAY</td><td>Instructional</td><td>Absent</td><td>-</td></tr>
      <tr><td>2</td><td>18-07-2026</td><td>SATURDAY</td><td>Instructional</td><td>Present</td><td>09:14:22</td></tr>
      <tr><td>3</td><td>19-07-2026</td><td>SUNDAY</td><td>Holiday</td><td>-</td><td>-</td></tr>
    </table>
    "#
    .to_string()
}

#[test]
fn test_parses_info_summary_and_punches() {
    let attendance = parse_capstone_attendance(response()).expect("summary table present");

    assert_eq!(attendance.info.title, "Capstone");
    assert_eq!(
        attendance.info.guide_evaluation_status,
        "Registered, Invoice Generated,"
    );
    assert_eq!(
        attendance.info.date_of_registration,
        "2026-07-06 00:00:00.0"
    );

    // The three counts stay separate: an on-duty day is neither attended nor
    // absent, and folding them into attended/total throws that away.
    assert_eq!(attendance.summary.present, "14");
    assert_eq!(attendance.summary.on_duty, "4");
    assert_eq!(attendance.summary.absent, "12");

    assert_eq!(attendance.punches.len(), 3);
    assert_eq!(attendance.punches[0].date, "17-07-2026");
    assert_eq!(attendance.punches[0].day, "FRIDAY");
    assert_eq!(attendance.punches[0].day_type, "Instructional");
    assert_eq!(attendance.punches[1].punch_time, "09:14:22");
}

/// The percentage arrives as "60%". Leaving the sign on it makes
/// `double.tryParse` return null on the Dart side, which rendered as 0% and
/// silently disabled the low-attendance warning.
#[test]
fn test_percentage_sign_is_stripped() {
    let attendance = parse_capstone_attendance(response()).unwrap();
    assert_eq!(attendance.summary.percentage, "60");
    assert_eq!(attendance.summary.percentage.parse::<f64>().unwrap(), 60.0);
}

/// VTOP writes "-" for a status that does not exist (a holiday) and for a punch
/// that never happened. Rendering that dash verbatim showed rows reading "-" as
/// though it were an attendance status.
#[test]
fn test_placeholder_dashes_become_empty() {
    let attendance = parse_capstone_attendance(response()).unwrap();

    // Absent day: real status, no punch.
    assert_eq!(attendance.punches[0].status, "Absent");
    assert_eq!(attendance.punches[0].punch_time, "");

    // Holiday: neither.
    assert_eq!(attendance.punches[2].status, "");
    assert_eq!(attendance.punches[2].punch_time, "");
}

/// Columns are found by header label, never by index. Index-based table reads
/// have twice shifted every field by one when VTOP added a column — once in
/// payments, once in attendance detail.
#[test]
fn test_columns_are_located_by_header_not_index() {
    let html = r#"
    <table>
      <tr><th>Absent</th><th>Percentage</th><th>Present</th><th>On Duty (OD)</th></tr>
      <tr><td>12</td><td>60%</td><td>14</td><td>4</td></tr>
    </table>
    <table id="sdpCalendarTable">
      <tr><th>Status</th><th>Sl.No.</th><th>Punch Time</th><th>Day Type</th><th>Date</th><th>Day</th></tr>
      <tr><td>Present</td><td>1</td><td>09:14:22</td><td>Instructional</td><td>17-07-2026</td><td>FRIDAY</td></tr>
    </table>
    "#
    .to_string();

    let attendance = parse_capstone_attendance(html).unwrap();

    assert_eq!(attendance.summary.present, "14");
    assert_eq!(attendance.summary.on_duty, "4");
    assert_eq!(attendance.summary.absent, "12");
    assert_eq!(attendance.summary.percentage, "60");

    assert_eq!(attendance.punches[0].serial, "1");
    assert_eq!(attendance.punches[0].date, "17-07-2026");
    assert_eq!(attendance.punches[0].status, "Present");
    assert_eq!(attendance.punches[0].punch_time, "09:14:22");
}

/// A student with no capstone registration gets a response with no summary
/// table. That is the signal to show nothing at all, not an empty capstone.
#[test]
fn test_missing_summary_yields_none() {
    assert!(parse_capstone_attendance("<html></html>".to_string()).is_none());
    assert!(parse_capstone_attendance(
        r#"<table><tr><th>Title</th><td>Capstone</td></tr></table>"#.to_string()
    )
    .is_none());
}

/// Rows that do not lead with a numeric serial are spacers or repeated headers,
/// and short or empty rows must be skipped rather than read out of bounds — the
/// earlier implementation sliced a day name to three characters and panicked on
/// a row where it was empty.
#[test]
fn test_malformed_calendar_rows_are_skipped() {
    let html = r#"
    <table>
      <tr><th>Present</th><th>Absent</th></tr>
      <tr><td>1</td><td>0</td></tr>
    </table>
    <table id="sdpCalendarTable">
      <tr><th>Sl.No.</th><th>Date</th><th>Day</th><th>Day Type</th><th>Status</th><th>Punch Time</th></tr>
      <tr><td>Total</td><td>&nbsp;</td></tr>
      <tr><td></td><td></td></tr>
      <tr><td>1</td><td>17-07-2026</td><td></td></tr>
    </table>
    "#
    .to_string();

    let attendance = parse_capstone_attendance(html).unwrap();

    assert_eq!(attendance.punches.len(), 1);
    assert_eq!(attendance.punches[0].serial, "1");
    // Columns the short row never reached come back empty, not panicking.
    assert_eq!(attendance.punches[0].day, "");
    assert_eq!(attendance.punches[0].status, "");
}

/// The capstone request is only worth making when the attendance page offers
/// the button, so the match has to be on the whole label — a substring match
/// would fire on any button mentioning attendance.
#[test]
fn test_capstone_button_detection() {
    assert!(has_capstone_attendance(
        r#"<button class="btn btn-primary">View CAPSTONE/SDP Attendance</button>"#
    ));
    // Whitespace and newlines inside the label are collapsed before matching.
    assert!(has_capstone_attendance(
        "<button>\n\t View CAPSTONE/SDP  Attendance \n</button>"
    ));

    assert!(!has_capstone_attendance(
        r#"<button class="btn">View Attendance Detail</button>"#
    ));
    assert!(!has_capstone_attendance("<html></html>"));
}
