use crate::api::vtop::types::paid_payment_receipt::PaidPaymentReceipt;
use scraper::{Html, Selector};

/// Parses an HTML string to extract payment receipt information from a table.
///
/// Searches for the first table with the class `table table-bordered` in the provided HTML,
/// then iterates over its rows (excluding the header) to extract receipt details. For each row
/// with at least five columns, it collects the receipt number, date, amount, campus code, and
/// attempts to parse the receipt number from a button's `onclick` attribute. Each parsed row
/// is converted into a `PaymentReceipt` with a fixed payment status of "Paid".
///
/// # Returns
/// A vector of `PaymentReceipt` structs containing the extracted data. Rows missing required
/// fields or elements are skipped.
///
/// # Examples
///
/// ```
/// let html = r#"
/// <table class="table table-bordered">
///   <tr><th>Receipt No</th><th>Date</th><th>Amount</th><th>Campus</th><th>Action</th></tr>
///   <tr>
///     <td>12345</td><td>2024-01-01</td><td>1000</td><td>ABC</td>
///     <td><button onclick="javascript:doDuplicateReceipt('12345/2024/ABC');"></button></td>
///   </tr>
/// </table>
/// "#.to_string();
/// let receipts = parse_payment_receipts(html);
/// assert_eq!(receipts.len(), 1);
/// assert_eq!(receipts[0].receipt_number, "12345");
/// assert_eq!(receipts[0].receipt_no, "12345/2024/ABC");
/// ```
pub fn parse_payment_receipts(html: String) -> Vec<PaidPaymentReceipt> {
    let doc = Html::parse_document(&html);
    let mut results = Vec::new();

    // Find the main receipts table
    let table_selector = Selector::parse("table.table.table-bordered").unwrap();
    if let Some(table) = doc.select(&table_selector).next() {
        let row_selector = Selector::parse("tr").unwrap();
        for row in table.select(&row_selector).skip(1) {
            // skip header
            let tds: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
            if tds.len() >= 5 {
                let receipt_number = tds[0].text().collect::<String>().trim().to_string();
                let date = tds[1].text().collect::<String>().trim().to_string();
                let amount = tds[2].text().collect::<String>().trim().to_string();
                let campus_code = tds[3].text().collect::<String>().trim().to_string();

                // Extract receipt_no from button's onclick
                let mut receipt_no = String::new();
                if let Some(button) = tds[4].select(&Selector::parse("button").unwrap()).next() {
                    if let Some(onclick) = button.value().attr("onclick") {
                        // Example: javascript:doDuplicateReceipt('27640/26/AMR');
                        let prefix = "doDuplicateReceipt('";
                        let suffix = "')";
                        if let Some(start) = onclick.find(prefix) {
                            let rest = &onclick[start + prefix.len()..];
                            if let Some(end) = rest.find(suffix) {
                                receipt_no = rest[..end].to_string();
                            }
                        }
                    }
                }

                results.push(PaidPaymentReceipt {
                    receipt_number,
                    date,
                    amount,
                    campus_code,
                    payment_status: "Paid".to_string(),
                    receipt_no,
                });
            }
        }
    }

    results
}
