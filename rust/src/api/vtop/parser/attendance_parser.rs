use regex::Regex;
use scraper::{Html, Selector};

use super::super::types::*;

pub fn parse_attendance(html: String) -> (Vec<AttendanceRecord>, bool) {
    let document = Html::parse_document(&html);

    // Check if the View CAPSTONE/SDP Attendance button exist
    let button_selector = Selector::parse("button").unwrap();
    let buttons = document.select(&button_selector);
    let mut has_cap_or_sdp_attendance_btn = false;
    for button in buttons {
        let button_text = button
            .text()
            .collect::<Vec<_>>()
            .join("")
            .trim()
            .to_string();
        if button_text == "View CAPSTONE/SDP Attendance" {
            has_cap_or_sdp_attendance_btn = true;
            break;
        }
    }

    let rows_selector = Selector::parse("tr").unwrap();
    let mut courses: Vec<AttendanceRecord> = Vec::new();

    // Regex to extract course_id and course_type from onclick attribute
    // Pattern: callStudentAttendanceDetailDisplay('AP2025264','23BCEXXXX','AM_CSE1008_00200','TH')
    let onclick_regex = Regex::new(r"callStudentAttendanceDetailDisplay\s*\(\s*'[^']*'\s*,\s*'[^']*'\s*,\s*'([^']*)'\s*,\s*'([^']*)'\s*\)").unwrap();

    for row in document.select(&rows_selector).skip(1) {
        let cells: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
        if cells.len() > 9 {
            // Extract course_id and course_type_code from the onclick attribute in the last cell
            let info_cell_index = if cells.len() >= 11 {
                10
            } else {
                cells.len() - 1
            };
            let info_cell_html = cells[info_cell_index].html();

            let (course_id, course_type_code) =
                if let Some(caps) = onclick_regex.captures(&info_cell_html) {
                    (
                        caps.get(1)
                            .map_or("".to_string(), |m| m.as_str().to_string()),
                        caps.get(2)
                            .map_or("".to_string(), |m| m.as_str().to_string()),
                    )
                } else {
                    ("".to_string(), "".to_string())
                };
            // Parse course_name field: "MAT1001 - Calculus for Engineers - Embedded Lab"
            let raw_course_name = cells[2]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");

            let course_parts: Vec<&str> = raw_course_name.split(" - ").collect();
            let course_code = course_parts.get(0).unwrap_or(&"").to_string();
            let course_name = course_parts.get(1).unwrap_or(&"").to_string();
            let parsed_course_type = course_parts.last().unwrap_or(&"").to_string();

            // Parse course_code field: "AP2024258000131 - L27+L28+L39+L40 - 119"
            let raw_course_code = cells[3]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");

            let code_parts: Vec<&str> = raw_course_code.split(" - ").collect();
            let class_number = code_parts.get(0).unwrap_or(&"").to_string();
            let course_slot = code_parts.get(1).unwrap_or(&"").to_string();

            let course = AttendanceRecord {
                class_number,
                course_code,
                course_name,
                course_type: parsed_course_type,
                course_type_code,
                course_slot,
                faculty: cells[4]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                attended_classes: cells[5]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                total_classes: cells[6]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                attendance_percentage: cells[7]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", "")
                    .replace("%", ""),
                // attendance_between_percentage column may not exist in VTOP anymore
                // Default to "0" if column doesn't exist, otherwise parse it
                attendance_between_percentage: if cells.len() > 11 {
                    cells[8]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", "")
                        .replace("%", "")
                } else {
                    "0".to_string()
                },
                debar_status: if cells.len() > 11 {
                    cells[9]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", "")
                } else {
                    cells[8]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", "")
                },
                course_id,
            };

            courses.push(course);
        }
    }
    (courses, has_cap_or_sdp_attendance_btn)
}

