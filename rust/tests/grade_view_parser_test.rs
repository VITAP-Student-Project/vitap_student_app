use lib_vtop::api::vtop::parser::grade_view_parser::{parse_grade_view, parse_grade_view_detail};

/// The grade tiles: one row per graded course, with the course id in the
/// "View Mark" button's getGradeViewDetails handler.
#[test]
fn test_parse_grade_view_tiles() {
    let html = r#"
    <table class="table table-hover table-bordered">
      <tr>
        <th>Sl.No.</th><th>Course Code</th><th>Course Title</th><th>Course Type</th>
        <th>Grading Type</th><th>Grand Total</th><th>Grade</th><th>View Mark</th>
      </tr>
      <tr>
        <td>1</td><td>CSE1008</td><td>Theory of Computation</td><td>Theory Only</td>
        <td>RG</td><td>63</td><td>B</td>
        <td><button class="btn btn-primary" onclick="javascript:getGradeViewDetails('AM_CSE1008_00200');">+</button></td>
      </tr>
      <tr>
        <td>2</td><td>CSE4004</td><td>Web Technologies</td><td>Embedded Theory and Lab</td>
        <td>RG</td><td>90</td><td>S</td>
        <td><button class="btn btn-primary" onclick="javascript:getGradeViewDetails('AM_CSE4004_00400');">+</button></td>
      </tr>
    </table>
    "#
    .to_string();

    let courses = parse_grade_view(html);

    assert_eq!(courses.len(), 2);
    assert_eq!(courses[0].course_code, "CSE1008");
    assert_eq!(courses[0].grand_total, "63");
    assert_eq!(courses[0].grade, "B");
    assert_eq!(courses[0].course_id, "AM_CSE1008_00200");
    assert_eq!(courses[1].course_id, "AM_CSE4004_00400");
}

/// The detail response nests the statistics and marks tables inside a cell of
/// the outer grade table, so the parser must pick the innermost (leaf) tables.
#[test]
fn test_parse_grade_view_detail_nested_tables() {
    let html = r#"
    <table class="table table-hover table-bordered">
      <tr>
        <th>Sl.No.</th><th>Course Code</th><th>Course Title</th><th>Course Type</th>
        <th>Grading Type</th><th>Grand Total</th><th>Grade</th><th>View Mark</th>
      </tr>
      <tr>
        <td>1</td><td>CSE1008</td><td>Theory of Computation</td><td>Theory Only</td>
        <td>RG</td><td>63</td><td>B</td><td><button>-</button></td>
      </tr>
      <tr>
        <td>
          <table class="table table-striped table-bordered">
            <tr><th>Class Strength</th><th>Grading Strength</th><th>Mean</th><th>SD</th><th>Range of Grades</th></tr>
            <tr><td>S</td><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td></tr>
            <tr>
              <td>71</td><td>62</td><td>60.4</td><td>13.71</td>
              <td>&gt;=81#</td><td>&gt;=67 and &lt;81</td><td>&gt;=54 and &lt;67</td>
              <td>&gt;=47 and &lt;54</td><td>&gt;=40 and &lt;47</td><td>&gt;=33 and &lt;40</td><td>&lt;33</td>
            </tr>
            <tr><td># As Per 'S' Grade Policy</td></tr>
          </table>
          <table class="table table-striped table-bordered">
            <tr><td>Class Number : AP2025264000388</td><td>Course Type : Theory Only</td></tr>
            <tr><th>Sl.No.</th><th>Mark Title</th><th>Max. Mark</th><th>Weightage %</th><th>Status</th><th>Scored Mark</th><th>Weightage Mark</th></tr>
            <tr><td>1</td><td>CAT1</td><td>50</td><td>15</td><td>Present</td><td>16.0</td><td>4.8</td></tr>
            <tr><td>2</td><td>FAT</td><td>100</td><td>40</td><td>Present</td><td>67.0</td><td>26.8</td></tr>
            <tr><td>Total</td><td>63</td></tr>
          </table>
        </td>
      </tr>
    </table>
    "#
    .to_string();

    let detail = parse_grade_view_detail(html);

    // Marks come from the nested leaf table, not the outer wrapper.
    assert_eq!(detail.class_number, "AP2025264000388");
    assert_eq!(detail.course_type, "Theory Only");
    assert_eq!(detail.total, "63");
    assert_eq!(detail.marks.len(), 2);
    assert_eq!(detail.marks[0].mark_title, "CAT1");
    assert_eq!(detail.marks[0].scored_mark, "16.0");
    assert_eq!(detail.marks[1].max_mark, "100");

    // Class statistics.
    assert_eq!(detail.statistics.class_strength, "71");
    assert_eq!(detail.statistics.grading_strength, "62");
    assert_eq!(detail.statistics.mean, "60.4");
    assert_eq!(detail.statistics.sd, "13.71");
    assert_eq!(detail.statistics.grade_ranges.len(), 7);
    assert_eq!(detail.statistics.grade_ranges[0].grade, "S");
    assert_eq!(detail.statistics.grade_ranges[0].range, ">=81#");
    assert_eq!(detail.statistics.grade_ranges[6].grade, "F");
    assert_eq!(detail.statistics.grade_ranges[6].range, "<33");
}

#[test]
fn test_parse_grade_view_empty() {
    assert!(parse_grade_view("<html></html>".to_string()).is_empty());
    let detail = parse_grade_view_detail("<html></html>".to_string());
    assert!(detail.marks.is_empty());
    assert!(detail.statistics.grade_ranges.is_empty());
}
