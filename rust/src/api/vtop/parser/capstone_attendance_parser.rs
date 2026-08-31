use crate::api::vtop::types::capstone_attendance::*;
use scraper::{ElementRef, Html, Selector};
use std::collections::HashMap;

/// VTOP renders "nothing here" as a dash: no status on a holiday, no punch on
/// an absent day. Normalised to an empty string so callers can just check
/// whether the field is empty.
const PLACEHOLDER: &str = "-";

/// Collapses the heavy tab/newline whitespace VTOP pads cells with.
fn clean(element: &ElementRef) -> String {
    element
        .text()
        .collect::<String>()
        .split_whitespace()
        .collect::<Vec<_>>()
        .join(" ")
}

fn value(text: String) -> String {
    if text == PLACEHOLDER {
        String::new()
    } else {
        text
    }
}

fn cells<'a>(row: &ElementRef<'a>) -> Vec<ElementRef<'a>> {
    let selector = Selector::parse("td, th").unwrap();
    row.select(&selector).collect()
}

/// Maps lower-cased header labels to their column positions.
fn header_index(row: &ElementRef) -> HashMap<String, usize> {
    cells(row)
        .iter()
        .enumerate()
        .map(|(i, cell)| (clean(cell).to_lowercase(), i))
        .collect()
}

/// Reads a cell by header label rather than position, trying each alias in turn.
fn at(headers: &HashMap<String, usize>, row: &[ElementRef], names: &[&str]) -> String {
    for name in names {
        if let Some(&index) = headers.get(*name) {
            if let Some(cell) = row.get(index) {
                return value(clean(cell));
            }
        }
    }
    String::new()
}

/// Reads the label/value table above the summary.
///
/// Rows are `<th>label</th><td>value</td>`, so this matches on the label rather
/// than a row position. A commented-out Thymeleaf copy of this table sits above
/// the real one in the response; comments are not elements, so they cannot be
/// picked up by mistake.
fn parse_info(document: &Html) -> CapstoneInfo {
    let table_selector = Selector::parse("table").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let th_selector = Selector::parse("th").unwrap();
    let td_selector = Selector::parse("td").unwrap();

    let mut info = CapstoneInfo::default();

    for table in document.select(&table_selector) {
        for row in table.select(&row_selector) {
            let (Some(header), Some(cell)) = (
                row.select(&th_selector).next(),
                row.select(&td_selector).next(),
            ) else {
                continue;
            };
            // Prefix match, so minor wording changes do not drop a field.
            let label = clean(&header).to_lowercase();
            let text = value(clean(&cell));
            if label.starts_with("title") {
                info.title = text;
            } else if label.starts_with("guide evaluation status") {
                info.guide_evaluation_status = text;
            } else if label.starts_with("date of registration") {
                info.date_of_registration = text;
            }
        }
    }

    info
}

/// Reads the present / on-duty / absent tally.
///
/// Columns are located by header label, not index — the response carries a
/// commented-out column elsewhere, and VTOP has reordered tables before.
/// Returns `None` when the summary table is absent, which is how a student
/// without a capstone registration is detected.
fn parse_summary(document: &Html) -> Option<CapstoneSummary> {
    let table_selector = Selector::parse("table").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let td_selector = Selector::parse("td").unwrap();

    for table in document.select(&table_selector) {
        let rows: Vec<_> = table.select(&row_selector).collect();
        if rows.len() < 2 {
            continue;
        }

        let headers = header_index(&rows[0]);
        if !headers.contains_key("present") || !headers.contains_key("absent") {
            continue;
        }

        // The first row after the header carries the tally.
        for row in &rows[1..] {
            let row_cells: Vec<_> = row.select(&td_selector).collect();
            if row_cells.is_empty() {
                continue;
            }
            return Some(CapstoneSummary {
                present: at(&headers, &row_cells, &["present"]),
                on_duty: at(&headers, &row_cells, &["on duty (od)", "on duty", "od"]),
                absent: at(&headers, &row_cells, &["absent"]),
                percentage: at(&headers, &row_cells, &["percentage"])
                    .trim_end_matches('%')
                    .to_string(),
            });
        }
    }

    None
}