pub fn parse_full_attendance(html: String) -> Vec<AttendanceDetailRecord> {
    let document = Html::parse_document(&html);

    // Target the specific table with attendance details
    let table_selector = Selector::parse("#StudentAttendanceDetailDataTable tbody tr").unwrap();
    let mut attendance_lists: Vec<AttendanceDetailRecord> = Vec::new();

    for row in document.select(&table_selector) {
        let cells: Vec<_> = row.select(&Selector::parse("td").unwrap()).collect();
        if cells.len() >= 6 {
            let attendance_list = AttendanceDetailRecord {
                serial: cells[0]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                date: cells[1]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                slot: cells[2]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                day_time: cells[3]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                status: cells[4]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
                remark: cells[5]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", ""),
            };

            attendance_lists.push(attendance_list);
        }
    }
    attendance_lists
}

pub fn parse_cap_or_sdp_attendance(html: String) -> (AttendanceRecord, Vec<AttendanceDetailRecord>) {
    let document = Html::parse_document(&html);

    let table_selector = Selector::parse("table").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let tables = document.select(&table_selector).collect::<Vec<_>>();
    let table_count = tables.len();

    // Default AttendanceRecord for CAPSTONE/SDP
    let mut course_record = AttendanceRecord {
        class_number: "CAPSTONE_OR_SDP".to_string(),
        course_code: "CAP4001 / CAP4002".to_string(),
        course_name: "CAPSTONE / SDP".to_string(),
        course_type: "Project".to_string(),
        course_type_code: "PJT".to_string(),
        course_slot: "NILL".to_string(),
        faculty: "IYKYK".to_string(),
        attended_classes: "0".to_string(),
        total_classes: "0".to_string(),
        attendance_percentage: "0".to_string(),
        attendance_between_percentage: "0".to_string(),
        debar_status: "Check in VTOP".to_string(),
        course_id: "AM_CAP4000_00000".to_string(), // Use this course_id for CAPSTONE/SDP attendance details
    };

    let mut punch_details: Vec<AttendanceDetailRecord> = Vec::new();

    // Table 1 Contains the Course Details
    // Table 2 Contains the Attendance Details
    // Table 3 Contains the Punch Details

    if table_count >= 1 {
        for row in tables[0].select(&row_selector) {
            let cells: Vec<_> = row.select(&Selector::parse("td, th").unwrap()).collect();
            if cells.len() >= 2 {
                let key = cells[0]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", "");
                let value = cells[1]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", "");
                if key == "Title" {
                    course_record.course_name = value;
                    break;
                }
            }
        }
        if course_record.course_name == "Capstone" {
            course_record.course_code = "CAP4001".to_string();
        }else{
            course_record.course_code = "CAP4002".to_string();
        }
    }
    if table_count >= 2 {
        for row in tables[1].select(&row_selector).skip(1) {
            let cells: Vec<_> = row.select(&Selector::parse("td, th").unwrap()).collect();
            let attended_days = cells[0]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let on_duty_days = cells[1]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let absent_days = cells[2]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            let percentage = cells[3]
                .text()
                .collect::<Vec<_>>()
                .join("")
                .trim()
                .replace("\t", "")
                .replace("\n", "");
            course_record.attended_classes = (attended_days.parse::<i32>().unwrap_or(0) + on_duty_days.parse::<i32>().unwrap_or(0)).to_string();
            course_record.total_classes = (attended_days.parse::<i32>().unwrap_or(0) + on_duty_days.parse::<i32>().unwrap_or(0) + absent_days.parse::<i32>().unwrap_or(0)).to_string();
            course_record.attendance_percentage = percentage.clone();
            course_record.attendance_between_percentage = percentage;
        }    
    }
    if table_count >= 3 {
        for row in tables[2].select(&row_selector).skip(1) {
            let cells: Vec<_> = row.select(&Selector::parse("td, th").unwrap()).collect();
            if cells.len() >= 6 {
                let slot = cells[2]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", "");
                let punch_record = AttendanceDetailRecord {
                    serial: cells[0]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    date: cells[1]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    slot: slot.clone(),
                    remark: cells[3]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    status: cells[4]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    day_time: format!("{} / {}",&slot[0..3],cells[5]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", "")),
                };
                punch_details.push(punch_record);
            }
        }
        punch_details.reverse();
    }
    (course_record, punch_details)
}
