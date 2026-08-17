use lib_vtop::api::vtop::parser::semested_id_parser::parse_semid_from_timetable;

/// Every page get_semesters falls back to (timetable, marks, exam schedule)
/// exposes the same `select[name="semesterSubId"]` dropdown, led by a
/// placeholder option. This is the shape the parser must handle.
fn dropdown(options: &[(&str, &str)]) -> String {
    let mut html = String::from(
        r#"<select name="semesterSubId" id="semesterSubId">
             <option value="">-- Choose Semester --</option>"#,
    );
    for (value, name) in options {
        html.push_str(&format!("<option value=\"{value}\">{name}</option>"));
    }
    html.push_str("</select>");
    html
}

#[test]
fn test_parses_semester_dropdown() {
    let html = dropdown(&[
        ("AP2026272", "Fall Semester 2026-27"),
        ("AP2025264", "Winter Semester 2025-26"),
        ("AP2025262", "Fall Semester 2025-26"),
    ]);

    let data = parse_semid_from_timetable(html);

    assert_eq!(data.semesters.len(), 3);
    assert_eq!(data.semesters[0].id, "AP2026272");
    assert_eq!(data.semesters[0].name, "Fall Semester 2026-27");
    assert_eq!(data.semesters[1].id, "AP2025264");
}

/// The fallback source (the marks page) lists the full institutional set of
/// semesters, so its dropdown parses the same way — this is what makes it a
/// usable fallback when the timetable dropdown is empty.
#[test]
fn test_parses_full_marks_style_dropdown() {
    let options: Vec<(String, String)> = (0..60)
        .map(|i| (format!("AP20{:06}", i), format!("Semester {i}")))
        .collect();
    let refs: Vec<(&str, &str)> = options
        .iter()
        .map(|(v, n)| (v.as_str(), n.as_str()))
        .collect();

    let data = parse_semid_from_timetable(dropdown(&refs));

    assert_eq!(data.semesters.len(), 60);
}

/// An empty timetable dropdown (the fresher case) yields no semesters, which is
/// exactly the signal get_semesters uses to move on to the next fallback page.
#[test]
fn test_empty_dropdown_yields_no_semesters() {
    let html = r#"<select name="semesterSubId" id="semesterSubId">
                    <option value="">-- Choose Semester --</option>
                  </select>"#;

    assert!(parse_semid_from_timetable(html.to_string()).semesters.is_empty());
}

#[test]
fn test_missing_dropdown_yields_no_semesters() {
    assert!(parse_semid_from_timetable("<html></html>".to_string())
        .semesters
        .is_empty());
}
