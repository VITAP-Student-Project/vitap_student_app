use crate::api::vtop::types::academic_calendar::*;
use regex::Regex;
use scraper::{ElementRef, Html, Selector};

/// Month buttons call `processViewCalendar('01-AUG-2026')`. VTOP HTML-escapes
/// the quotes, so the raw markup carries `&#39;` — the attribute is read
/// through the parser, which unescapes it, rather than off the raw string.
fn cal_date_regex() -> Regex {
    Regex::new(r"processViewCalendar\(\s*'([^']+)'\s*\)").unwrap()
}

/// VTOP writes months as the three letter English abbreviation.
const MONTHS: [(&str, u32); 12] = [
    ("JAN", 1),
    ("FEB", 2),
    ("MAR", 3),
    ("APR", 4),
    ("MAY", 5),
    ("JUN", 6),
    ("JUL", 7),
    ("AUG", 8),
    ("SEP", 9),
    ("OCT", 10),
    ("NOV", 11),
    ("DEC", 12),
];

fn month_number(abbreviation: &str) -> Option<u32> {
    let upper = abbreviation.to_uppercase();
    MONTHS
        .iter()
        .find(|(name, _)| *name == upper)
        .map(|(_, number)| *number)
}

/// Collapses the heavy tab/newline whitespace VTOP pads cells with.
fn clean(element: &ElementRef) -> String {
    element
        .text()
        .collect::<String>()
        .split_whitespace()
        .collect::<Vec<_>>()
        .join(" ")
}

/// Reads the class group options.
///
/// Class groups depend on the semester, so VTOP returns this `select` from
/// `getDateForSemesterPreview` once a semester is chosen rather than rendering
/// it up front.
///
/// # Examples
///
/// ```
/// let html = r#"
/// <select name="classGroupId" id="classGroupId">
///   <option value="COMB" selected="selected">All Class Group (Combined)</option>
///   <option value="ALL">General (Semester)</option>
/// </select>
/// "#.to_string();
///
/// let groups = lib_vtop::api::vtop::parser::calendar_parser::parse_class_groups(html);
///
/// assert_eq!(groups.len(), 2);
/// assert_eq!(groups[0].id, "COMB");
/// assert_eq!(groups[0].name, "All Class Group (Combined)");
/// ```
pub fn parse_class_groups(html: String) -> Vec<ClassGroup> {
    let document = Html::parse_document(&html);
    let selector =
        Selector::parse("select#classGroupId option, select[name='classGroupId'] option").unwrap();

    let mut groups = Vec::new();
    let mut seen = Vec::new();

    for option in document.select(&selector) {
        let id = option
            .value()
            .attr("value")
            .unwrap_or("")
            .trim()
            .to_string();
        let name = clean(&option);

        // Placeholder rows carry no value, or read "-- Select --".
        if id.is_empty() || name.starts_with("--") || seen.contains(&id) {
            continue;
        }
        seen.push(id.clone());
        groups.push(ClassGroup { id, name });
    }

    groups
}

/// Reads the month buttons for a semester.
///
/// Each button is an anchor whose `onclick` carries the `calDate` that
/// `processViewCalendar` expects. The label ("AUG-2026") and that value
/// ("01-AUG-2026") differ, so both are kept.
///
/// # Examples
///
/// ```
/// let html = r#"
/// <a onclick="javascript:processViewCalendar('01-AUG-2026');">AUG-2026</a>
/// <a onclick="javascript:processViewCalendar('01-SEP-2026');">SEP-2026</a>
/// "#.to_string();
///
/// let months = lib_vtop::api::vtop::parser::calendar_parser::parse_calendar_months(html);
///
/// assert_eq!(months.len(), 2);
/// assert_eq!(months[0].label, "AUG-2026");
/// assert_eq!(months[0].cal_date, "01-AUG-2026");
/// ```
pub fn parse_calendar_months(html: String) -> Vec<CalendarMonthRef> {
    let document = Html::parse_document(&html);
    let anchor_selector = Selector::parse("a").unwrap();
    let regex = cal_date_regex();

    let mut months = Vec::new();
    let mut seen = Vec::new();

    for anchor in document.select(&anchor_selector) {
        let Some(onclick) = anchor.value().attr("onclick") else {
            continue;
        };
        let Some(captures) = regex.captures(onclick) else {
            continue;
        };

        let cal_date = captures[1].trim().to_string();
        if seen.contains(&cal_date) {
            continue;
        }
        seen.push(cal_date.clone());

        let label = clean(&anchor);
        months.push(CalendarMonthRef {
            label: if label.is_empty() {
                cal_date.clone()
            } else {
                label
            },
            cal_date,
        });
    }

    months
}

