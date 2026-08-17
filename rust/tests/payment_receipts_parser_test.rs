use lib_vtop::api::vtop::parser::payment_receipts_parser::parse_payment_receipts;

/// The live VTOP receipts table has 8 columns, with the amount at index 5, the
/// campus code at index 6, and the view button in the last cell. The parser
/// used to read amount from index 2 (the invoice number) and campus from index
/// 3 (the fee group), and looked for the button in index 4, so downloads broke.
/// This locks in the correct, header-based behaviour.
#[test]
fn test_parse_payment_receipts_live_layout() {
    let html = r#"
    <table class="table table-bordered">
      <tr>
        <th>RECEIPT NUMBER</th><th>DATE</th><th>INVOICE NUMBER</th>
        <th>FEE GROUP</th><th>FEE SUBGROUP</th><th>AMOUNT</th>
        <th>CAMPUS CODE</th><th>VIEW</th>
      </tr>
      <tr>
        <td>78323</td><td>08-JUL-2026</td><td>AM2600123276</td>
        <td>HOSTEL FEE</td><td>Hostelfee_Messfee</td><td>199300.0</td><td>AMR</td>
        <td><button class="btn btn-warning" onclick="javascript:doDuplicateReceipt('78323/27/AMR');">View</button></td>
      </tr>
      <tr>
        <td>52701</td><td>25-JUN-2026</td><td>AM2600100000</td>
        <td>TUITION FEE</td><td>Tuition</td><td>8806.0</td><td>AMR</td>
        <td><button class="btn btn-warning" onclick="javascript:doDuplicateReceipt('52701/27/AMR');">View</button></td>
      </tr>
    </table>
    "#
    .to_string();

    let receipts = parse_payment_receipts(html);

    assert_eq!(receipts.len(), 2);

    assert_eq!(receipts[0].receipt_number, "78323");
    assert_eq!(receipts[0].date, "08-JUL-2026");
    assert_eq!(receipts[0].amount, "199300.0");
    assert_eq!(receipts[0].campus_code, "AMR");
    assert_eq!(receipts[0].payment_status, "Paid");
    assert_eq!(receipts[0].receipt_no, "78323/27/AMR");

    assert_eq!(receipts[1].receipt_number, "52701");
    assert_eq!(receipts[1].amount, "8806.0");
    assert_eq!(receipts[1].receipt_no, "52701/27/AMR");
}

/// A row without a duplicate-receipt button (a totals or empty-state row) must
/// be skipped, not turned into a bogus receipt.
#[test]
fn test_parse_payment_receipts_skips_rows_without_button() {
    let html = r#"
    <table class="table table-bordered">
      <tr>
        <th>RECEIPT NUMBER</th><th>DATE</th><th>INVOICE NUMBER</th>
        <th>FEE GROUP</th><th>FEE SUBGROUP</th><th>AMOUNT</th>
        <th>CAMPUS CODE</th><th>VIEW</th>
      </tr>
      <tr>
        <td></td><td></td><td></td><td></td><td>Total</td><td>199300.0</td><td></td><td></td>
      </tr>
    </table>
    "#
    .to_string();

    let receipts = parse_payment_receipts(html);
    assert!(receipts.is_empty());
}

/// Falls back to the current column positions when the header labels are not
/// the expected ones, rather than to the old (broken) positions.
#[test]
fn test_parse_payment_receipts_positional_fallback() {
    let html = r#"
    <table class="table table-bordered">
      <tr><th>a</th><th>b</th><th>c</th><th>d</th><th>e</th><th>f</th><th>g</th><th>h</th></tr>
      <tr>
        <td>78323</td><td>08-JUL-2026</td><td>AM2600123276</td>
        <td>HOSTEL FEE</td><td>Hostelfee</td><td>199300.0</td><td>AMR</td>
        <td><button onclick="doDuplicateReceipt('78323/27/AMR');">View</button></td>
      </tr>
    </table>
    "#
    .to_string();

    let receipts = parse_payment_receipts(html);
    assert_eq!(receipts.len(), 1);
    assert_eq!(receipts[0].amount, "199300.0");
    assert_eq!(receipts[0].campus_code, "AMR");
}
