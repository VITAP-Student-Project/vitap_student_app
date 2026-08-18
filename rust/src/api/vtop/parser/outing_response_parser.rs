use scraper::{Html, Selector};
use std::collections::HashSet;

/// Phrases that mark an outing outcome as OK or pending — not an error.
///
/// VTOP styles the "Waiting for ... Approval" pending status in red, which the
/// previous parser misread as an error (it treated every red span as one).
fn is_positive_outcome(text: &str) -> bool {
    let lower = text.to_lowercase();
    lower.contains("successfully") || lower.contains("waiting for") || lower.contains("accepted")
}

/// Parses the HTML response from VTOP's outing submit and delete endpoints.
///
/// VTOP no longer returns a distinct confirmation for these actions — the
/// SweetAlert popups are commented out server-side, and the save/delete handlers
/// simply reload the outing page (`$("#main-section").html(response)`). So the
/// response is the full outing page: the request form plus the `#BookingRequests`
/// table, whose status column carries per-request statuses ("Waiting for
/// Mentor's Approval" in red, "Leave Request Accepted" in green). Those are not
/// the result of the current action and must be ignored.
///
/// The result is read as: an explicit success message or genuine error rendered
/// *outside* the requests table, otherwise the reloaded page itself is taken as
/// success and `page_reload_message` is returned. Callers pass a message
/// appropriate to the action (applied vs deleted), since the HTML alone cannot
/// tell them apart.
pub fn parse_outing_response(html: String, page_reload_message: &str) -> String {
    let document = Html::parse_document(&html);

    // The status spans inside the requests table are per-request statuses, not
    // the result of this action. Collect them so they can be skipped below.
    let table_span_ids: HashSet<_> = match Selector::parse("table#BookingRequests span") {
        Ok(sel) => document.select(&sel).map(|el| el.id()).collect(),
        Err(_) => HashSet::new(),
    };

    // 1. An explicit success message shown outside the requests list: a
    //    SweetAlert heading, or a green form-level span (older VTOP responses
    //    and any delete popup that is still enabled).
    for selector in [
        "div.sweet-alert h2",
        "span[style*='color: green']",
        "span[style*='color:green']",
    ] {
        if let Ok(sel) = Selector::parse(selector) {
            for el in document.select(&sel) {
                if table_span_ids.contains(&el.id()) {
                    continue;
                }
                let text = el.text().collect::<String>().trim().to_string();
                if text.is_empty() {
                    continue;
                }
                if selector.starts_with("div.sweet-alert") || is_positive_outcome(&text) {
                    return text;
                }
            }
        }
    }

    // 2. A genuine form-level error: a red / alert message OUTSIDE the requests
    //    list that is not itself a positive outcome and not boilerplate. The
    //    pending "Waiting for ... Approval" status lives inside the table and is
    //    skipped, so it is never reported as an error.
    for selector in [
        ".alert-danger",
        ".error",
        "span[style*='color: red']",
        "span[style*='color:red']",
    ] {
        if let Ok(sel) = Selector::parse(selector) {
            for el in document.select(&sel) {
                if table_span_ids.contains(&el.id()) {
                    continue;
                }
                let text = el.text().collect::<String>().trim().to_string();
                if text.is_empty()
                    || is_positive_outcome(&text)
                    || text.contains("disciplinary measures")
                    || text.contains("logs will be retained")
                {
                    continue;
                }
                return format!("Error: {}", text);
            }
        }
    }

    // 3. The requests list came back with no form-level message — the page
    //    reloaded, which is now the normal successful outcome. The caller knows
    //    whether that means "applied" or "deleted".
    if html.contains("BookingRequests") {
        return page_reload_message.to_string();
    }

    // 3b. Only the bare form came back (no requests list, no message). This is
    //     abnormal and usually means the submission did not go through.
    if html.contains("outingForm") {
        return "Submission may have failed - the form page was returned. Please check outing history to verify.".to_string();
    }

    // 4. Nothing recognisable.
    "Unable to parse response from server. Please check outing history to verify submission."
        .to_string()
}