/// Reads the entries in one day cell.
///
/// A day renders as `<span>5</span><span>description</span><span>(label)</span>`.
/// The parenthesised span qualifies the one before it, so lines are folded that
/// way — which also handles a day carrying more than one entry.
fn parse_events(cell: &ElementRef) -> Vec<CalendarEvent> {
    let span_selector = Selector::parse("span").unwrap();
    let mut events: Vec<CalendarEvent> = Vec::new();

    // The first span is the day number.
    for span in cell.select(&span_selector).skip(1) {
        let line = clean(&span);
        if line.is_empty() {
            continue;
        }

        if line.starts_with('(') && line.ends_with(')') {
            if let Some(last) = events.last_mut() {
                last.label = line[1..line.len() - 1].trim().to_string();
                continue;
            }
        }

        events.push(CalendarEvent {
            description: line,
            label: String::new(),
        });
    }

    events
}

/// Parses one month's grid into dated days.
///
/// VTOP lays a month out as a Sunday-to-Saturday week grid padded with blank
/// cells. The grid is a display concern, so this returns a flat, date-ordered
/// list instead: the weekday comes from the column each day sits in, and the
/// month and year from `cal_date`.
///
/// Returns an empty list when `cal_date` is not a month VTOP could have sent.
///
/// # Examples
///
/// ```
/// let html = r#"
/// <table class="table calendar-table">
///   <tr><th>Sunday</th><th>Monday</th></tr>
///   <tr>
///     <td><span></span></td>
///     <td><span>3</span><span>Instructional Day - General (Semester)</span><span>(WorkingDay)</span></td>
///   </tr>
/// </table>
/// "#.to_string();
///
/// let days = lib_vtop::api::vtop::parser::calendar_parser::parse_calendar_month(
///     html,
///     "01-AUG-2026".to_string(),
/// );
///
/// assert_eq!(days.len(), 1);
/// assert_eq!(days[0].date, "2026-08-03");
/// assert_eq!(days[0].weekday, "Monday");
/// assert_eq!(days[0].events[0].label, "WorkingDay");
/// ```
pub fn parse_calendar_month(html: String, cal_date: String) -> Vec<CalendarDay> {
    let parts: Vec<&str> = cal_date.split('-').collect();
    if parts.len() != 3 {
        return Vec::new();
    }
    let (Some(month), Ok(year)) = (month_number(parts[1]), parts[2].parse::<i32>()) else {
        return Vec::new();
    };

    let document = Html::parse_document(&html);
    let table_selector = Selector::parse("table.calendar-table, table").unwrap();
    let Some(table) = document.select(&table_selector).next() else {
        return Vec::new();
    };

    let row_selector = Selector::parse("tr").unwrap();
    let header_selector = Selector::parse("th, td").unwrap();
    let cell_selector = Selector::parse("td").unwrap();
    let span_selector = Selector::parse("span").unwrap();

    let rows: Vec<_> = table.select(&row_selector).collect();
    let Some(header_row) = rows.first() else {
        return Vec::new();
    };
    let weekdays: Vec<String> = header_row
        .select(&header_selector)
        .map(|cell| clean(&cell))
        .collect();

    let mut days = Vec::new();

    for row in &rows[1..] {
        for (index, cell) in row.select(&cell_selector).enumerate() {
            let Some(number_span) = cell.select(&span_selector).next() else {
                continue;
            };
            // Blank cells pad the start and end of the grid.
            let Ok(day) = clean(&number_span).parse::<u32>() else {
                continue;
            };

            days.push(CalendarDay {
                date: format!("{year:04}-{month:02}-{day:02}"),
                day,
                weekday: weekdays.get(index).cloned().unwrap_or_default(),
                events: parse_events(&cell),
            });
        }
    }

    days.sort_by_key(|entry| entry.day);
    days
}
