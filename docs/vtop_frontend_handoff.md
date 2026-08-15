# VTOP Data Layer — Frontend / Rust Handoff

**Date:** 2026-08-11
**Author:** VTOP client sync + live testing pass
**How these were found:** running the client against **production VTOP** with a
real account while syncing the Python client to the Rust crate. Everything
marked **CONFIRMED** was reproduced against live VTOP on 2026-08-10/11.

## Read this first

The Flutter app fetches **all** VTOP data through the Rust bridge (`lib_vtop`);
`http` is only used for the weather API. So every issue below is in the **Rust
layer** and surfaces directly in the app. The Python client (used by the
backend) has already been fixed for each of these — the fixes are described so
they can be mirrored into Rust.

| # | Area | Severity | Status |
|---|------|----------|--------|
| 1 | Payment receipts show wrong amount + campus, downloads broken | 🔴 High | CONFIRMED live |
| 2 | Weekend outing apply is time-gated | 🟠 Medium | CONFIRMED live |
| 3 | Weekend outing submit may post empty student details | 🟠 Medium | NEEDS on-device check in-window |
| 4 | General outing apply | 🟢 OK | Verified — one note |
| 5 | Payment receipt download param quirk | 🟡 Low | Reference |
| 6 | TLS / certificate | ℹ️ None | Already handled in Rust |

---

## 1. 🔴 Payment receipts — wrong columns (CONFIRMED)

VTOP added columns to the receipts table. The Rust parser
(`payment_receipts_parser.rs`) still reads the **old** positions, so the app
shows wrong data and receipt downloads cannot start.

**Live table today (8 columns):**

| idx | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|-----|---|---|---|---|---|---|---|---|
| header | RECEIPT NUMBER | DATE | INVOICE NUMBER | FEE GROUP | FEE SUBGROUP | AMOUNT | CAMPUS CODE | VIEW |
| example | `78323` | `08-JUL-2026` | `AM2600123276` | `HOSTEL FEE` | `Hostelfee_Mess…` | `199300.0` | `AMR` | *(button)* |

**What Rust reads vs. what it should read:**

| Field | Rust reads (index) | Value it gets | Correct index | Correct value |
|-------|--------------------|---------------|---------------|---------------|
| `amount` | `tds[2]` | `AM2600123276` ❌ (invoice no.) | `tds[5]` | `199300.0` |
| `campus_code` | `tds[3]` | `HOSTEL FEE` ❌ (fee group) | `tds[6]` | `AMR` |
| `receipt_no` | button in `tds[4]` | *(no button → empty)* ❌ | button in `tds[7]` | `78323/27/AMR` |
| `receipt_number` | `tds[0]` | `78323` ✅ | `tds[0]` | `78323` |
| `date` | `tds[1]` | `08-JUL-2026` ✅ | `tds[1]` | `08-JUL-2026` |

**Impact in the app:** the receipt list shows the invoice number where the
amount should be, the fee group where the campus should be, and tapping a
receipt to download does nothing (the receipt id is empty).

**Fix (mirror the Python fix):** locate columns by **header label** rather than
fixed index, and find the receipt button anywhere in the row by its handler
(`doDuplicateReceipt('…')`) rather than a fixed cell. Skip rows that have no
such button (totals / empty-state rows) instead of erroring. Header-based
lookup is more resilient because VTOP has now reordered this table twice.

The Dart `PaymentReceipt` model already has the right fields
(`receipt_number`, `date`, `amount`, `campus_code`, `payment_status`,
`receipt_no`) — no model change needed once Rust returns correct values.

---

## 2. 🟠 Weekend outing apply — eligibility window (CONFIRMED)

The weekend outing form is only served **Tuesday 12:00 AM → Friday 11:59 PM**.
Outside that window VTOP returns the page with the form body **not rendered** —
it carries only a message:

> "You are eligible to fill this form from Tuesday 12:00AM to Friday 11:59PM"

