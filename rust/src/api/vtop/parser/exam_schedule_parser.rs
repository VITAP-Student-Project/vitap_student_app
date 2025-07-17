use super::super::types::*;
use scraper::{Html, Selector};

pub fn parse_schedule(html: String) -> Vec<PerExamScheduleRecord> {
    let document = Html::parse_document(&html);
    let rows_selector = Selector::parse("tr").unwrap();
    let mut exams: Vec<PerExamScheduleRecord> = Vec::new();

    let mut off_set = -1;
    for row in document.select(&rows_selector).skip(2) {
        let cells: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
        if cells.len() < 3 {
            let n = cells[0]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let exam = PerExamScheduleRecord {
                exam_type: n,
                subjects: vec![],
            };
            exams.push(exam);
            off_set += 1;
        } else if cells.len() > 12 {
            let course = ExamScheduleRecord {
                serial_number: cells[0]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                slot: cells[5]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                course_name: cells[2]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                course_code: cells[1]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                course_type: cells[3]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                course_id: cells[4]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                exam_date: cells[6]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                exam_session: cells[7]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                reporting_time: cells[8]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                exam_time: cells[9]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                venue: cells[10]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                seat_location: cells[11]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                seat_number: cells[12]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
            };
            exams[off_set as usize].subjects.push(course);
        }
    }
    exams
}
