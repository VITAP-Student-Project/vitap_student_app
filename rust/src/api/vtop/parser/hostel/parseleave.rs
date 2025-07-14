use crate::api::vtop::types::*;
use scraper::{Html, Selector};
use std::time::{Duration, SystemTime, UNIX_EPOCH};

pub fn parse_hostel_leave(html: String) -> HostelLeaveData {
    let document = Html::parse_document(&html);
    let table_selector = Selector::parse("table#BookingRequests").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let cell_selector = Selector::parse("td").unwrap();
    
    let mut records = Vec::new();
    
    if let Some(table) = document.select(&table_selector).next() {
        // Skip header row and process data rows
        for row in table.select(&row_selector).skip(1) {
            let cells: Vec<_> = row.select(&cell_selector).collect();
            
            if cells.len() >= 12 {
                let status_text = cells[10]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", "")
                    .replace("Leave Request Accepted", "Leave Request Accepted")
                    .replace("Leave Request", "");
                
                // Check if download link exists in the last column (index 11)
                let download_selector = Selector::parse("a[data-url]").unwrap();
                let (can_download, leave_id) = if let Some(cell) = cells.get(11) {
                    if let Some(link) = cell.select(&download_selector).next() {
                        if let Some(data_url) = link.value().attr("data-url") {
                            // Extract ID from data-url like "/vtop/hostel/downloadLeavePass/L2257300"
                            let id = data_url.split('/').last().unwrap_or("").to_string();
                            (true, id)
                        } else {
                            (false, String::new())
                        }
                    } else {
                        (false, String::new())
                    }
                } else {
                    (false, String::new())
                };
                
                let record = LeaveRecord {
                    serial: cells[0]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    registration_number: cells[1]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    place_of_visit: cells[2]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    purpose_of_visit: cells[3]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    from_date: cells[4]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    from_time: cells[5]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    to_date: cells[6]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    to_time: cells[7]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    status: status_text.trim().to_string(),
                    can_download,
                    leave_id,
                };
                
                records.push(record);
            }
        }
    }
    
    HostelLeaveData {
        records,
        update_time: SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap_or(Duration::new(1, 0))
            .as_secs(),
    }
}
