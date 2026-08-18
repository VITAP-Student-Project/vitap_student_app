use lib_vtop::api::vtop::parser::outing_response_parser::parse_outing_response;

const APPLIED: &str = "Outing applied successfully. It is now waiting for approval.";
const DELETED: &str = "Outing request deleted successfully.";

/// The reported bug: after applying, VTOP reloads the outing page and the newly
/// applied request shows the pending status "Waiting for Mentor's Approval" in a
/// red span inside the requests table. That is a pending status, not an error,
/// and must not be reported as one.
#[test]
fn test_pending_status_in_requests_table_is_not_an_error() {
    let html = r#"
    <div id="main-section">
      <form id="outingForm"><h3>General Outing Request</h3></form>
      <table id="BookingRequests">
        <tr><th>S.No</th><th>Place</th><th>Status</th></tr>
        <tr>
          <td>1</td><td>Vijayawada</td>
          <td><span><span style="color: red">Waiting for Mentor's Approval</span></span></td>
        </tr>
      </table>
    </div>
    "#
    .to_string();

    let result = parse_outing_response(html, APPLIED);

    assert_eq!(result, APPLIED);
    assert!(!result.contains("Error"));
}

/// Weekend applies show "Waiting for Warden's Approval" — same story.
#[test]
fn test_weekend_pending_status_is_not_an_error() {
    let html = r#"
    <div id="main-section">
      <form id="outingForm"><h3>Weekend Outing Request</h3></form>
      <table id="BookingRequests">
        <tr><th>S.No</th><th>Status</th></tr>
        <tr><td>1</td><td><span style="color: red">Waiting for Warden's Approval</span></td></tr>
      </table>
    </div>
    "#
    .to_string();

    let result = parse_outing_response(html, APPLIED);
    assert_eq!(result, APPLIED);
}

/// An accepted request in the list (green) is also a status, not the result of
/// the current action — it must not leak out as the message either.
#[test]
fn test_accepted_status_in_table_does_not_leak() {
    let html = r#"
    <div id="main-section">
      <table id="BookingRequests">
        <tr><td>1</td><td><span style="color: green;">Leave Request Accepted</span></td></tr>
      </table>
    </div>
    "#
    .to_string();

    assert_eq!(parse_outing_response(html, APPLIED), APPLIED);
}

/// A genuine validation error is rendered outside the requests table and must
/// still be surfaced as an error.
#[test]
fn test_genuine_error_outside_table_is_reported() {
    let html = r#"
    <div id="main-section">
      <span style="color: red">You have already applied for this date</span>
      <table id="BookingRequests">
        <tr><td>1</td><td><span style="color: red">Waiting for Mentor's Approval</span></td></tr>
      </table>
    </div>
    "#
    .to_string();

    let result = parse_outing_response(html, APPLIED);
    assert!(result.contains("Error:"), "got: {result}");
    assert!(result.contains("already applied"));
}

/// Delete reloads the same page; the caller supplies the delete message.
#[test]
fn test_delete_returns_delete_message() {
    let html = r#"
    <div id="main-section">
      <form id="outingForm"><h3>General Outing Request</h3></form>
      <table id="BookingRequests"><tr><th>S.No</th></tr></table>
    </div>
    "#
    .to_string();

    assert_eq!(parse_outing_response(html, DELETED), DELETED);
}

// --- Backward-compatible cases (explicit success / error messages) ----------

#[test]
fn test_parse_weekend_outing_success() {
    let html = r#"<span class="col-md-12" style="font-size: 20px; color: green; text-align: center;">Weekend Outing Applied Successfully</span>"#;
    assert_eq!(
        parse_outing_response(html.to_string(), APPLIED),
        "Weekend Outing Applied Successfully"
    );
}

#[test]
fn test_parse_general_outing_success() {
    let html = r#"<div class="sweet-alert"><h2>Leave Applied Successfully</h2></div>"#;
    assert_eq!(
        parse_outing_response(html.to_string(), APPLIED),
        "Leave Applied Successfully"
    );
}

#[test]
fn test_parse_delete_success() {
    let html = r#"<span class="col-md-12" style="color: green;">Weekend Outing Deleted Successfully</span>"#;
    assert_eq!(
        parse_outing_response(html.to_string(), DELETED),
        "Weekend Outing Deleted Successfully"
    );
}

#[test]
fn test_parse_form_page_returned() {
    let html =
        r#"<html><body><form id="outingForm"><h3>Weekend Outing Request</h3></form></body></html>"#;
    let result = parse_outing_response(html.to_string(), APPLIED);
    assert!(result.contains("failed") || result.contains("verify"));
}

#[test]
fn test_parse_error_message() {
    let html = r#"<span style="color: red;">Invalid date range selected</span>"#;
    let result = parse_outing_response(html.to_string(), APPLIED);
    assert!(result.contains("Error:"));
}
