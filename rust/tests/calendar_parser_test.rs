use lib_vtop::api::vtop::parser::calendar_parser::{
    parse_calendar_month, parse_calendar_months, parse_class_groups,
};

/// The month grid as VTOP renders it: a Sunday-to-Saturday week table, padded
/// at both ends with cells that hold an empty span rather than nothing.
fn month_grid() -> String {
    r#"
    <table class="table calendar-table">
      <tr>
        <th>Sunday</th><th>Monday</th><th>Tuesday</th><th>Wednesday</th>
        <th>Thursday</th><th>Friday</th><th>Saturday</th>
      </tr>
      <tr>
        <td><span></span></td><td><span></span></td><td><span></span></td>
        <td><span></span></td><td><span></span></td><td><span></span></td>
        <td><span>1</span><span>Instructional Day - General (Semester)</span><span>(WorkingDay)</span></td>
      </tr>
      <tr>
        <td><span>2</span><span>Holiday - General (Semester)</span><span>(Holiday)</span></td>
        <td><span>3</span><span>No Instructional Day - General (Semester)</span><span>(No Instructional Day)</span></td>
        <td><span>4</span><span>Instructional Day - General (Semester)</span><span>(WorkingDay)</span></td>
        <td><span>5</span><span>Instructional Day - General (Semester)</span><span>(WorkingDay)</span></td>
        <td><span>6</span><span>Instructional Day - General (Semester)</span><span>(WorkingDay)</span></td>
        <td><span>7</span><span>Instructional Day - General (Semester)</span><span>(WorkingDay)</span></td>
        <td><span>8</span><span>Independence Day</span><span>(Holiday)</span></td>
      </tr>
    </table>
    "#
    .to_string()
}

#[test]
fn test_parses_class_groups() {
    let html = r#"
    <select class="form-select" name="classGroupId" id="classGroupId">
      <option value="COMB" selected="selected">All Class Group (Combined)</option>
      <option value="ALL">General (Semester)</option>
    </select>
    "#
    .to_string();

    let groups = parse_class_groups(html);

    assert_eq!(groups.len(), 2);
    assert_eq!(groups[0].id, "COMB");
    assert_eq!(groups[0].name, "All Class Group (Combined)");
    assert_eq!(groups[1].id, "ALL");
}

/// Every other VTOP dropdown leads with an empty placeholder option, and it is
/// not a class group.
#[test]
fn test_class_group_placeholder_is_skipped() {
    let html = r#"
    <select id="classGroupId">
      <option value="">-- Select Class Group --</option>
      <option value="COMB">All Class Group (Combined)</option>
    </select>
    "#
    .to_string();

    let groups = parse_class_groups(html);

    assert_eq!(groups.len(), 1);
    assert_eq!(groups[0].id, "COMB");
}

/// The label on the button and the value the endpoint wants are different
/// strings — "AUG-2026" against "01-AUG-2026" — so losing either breaks a
/// lookup.
#[test]
fn test_parses_month_buttons() {
    let html = r#"
    <a class="btn" onclick="javascript:processViewCalendar('01-JUL-2026');" href="javascript:void(0);">JUL-2026</a>
    <a class="btn" onclick="javascript:processViewCalendar('01-AUG-2026');" href="javascript:void(0);">AUG-2026</a>
    <a class="btn" onclick="somethingElse('01-SEP-2026');" href="javascript:void(0);">SEP-2026</a>
    "#
    .to_string();

    let months = parse_calendar_months(html);

    assert_eq!(months.len(), 2);
    assert_eq!(months[0].label, "JUL-2026");
    assert_eq!(months[0].cal_date, "01-JUL-2026");
    assert_eq!(months[1].cal_date, "01-AUG-2026");
}

/// The page renders the month buttons twice — once in the class group response
/// and again in the month list — and a duplicated month would fetch twice and
/// show twice.
#[test]
fn test_repeated_month_buttons_are_listed_once() {
    let html = r#"
    <a onclick="processViewCalendar('01-AUG-2026');">AUG-2026</a>
    <a onclick="processViewCalendar('01-AUG-2026');">AUG-2026</a>
    "#
    .to_string();

    assert_eq!(parse_calendar_months(html).len(), 1);
}

#[test]
fn test_parses_a_month_into_dated_days() {
    let days = parse_calendar_month(month_grid(), "01-AUG-2026".to_string());

    assert_eq!(days.len(), 8);

    // The date comes from the month that was requested; the grid only carries
    // the day number.
    assert_eq!(days[0].date, "2026-08-01");
    assert_eq!(days[0].day, 1);
    // The weekday comes from the column the day sits in.
    assert_eq!(days[0].weekday, "Saturday");

    assert_eq!(days[1].date, "2026-08-02");
    assert_eq!(days[1].weekday, "Sunday");
    assert_eq!(days[7].date, "2026-08-08");
    assert_eq!(days[7].weekday, "Saturday");
}

/// The parenthesised span qualifies the description before it rather than being
/// an entry of its own.
#[test]
fn test_folds_the_qualifier_into_its_event() {
    let days = parse_calendar_month(month_grid(), "01-AUG-2026".to_string());

    assert_eq!(days[0].events.len(), 1);
    assert_eq!(
        days[0].events[0].description,
        "Instructional Day - General (Semester)"
    );
    assert_eq!(days[0].events[0].label, "WorkingDay");

    assert_eq!(days[7].events[0].description, "Independence Day");
    assert_eq!(days[7].events[0].label, "Holiday");
}

/// Days are returned in date order regardless of where they sit in the grid,
/// because callers look up a date rather than a row and column.
#[test]
fn test_days_come_back_in_date_order() {
    let days = parse_calendar_month(month_grid(), "01-AUG-2026".to_string());
    let numbers: Vec<u32> = days.iter().map(|day| day.day).collect();

    assert_eq!(numbers, vec![1, 2, 3, 4, 5, 6, 7, 8]);
}

/// The empty cells padding the grid carry a span with no number in it, and a
/// day with no entries is still a day.
#[test]
fn test_padding_cells_are_not_days() {
    let html = r#"
    <table class="calendar-table">
      <tr><th>Sunday</th><th>Monday</th></tr>
      <tr><td><span></span></td><td><span>1</span></td></tr>
      <tr><td><span>&nbsp;</span></td><td></td></tr>
    </table>
    "#
    .to_string();

    let days = parse_calendar_month(html, "01-AUG-2026".to_string());

    assert_eq!(days.len(), 1);
    assert_eq!(days[0].day, 1);
    assert!(days[0].events.is_empty());
}

/// A calDate the parser cannot read is not worth guessing a date from — every
/// day would carry the wrong month.
#[test]
fn test_unreadable_cal_date_yields_no_days() {
    assert!(parse_calendar_month(month_grid(), "01-XXX-2026".to_string()).is_empty());
    assert!(parse_calendar_month(month_grid(), "nonsense".to_string()).is_empty());
    assert!(parse_calendar_month(month_grid(), "01-AUG-YYYY".to_string()).is_empty());
}

#[test]
fn test_empty_responses_yield_nothing() {
    assert!(parse_class_groups("<html></html>".to_string()).is_empty());
    assert!(parse_calendar_months("<html></html>".to_string()).is_empty());
    assert!(
        parse_calendar_month("<html></html>".to_string(), "01-AUG-2026".to_string()).is_empty()
    );
}