/// Reads the day-by-day calendar.
///
/// The table has a stable id. Its "Description" column is commented out in both
/// the header and every row, so columns are read by header label to stay correct
/// if VTOP ever re-enables it.
fn parse_punches(document: &Html) -> Vec<CapstonePunch> {
    let table_selector = Selector::parse("#sdpCalendarTable").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let td_selector = Selector::parse("td").unwrap();

    let Some(table) = document.select(&table_selector).next() else {
        return Vec::new();
    };

    let rows: Vec<_> = table.select(&row_selector).collect();
    let Some(header_row) = rows.first() else {
        return Vec::new();
    };
    let headers = header_index(header_row);

    let mut punches = Vec::new();
    for row in &rows[1..] {
        let row_cells: Vec<_> = row.select(&td_selector).collect();
        if row_cells.is_empty() {
            continue;
        }

        let serial = at(&headers, &row_cells, &["sl.no.", "sl.no", "s.no"]);
        // Real rows lead with a numeric serial; anything else is a header or
        // spacer row.
        if serial.is_empty() || !serial.chars().all(|c| c.is_ascii_digit()) {
            continue;
        }

        punches.push(CapstonePunch {
            serial,
            date: at(&headers, &row_cells, &["date"]),
            day: at(&headers, &row_cells, &["day"]),
            day_type: at(&headers, &row_cells, &["day type"]),
            status: at(&headers, &row_cells, &["status"]),
            punch_time: at(&headers, &row_cells, &["punch time"]),
        });
    }

    punches
}

/// Parses the capstone/SDP attendance fragment returned by `processSdpAttendance`.
///
/// The response is a modal fragment holding three tables: the registration
/// info, the attendance tally, and a day-by-day punch calendar.
///
/// Returns `None` when the response carries no summary — which is what a
/// student with no capstone registration gets.
///
/// # Examples
///
/// ```
/// let html = r#"
/// <table class="table table-bordered">
///   <tr><th>Title</th><td>Capstone</td></tr>
///   <tr><th>Date of Registration</th><td>2026-07-06 00:00:00.0</td></tr>
/// </table>
/// <table class="table table-bordered text-center">
///   <tr><th>Present</th><th>On Duty (OD)</th><th>Absent</th><th>Percentage</th></tr>
///   <tr><td>14</td><td>4</td><td>12</td><td>60%</td></tr>
/// </table>
/// <table id="sdpCalendarTable">
///   <tr><th>Sl.No.</th><th>Date</th><th>Day</th><th>Day Type</th><th>Status</th><th>Punch Time</th></tr>
///   <tr><td>1</td><td>17-07-2026</td><td>FRIDAY</td><td>Instructional</td><td>Absent</td><td>-</td></tr>
/// </table>
/// "#.to_string();
///
/// let attendance =
///     lib_vtop::api::vtop::parser::capstone_attendance_parser::parse_capstone_attendance(html)
///         .expect("summary table present");
///
/// assert_eq!(attendance.info.title, "Capstone");
/// // The percent sign is stripped so the value parses as a number.
/// assert_eq!(attendance.summary.percentage, "60");
/// assert_eq!(attendance.punches.len(), 1);
/// // A dash means "nothing here" and is normalised to empty.
/// assert_eq!(attendance.punches[0].punch_time, "");
/// ```
pub fn parse_capstone_attendance(html: String) -> Option<CapstoneAttendance> {
    let document = Html::parse_document(&html);

    // No summary means no capstone registration; the info and calendar tables
    // are meaningless on their own.
    let summary = parse_summary(&document)?;

    Some(CapstoneAttendance {
        info: parse_info(&document),
        summary,
        punches: parse_punches(&document),
    })
}
