use crate::api::vtop::types::paid_payment_receipt::PaidPaymentReceipt;
use scraper::{ElementRef, Html, Selector};
use std::collections::HashMap;

/// Parses an HTML string to extract paid payment receipts from the receipts table.
///
/// Columns are located by their **header label** rather than a fixed position,
/// because VTOP has reordered and inserted columns in this table over time
/// (invoice number, fee group and fee subgroup now sit between the receipt
/// number and the amount). Positional fallbacks keep it working if the headers
/// ever change again.
///
/// The receipt number needed for the duplicate-receipt download lives in the
/// row's view button, which is located by its `doDuplicateReceipt(...)` handler
/// rather than a fixed cell. Rows without such a button (totals or empty-state
/// rows) are skipped rather than treated as receipts.
///
/// # Returns
/// A vector of `PaidPaymentReceipt` structs, one per receipt row.
///
/// # Examples
///
/// ```
/// let html = r#"
/// <table class="table table-bordered">
///   <tr>
///     <th>RECEIPT NUMBER</th><th>DATE</th><th>INVOICE NUMBER</th>
///     <th>FEE GROUP</th><th>FEE SUBGROUP</th><th>AMOUNT</th>
///     <th>CAMPUS CODE</th><th>VIEW</th>
///   </tr>
///   <tr>
///     <td>78323</td><td>08-JUL-2026</td><td>AM2600123276</td>
///     <td>HOSTEL FEE</td><td>Hostelfee</td><td>199300.0</td><td>AMR</td>
///     <td><button onclick="javascript:doDuplicateReceipt('78323/27/AMR');"></button></td>
///   </tr>
/// </table>
/// "#.to_string();
/// let receipts = lib_vtop::api::vtop::parser::payment_receipts_parser::parse_payment_receipts(html);
/// assert_eq!(receipts.len(), 1);
/// assert_eq!(receipts[0].receipt_number, "78323");
/// assert_eq!(receipts[0].amount, "199300.0");
/// assert_eq!(receipts[0].campus_code, "AMR");
/// assert_eq!(receipts[0].receipt_no, "78323/27/AMR");
/// ```
pub fn parse_payment_receipts(html: String) -> Vec<PaidPaymentReceipt> {
    let doc = Html::parse_document(&html);
    let mut results = Vec::new();

    let table_selector = Selector::parse("table.table.table-bordered").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let header_cell_selector = Selector::parse("td, th").unwrap();
    let td_selector = Selector::parse("td").unwrap();
    let button_selector = Selector::parse("button").unwrap();

    let table = match doc.select(&table_selector).next() {
        Some(t) => t,
        None => return results,
    };

    let rows: Vec<_> = table.select(&row_selector).collect();
    if rows.is_empty() {
        return results;
    }

    // Map header labels (upper-cased) to their column positions.
    let mut header_index: HashMap<String, usize> = HashMap::new();
    for (i, cell) in rows[0].select(&header_cell_selector).enumerate() {
        let label = cell.text().collect::<String>().trim().to_uppercase();
        header_index.insert(label, i);
    }
    // Fallbacks are the *current* live positions, so an unrecognised header set
    // still reads the right columns rather than the old (pre-change) ones.
    let idx = |name: &str, default: usize| *header_index.get(name).unwrap_or(&default);
    let i_receipt = idx("RECEIPT NUMBER", 0);
    let i_date = idx("DATE", 1);
    let i_amount = idx("AMOUNT", 5);
    let i_campus = idx("CAMPUS CODE", 6);

    for row in rows.iter().skip(1) {
        let tds: Vec<_> = row.select(&td_selector).collect();
        if tds.len() < 5 {
            continue;
        }

        // Find the duplicate-receipt button anywhere in the row.
        let mut receipt_no = String::new();
        for button in row.select(&button_selector) {
            if let Some(onclick) = button.value().attr("onclick") {
                if onclick.contains("doDuplicateReceipt") {
                    receipt_no = extract_receipt_no(onclick);
                    break;
                }
            }
        }
        // No download button means this is not a receipt row (totals, notices).
        if receipt_no.is_empty() {
            continue;
        }

        let cell = |i: usize| tds.get(i).map(cell_text).unwrap_or_default();

        results.push(PaidPaymentReceipt {
            receipt_number: cell(i_receipt),
            date: cell(i_date),
            amount: cell(i_amount),
            campus_code: cell(i_campus),
            payment_status: "Paid".to_string(),
            receipt_no,
        });
    }

    results
}

/// Collapses a cell's text and trims surrounding whitespace.
fn cell_text(cell: &ElementRef) -> String {
    cell.text().collect::<String>().trim().to_string()
}

/// Extracts the id from a `doDuplicateReceipt('78323/27/AMR')` handler.
fn extract_receipt_no(onclick: &str) -> String {
    let prefix = "doDuplicateReceipt('";
    let suffix = "')";
    if let Some(start) = onclick.find(prefix) {
        let rest = &onclick[start + prefix.len()..];
        if let Some(end) = rest.find(suffix) {
            return rest[..end].to_string();
        }
    }
    String::new()
}
