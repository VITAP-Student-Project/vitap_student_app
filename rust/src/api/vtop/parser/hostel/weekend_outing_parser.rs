use crate::api::vtop::types::*;
use scraper::{Html, Selector};

pub fn parse_hostel_outing(html: String) -> Vec<WeekendOutingRecord> {
    let document = Html::parse_document(&html);
    let table_selector = Selector::parse("table#BookingRequests").unwrap();
    let row_selector = Selector::parse("tr").unwrap();
    let cell_selector = Selector::parse("td").unwrap();
    
    let mut records = Vec::new();
    
    if let Some(table) = document.select(&table_selector).next() {
        // Skip header row and process data rows
        for row in table.select(&row_selector).skip(1) {
            let cells: Vec<_> = row.select(&cell_selector).collect();
            
            // Need at least 11 columns based on actual HTML structure
            if cells.len() >= 11 {
                // Helper function to extract and clean text
                let extract_text = |index: usize| -> String {
                    cells[index]
                        .text()
                        .collect::<Vec<_>>()
                        .join("")
                        .trim()
                        .replace("\t", "")
                        .replace("\n", " ")
                        .trim()
                        .to_string()
                };
                
                // Status is at index 9 in the actual HTML structure
                let status_text = extract_text(9);
                
                // Extract booking_id from download link's data-leave-url attribute
                let download_selector = Selector::parse("a[data-leave-url]").unwrap();
                let booking_id = if let Some(download_link) = cells[10].select(&download_selector).next() {
                    if let Some(data_url) = download_link.value().attr("data-leave-url") {
                        // Extract ID from URL like "/vtop/hostel/downloadOutingForm/W23235307220"
                        data_url.split('/').last().unwrap_or("").to_string()
                    } else {
                        String::new()
                    }
                } else {
                    String::new()
                };
                
                // Check if download link exists
                let can_download = !booking_id.is_empty();
                
                let record = WeekendOutingRecord {
                    serial: extract_text(0),
                    registration_number: extract_text(1),
                    hostel_block: extract_text(2),
                    room_number: extract_text(3),
                    place_of_visit: extract_text(4),
                    purpose_of_visit: extract_text(5),
                    time: extract_text(6),
                    date: extract_text(7),
                    booking_id,
                    status: status_text,
                    can_download,
                };
                
                records.push(record);
            }
        }
    }
    
    records
}
