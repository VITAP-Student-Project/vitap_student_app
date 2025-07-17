use crate::api::vtop::types::*;
use scraper::{Html, Selector};
use std::time::{Duration, SystemTime, UNIX_EPOCH};

pub fn parse_hostel_outing(html: String) -> HostelOutingData {
    let document = Html::parse_document(&html);
    let table_selector = Selector::parse("table#BookingRequests").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let cell_selector = Selector::parse("td").unwrap();
    
    let mut records = Vec::new();
    
    if let Some(table) = document.select(&table_selector).next() {
        // Skip header row and process data rows
        for row in table.select(&row_selector).skip(1) {
            let cells: Vec<_> = row.select(&cell_selector).collect();
            
            if cells.len() >= 14 {
                let status_text = cells[13]
                    .text()
                    .collect::<Vec<_>>()
                    .join("")
                    .trim()
                    .replace("\t", "")
                    .replace("\n", "");
                
                // Check if download link exists in the last column
                let download_selector = Selector::parse("a.btn").unwrap();
                let can_download = cells.get(14)
                    .map(|cell| cell.select(&download_selector).next().is_some())
                    .unwrap_or(false);
                
                let record = OutingRecord {
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
                    hostel_block: cells[2]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    room_number: cells[3]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    place_of_visit: cells[4]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    purpose_of_visit: cells[5]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    time: cells[6]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    contact_number: cells[7]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    parent_contact_number: cells[8]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    date: cells[9]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    booking_id: cells[10]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", ""),
                    status: status_text,
                    can_download,
                };
                
                records.push(record);
            }
        }
    }
    
    HostelOutingData {
        records,
        update_time: SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap_or(Duration::new(1, 0))
            .as_secs(),
    }
}
