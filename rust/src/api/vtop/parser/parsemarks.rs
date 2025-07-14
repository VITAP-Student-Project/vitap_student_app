use super::super::types::*;
use scraper::{ElementRef, Html, Selector};

pub fn parse_marks(html: String) -> Vec<MarksRecord> {
    let document = Html::parse_document(&html);
    let mut courses: Vec<MarksRecord> = Vec::new();

    let mut course = MarksRecord {
        serial: "".to_string(),
        coursecode: "".to_string(),
        coursetitle: "".to_string(),
        coursetype: "".to_string(),
        faculity: "".to_string(),
        slot: "".to_string(),
        marks: vec![],
    };

    fn extract_text(el: Option<&ElementRef>) -> String {
        el.map(|e| e.text().collect::<Vec<_>>().join(""))
            .unwrap_or_default()
            .trim()
            .replace('\t', "")
            .replace('\n', "")
    }

    let mut bmarks = false;
    for row in document.select(&Selector::parse("tr.tableContent").unwrap()) {
        let cells: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
        if bmarks {
            let marks_el: Vec<_> = cells[0]
                .select(&Selector::parse("tr.tableContent-level1").unwrap())
                .collect();
            let mut marks_vec: Vec<MarksRecordEach> = vec![];
            for i in marks_el {
                let mk: Vec<_> = i.select(&Selector::parse("td").unwrap()).collect();
                let mut marksiter = mk.iter();
                let marks = MarksRecordEach {
                    serial: extract_text(marksiter.next()),
                    markstitle: extract_text(marksiter.next()),
                    maxmarks: extract_text(marksiter.next()),
                    weightage: extract_text(marksiter.next()),
                    status: extract_text(marksiter.next()),
                    scoredmark: extract_text(marksiter.next()),
                    weightagemark: extract_text(marksiter.next()),
                    remark: extract_text(marksiter.next()),
                };
                marks_vec.push(marks);
            }
            course.marks = marks_vec;

            courses.push(course.clone());
            course = MarksRecord {
                serial: "".to_string(),
                coursecode: "".to_string(),
                coursetitle: "".to_string(),
                coursetype: "".to_string(),
                faculity: "".to_string(),
                slot: "".to_string(),
                marks: vec![],
            };
        } else {
            course = MarksRecord {
                serial: cells[0]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                coursecode: cells[2]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                coursetitle: cells[3]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                coursetype: cells[4]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                faculity: cells[6]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                slot: cells[7]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                marks: vec![],
            }
        }

        bmarks = !bmarks
    }
    courses
}