Captured on a Monday, the weekend form had **none** of the student fields
(`regNo`, `name`, `hostelBlock`, `roomNo`, …). So any submit attempt outside
the window cannot build a valid request.

**What the app should do:**
- Gate the "Apply for weekend outing" UI to the Tue–Fri window, or
- Detect the eligibility message and show it to the user instead of a generic
  failure. The Rust form parser returns a "missing registration number" error
  in this state — surface that as "weekend outing is only open Tue–Fri", not as
  a network/parse error.

(The general outing form has **no** such time gate.)

---

## 3. 🟠 Weekend outing submit — verify student details in-window (NEEDS CHECK)

This one could not be fully verified because today is outside the weekend
window. **Please verify on-device during Tue–Fri:**

The Rust `submit_weekend_outing_form` fills `name`, `hostelBlock`, `roomNo`,
`applicationNo`, `gender`, `parentContactNumber` from the fetched form. If, even
**inside** the eligibility window, the weekend form does not render those
inputs, the submit will POST them **empty**, and VTOP may silently reject the
request or file it with blank hostel details.

**To verify:** during the window, apply for a weekend outing and confirm the
saved request in "Outing Reports" shows the correct hostel block / room. If they
come back blank, the weekend form renders those fields somewhere the parser
isn't looking (they may be in a different element than the general form's
`<input id="…">`).

---

## 4. 🟢 General outing apply — data is correct (VERIFIED, one note)

The general outing submit posts the right fields. Field names were verified
against the **live** form:

`authorizedID, LeaveId(empty), regNo, name, applicationNo, gender, hostelBlock,
roomNo, placeOfVisit, purposeOfVisit, outDate, outTimeHr, outTimeMin, inDate,
inTimeHr, inTimeMin, parentContactNumber, _csrf, x`

**Note:** the live general form has **no** `parentContactNumber` input, so that
field is posted **empty**. This is expected — VTOP does not collect a parent
contact for general outings. The app should not require or display a parent
contact field for general outings.

**Time format:** `outTime` / `inTime` are split into `HH` and `MM`. The hour
dropdowns only offer whole hours (06, 07, …). Make sure the app sends a
2-digit hour and minute.

> ⚠️ The actual submit was **not** executed against live VTOP (that would file a
> real leave request). Correctness here is verified by matching every posted
> field name to the live form's inputs, not by a completed round-trip.

---

## 5. 🟡 Payment receipt download — parameter quirk (REFERENCE)

If/when the app wires up "download receipt" (`download_payment_receipt` in
Rust), note the endpoint `/vtop/finance/dupReceiptNewP2P` expects:

- `receitNo` — **misspelled on VTOP's side**, do not "correct" it to `receiptNo`.
- `applno` — the student's **application number** (from the profile).
- `receitNo` value looks like `78323/27/AMR` (the `receipt_no` field).

VTOP returns the receipt as an **HTML page**, not a PDF.

---

## 6. ℹ️ TLS / certificate — already handled in Rust (no action)

For completeness: VTOP's server omits the Sectigo intermediate CA from its TLS
chain. The Rust crate already handles this — it bundles the intermediate
(`VITAP_CUSTOM_CERT_PEM`) and adds it to its rustls root store, so native builds
verify correctly. No frontend action needed.

(The Python client had to add the same bundled cert to connect at all; that is
done. If any **other** Python tooling talks to VTOP and fails with
`CERTIFICATE_VERIFY_FAILED`, this is why.)

---

## Appendix — how to re-verify these

All of the above were found with a small live harness against production VTOP.
To reproduce (needs a real login; VTOP may send an OTP):

1. Fetch the receipts page (`/vtop/p2p/getReceiptsApplno`) and print the table
   header row — confirm the 8-column layout above.
2. Fetch the weekend outing page (`/vtop/hostel/StudentWeekendOuting`) on a
   Monday vs. a Wednesday — confirm the form only renders mid-week.
3. Fetch the general outing page (`/vtop/hostel/StudentGeneralOuting`) and list
   the `<input>` ids — confirm no `parentContactNumber`.
