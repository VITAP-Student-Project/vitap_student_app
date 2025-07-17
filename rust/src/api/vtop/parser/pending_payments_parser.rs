use crate::api::vtop::types::PendingPaymentReceipt;
use scraper::{Html, Selector};

/// Parses pending payment details from an HTML string.
///
/// Extracts rows from a specific table in the HTML and returns a vector of `PendingPayment` structs,
/// each populated with serial number, fee preference number, fee heads, end date, amount, fine,
/// total amount, and a fixed payment status of "Unpaid".
///
/// # Examples
///
/// ```
/// let html = r#"
/// <table class="table table-bordered table-responsive table-hover">
///   <tr>
///     <th>S.No</th><th>FPrefNo</th><th>Fees Heads</th><th>End Date</th>
///     <th>Amount</th><th>Fine</th><th>Total Amount</th><th>Status</th>
///   </tr>
///   <tr>
///     <td>1</td><td>12345</td><td>Tuition</td><td>2024-06-30</td>
///     <td>10000</td><td>0</td><td>10000</td><td>Unpaid</td>
///   </tr>
/// </table>
/// "#;
/// let payments = parse_pending_payments(html.to_string());
/// assert_eq!(payments.len(), 1);
/// assert_eq!(payments[0].payment_status, "Unpaid");
/// ```
pub fn parse_pending_payments(html: String) -> Vec<PendingPaymentReceipt> {
    let doc = Html::parse_document(&html);
    let mut results = Vec::new();

    // Find the main table with pending payments
    let table_selector =
        Selector::parse("table.table.table-bordered.table-responsive.table-hover").unwrap();
    if let Some(table) = doc.select(&table_selector).next() {
        let row_selector = Selector::parse("tr").unwrap();
        for row in table.select(&row_selector).skip(1) {
            // skip header
            let tds: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
            if tds.len() >= 8 {
                let s_no = tds[0].text().collect::<String>().trim().to_string();
                let fprefno = tds[1].text().collect::<String>().trim().to_string();
                let fees_heads = tds[2].text().collect::<String>().trim().to_string();
                let end_date = tds[3].text().collect::<String>().trim().to_string();
                let amount = tds[4].text().collect::<String>().trim().to_string();
                let fine = tds[5].text().collect::<String>().trim().to_string();
                let total_amount = tds[6].text().collect::<String>().trim().to_string();
                // Payment status is always "Unpaid" for pending payments
                results.push(PendingPaymentReceipt {
                    s_no,
                    fprefno,
                    fees_heads,
                    end_date,
                    amount,
                    fine,
                    total_amount,
                    payment_status: "Unpaid".to_string(),
                });
            }
        }
    }

    results
}
