use scraper::{Html, Selector};

/// Parses the HTML response from VTOP outing submission/deletion endpoints.
/// 
/// VTOP returns two types of responses:
/// 1. Weekend outing: Simple span with message like "Weekend Outing Applied Successfully"
/// 2. General outing: SweetAlert modal with h2 tag like "Leave Applied Successfully"
pub fn parse_outing_response(html: String) -> String {
    let document = Html::parse_document(&html);
    
    // Try to find weekend outing response (span with green text)
    if let Ok(span_selector) = Selector::parse("span.col-md-12") {
        for span in document.select(&span_selector) {
            let text = span.text().collect::<String>().trim().to_string();
            if !text.is_empty() && (
                text.contains("Successfully") || 
                text.contains("Applied") || 
                text.contains("Deleted")
            ) {
                return text;
            }
        }
    }
    
    // Try to find general outing response (SweetAlert h2)
    if let Ok(h2_selector) = Selector::parse("div.sweet-alert h2") {
        for h2 in document.select(&h2_selector) {
            let text = h2.text().collect::<String>().trim().to_string();
            if !text.is_empty() {
                return text;
            }
        }
    }
    
    // Fallback: try any h2 tag
    if let Ok(h2_selector) = Selector::parse("h2") {
        for h2 in document.select(&h2_selector) {
            let text = h2.text().collect::<String>().trim().to_string();
            if !text.is_empty() && (
                text.contains("Successfully") || 
                text.contains("Applied") || 
                text.contains("Deleted") ||
                text.contains("Error") ||
                text.contains("Failed")
            ) {
                return text;
            }
        }
    }
    
    // Last resort: look for any success/error indicators in the HTML
    if html.contains("Successfully") {
        if html.contains("Weekend Outing Applied") {
            return "Weekend Outing Applied Successfully".to_string();
        } else if html.contains("Weekend Outing Deleted") {
            return "Weekend Outing Deleted Successfully".to_string();
        } else if html.contains("Leave Applied") {
            return "Leave Applied Successfully".to_string();
        } else if html.contains("Deleted Successfully") {
            return "Outing Deleted Successfully".to_string();
        }
    }
    
    // If we can't parse a clean message, return a generic error
    "Unable to parse response from server. Please check outing history to verify submission.".to_string()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_weekend_outing_success() {
        let html = r#"<span class="col-md-12" style="font-size: 20px; color: green; text-align: center;">Weekend Outing Applied Successfully</span>"#;
        let result = parse_outing_response(html.to_string());
        assert_eq!(result, "Weekend Outing Applied Successfully");
    }

    #[test]
    fn test_parse_general_outing_success() {
        let html = r#"<div class="sweet-alert"><h2>Leave Applied Successfully</h2></div>"#;
        let result = parse_outing_response(html.to_string());
        assert_eq!(result, "Leave Applied Successfully");
    }

    #[test]
    fn test_parse_delete_success() {
        let html = r#"<span class="col-md-12">Weekend Outing Deleted Successfully</span>"#;
        let result = parse_outing_response(html.to_string());
        assert_eq!(result, "Weekend Outing Deleted Successfully");
    }
}
