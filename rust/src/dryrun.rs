mod api;

use std::env;
use std::io::{self, Write};
use std::fs;
use std::path::PathBuf;
use rfd::FileDialog;
use dotenv::dotenv;
//included this for otp dassignment upload
use crate::api::vtop::vtop_errors::VtopError;

fn print_ascii_logo() {
    println!("\x1b[36m"); // Cyan color
    println!(
        r#"
╦ ╦╔╦╗╔═╗╔═╗  ╔═╗╦  ╦
║ ║ ║ ║ ║╠═╝  ║  ║  ║
╩═╝ ╩ ╚═╝╩    ╚═╝╩═╝╩

    ┌─────────────────────────────────────┐
    │        VTOP Client Terminal         │
    │       Interactive Test Suite        │
    └─────────────────────────────────────┘
    "#
    );
    println!("\x1b[0m"); // Reset color
}

fn print_welcome_message() {
    println!("\x1b[32m"); // Green color
    println!("🎓 Welcome to VTOP CLI - VIT-AP Student Portal Interface");
    println!("   Built with Rust | Version 1.0.3");
    println!("\x1b[0m"); // Reset color
}

fn print_menu() {
    println!("\x1b[33m"); // Yellow color
    println!("\n┌─ Available Options ─────────────────────────────────────┐");
    println!("│                                                         │");
    println!("│  1. 🔐 Login to VTOP                                   │");
    println!("│  2. 👤 Fetch Student Profile                           │");
    println!("│  3. 📅 Get Timetable                                   │");
    println!("│  4. 📊 View Attendance                                 │");
    println!("│  5. 📝 Check Marks                                     │");
    println!("│  6. 📋 Exam Schedule                                   │");
    println!("│  7. 🎯 Grade History                                   │");
    println!("│  8. 🔍 Faculty Search                                  │");
    println!("│  9. 📍 Biometric Data                                  │");
    println!("│ 10. 🌐 WiFi Login/Logout                               │");
    println!("│ 11. 🏠 Submit General Outing                           │");
    println!("│ 12. 🎉 Submit Weekend Outing                           │");
    println!("│ 13. 🗑️  Delete General Outing                          │");
    println!("│ 14. 🗑️  Delete Weekend Outing                          │");
    println!("│ 15. ℹ️  System Information                              │");
    println!("│ 16. 📋 Detailed Attendance (Day-wise)                  │");
    println!("│ 17. 📂 Fetch Digital Assignments                       │");
    println!("│ 18. 📂 Upload Digital Assignments                      │");
    println!("│  0. ❌ Exit                                            │");
    println!("│                                                         │");
    println!("└─────────────────────────────────────────────────────────┘");
    println!("\x1b[0m"); // Reset color
}

fn get_user_input(prompt: &str) -> String {
    print!("\x1b[36m{}\x1b[0m", prompt); // Cyan prompt
    io::stdout().flush().unwrap();
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    input.trim().to_string()
}

fn print_separator() {
    println!("\x1b[35m{}\x1b[0m", "═".repeat(60)); // Magenta separator
}

fn print_success(message: &str) {
    println!("\x1b[32m✅ {}\x1b[0m", message); // Green success
}

fn print_error(message: &str) {
    println!("\x1b[31m❌ {}\x1b[0m", message); // Red error
}

fn print_info(message: &str) {
    println!("\x1b[34mℹ️  {}\x1b[0m", message); // Blue info
}

fn clear_screen() {
    print!("\x1b[2J\x1b[1;1H"); // Clear screen and move cursor to top
    io::stdout().flush().unwrap();
}

async fn handle_login(client: &mut api::vtop::vtop_client::VtopClient) -> bool {
    print_separator();
    println!("\x1b[33m🔐 Attempting VTOP Login...\x1b[0m");

    match api::vtop_get_client::vtop_client_login(client).await {
        Ok(_) => {
            print_success("VTOP login successful!");
            true
        }
        Err(e) => {
            print_error(&format!("VTOP login failed: {:?}", e));
            false
        }
    }
}

async fn handle_student_profile(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m👤 Fetching Student Profile...\x1b[0m");

    match api::vtop_get_client::fetch_student_profile(client).await {
        Ok(profile) => {
            print_success("Student profile retrieved successfully!");
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Profile Data (JSON):");
            println!("\x1b[37m{}\x1b[0m", profile);
        }
        Err(e) => print_error(&format!("Failed to fetch student profile: {:?}", e)),
    }
}

async fn handle_timetable(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📅 Fetching Timetable...\x1b[0m");

    // First get semesters
    match api::vtop_get_client::fetch_semesters(client).await {
        Ok(semesters) => {
            print_info(&format!("Available semesters: {:?}", semesters));
            let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
            let semester_id = if semester_id.is_empty() {
                "AP2024254".to_string()
            } else {
                semester_id
            };

            match api::vtop_get_client::fetch_timetable(client, semester_id).await {
                Ok(timetable) => {
                    print_success("Timetable retrieved successfully!");
                    println!("\x1b[37m{}\x1b[0m", timetable);
                }
                Err(e) => print_error(&format!("Failed to fetch timetable: {:?}", e)),
            }
        }
        Err(e) => print_error(&format!("Failed to fetch semesters: {:?}", e)),
    }
}

async fn handle_attendance(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📊 Fetching Attendance...\x1b[0m");

    let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
    let semester_id = if semester_id.is_empty() {
        "AP2024254".to_string()
    } else {
        semester_id
    };

    match api::vtop_get_client::fetch_attendance(client, semester_id).await {
        Ok(attendance) => {
            print_success("Attendance retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", attendance);
        }
        Err(e) => print_error(&format!("Failed to fetch attendance: {:?}", e)),
    }
}

async fn handle_detailed_attendance(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📋 Fetching Detailed (Day-wise) Attendance...\x1b[0m");
    
    // First, fetch regular attendance to get course list
    let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
    let semester_id = if semester_id.is_empty() { "AP2025264".to_string() } else { semester_id };
    
    print_info("Fetching attendance list to get course IDs...");
    let attendance_json = match api::vtop_get_client::fetch_attendance(client, semester_id.clone()).await {
        Ok(attendance) => {
            print_success("Attendance list retrieved!");
            attendance
        }
        Err(e) => {
            print_error(&format!("Failed to fetch attendance list: {:?}", e));
            return;
        }
    };
    
    // Parse the attendance JSON to extract course details
    let courses: Vec<serde_json::Value> = match serde_json::from_str(&attendance_json) {
        Ok(c) => c,
        Err(e) => {
            print_error(&format!("Failed to parse attendance JSON: {:?}", e));
            return;
        }
    };
    
    if courses.is_empty() {
        print_error("No courses found in attendance list.");
        return;
    }
    
    // Display available courses with their IDs and type codes
    println!("\n\x1b[36m┌─ Available Courses ─────────────────────────────────────────────────────┐\x1b[0m");
    for (i, course) in courses.iter().enumerate() {
        let course_code = course["course_code"].as_str().unwrap_or("N/A");
        let course_name = course["course_name"].as_str().unwrap_or("N/A");
        let course_type = course["course_type"].as_str().unwrap_or("N/A");
        let course_id = course["course_id"].as_str().unwrap_or("N/A");
        let course_type_code = course["course_type_code"].as_str().unwrap_or("N/A");
        
        println!("\x1b[33m  {}. {} - {} ({})\x1b[0m", i + 1, course_code, course_name, course_type);
        println!("     \x1b[32mcourse_id:\x1b[0m {} | \x1b[32mcourse_type_code:\x1b[0m {}", course_id, course_type_code);
    }
    println!("\x1b[36m└─────────────────────────────────────────────────────────────────────────┘\x1b[0m\n");
    
    // Let user select by number
    let choice = get_user_input("Enter course number (1, 2, 3...): ");
    let course_index: usize = match choice.parse::<usize>() {
        Ok(n) if n >= 1 && n <= courses.len() => n - 1,
        _ => {
            print_error("Invalid course number!");
            return;
        }
    };
    
    let selected_course = &courses[course_index];
    let course_id = selected_course["course_id"].as_str().unwrap_or("").to_string();
    let course_type_code = selected_course["course_type_code"].as_str().unwrap_or("").to_string();
    let course_code = selected_course["course_code"].as_str().unwrap_or("N/A");
    let course_name = selected_course["course_name"].as_str().unwrap_or("N/A");
    
    if course_id.is_empty() || course_type_code.is_empty() {
        print_error("Course ID or Course Type Code is empty! The attendance parser may need updating.");
        println!("\x1b[33mDebug - Raw course data:\x1b[0m {}", selected_course);
        return;
    }
    
    print_info(&format!("Fetching detailed attendance for {} - {}...", course_code, course_name));
    print_info(&format!("Using course_id: {} | course_type_code: {}", course_id, course_type_code));
    
    match api::vtop_get_client::fetch_attendance_detail(
        client,
        semester_id,
        course_id,
        course_type_code,
    ).await {
        Ok(detailed_attendance) => {
            print_success("Detailed attendance retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", detailed_attendance);
            
            // Also print some debug info about what was parsed
            println!();
            if detailed_attendance == "[]" {
                print_error("Result is empty! The HTML structure may have changed.");
                print_info("Parser expects: table#StudentAttendanceDetailDataTable > tbody > tr > td (6 cells)");
            }
        }
        Err(e) => print_error(&format!("Failed to fetch detailed attendance: {:?}", e)),
    }
}

async fn handle_marks(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📝 Fetching Marks...\x1b[0m");

    let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
    let semester_id = if semester_id.is_empty() {
        "AP2024254".to_string()
    } else {
        semester_id
    };

    match api::vtop_get_client::fetch_marks(client, semester_id).await {
        Ok(marks) => {
            print_success("Marks retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", marks);
        }
        Err(e) => print_error(&format!("Failed to fetch marks: {:?}", e)),
    }
}

async fn handle_exam_schedule(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📋 Fetching Exam Schedule...\x1b[0m");

    let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
    let semester_id = if semester_id.is_empty() {
        "AP2024254".to_string()
    } else {
        semester_id
    };

    match api::vtop_get_client::fetch_exam_shedule(client, semester_id).await {
        Ok(schedule) => {
            print_success("Exam schedule retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", schedule);
        }
        Err(e) => print_error(&format!("Failed to fetch exam schedule: {:?}", e)),
    }
}

async fn handle_grade_history(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m🎯 Fetching Grade History...\x1b[0m");

    match api::vtop_get_client::fetch_grade_history(client).await {
        Ok(grades) => {
            print_success("Grade history retrieved successfully!");
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Grade History: {:?}", grades);
        }
        Err(e) => print_error(&format!("Failed to fetch grade history: {:?}", e)),
    }
}

async fn handle_faculty_search(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m🔍 Faculty Search...\x1b[0m");

    let search_term = get_user_input("Enter faculty name to search: ");
    if search_term.is_empty() {
        print_error("Search term cannot be empty!");
        return;
    }

    match api::vtop_get_client::fetch_faculty_search(client, search_term).await {
        Ok(faculty) => {
            print_success("Faculty search completed!");
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Faculty Results: {:?}", faculty);
        }
        Err(e) => print_error(&format!("Failed to search faculty: {:?}", e)),
    }
}

async fn handle_biometric_data(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📍 Fetching Biometric Data...\x1b[0m");

    let date = get_user_input("Enter date (YYYY-MM-DD) or press Enter for today: ");
    let date = if date.is_empty() {
        chrono::Utc::now().format("%Y-%m-%d").to_string()
    } else {
        date
    };

    match api::vtop_get_client::fetch_biometric_data(client, date).await {
        Ok(biometric) => {
            print_success("Biometric data retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", biometric);
        }
        Err(e) => print_error(&format!("Failed to fetch biometric data: {:?}", e)),
    }
}

async fn handle_wifi_operations() {
    print_separator();
    println!("\x1b[33m🌐 WiFi Operations...\x1b[0m");

    let username = get_user_input("Enter WiFi username: ");
    let password = get_user_input("Enter WiFi password: ");

    println!("Select operation:");
    println!("1. Login");
    println!("2. Logout");
    let choice = get_user_input("Enter choice (1-2): ");

    let operation = match choice.as_str() {
        "1" => 1,
        "2" => 0,
        _ => {
            print_error("Invalid choice!");
            return;
        }
    };

    let (success, message) = api::vtop_get_client::fetch_wifi(username, password, operation).await;

    if success {
        print_success(&format!("WiFi operation successful: {}", message));
    } else {
        print_error(&format!("WiFi operation failed: {}", message));
    }
}

async fn handle_general_outing(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m🏠 Submit General Outing Form...\x1b[0m");

    let out_place = get_user_input("Enter destination/place to visit: ");
    let purpose_of_visit = get_user_input("Enter purpose of visit: ");
    let outing_date = get_user_input("Enter outing date (DD-MMM-YYYY, e.g., 15-Mar-2024): ");
    let out_time = get_user_input("Enter departure time (HH:MM, e.g., 14:00): ");
    let in_date = get_user_input("Enter return date (DD-MMM-YYYY, e.g., 15-Mar-2024): ");
    let in_time = get_user_input("Enter return time (HH:MM, e.g., 18:00): ");

    if out_place.is_empty()
        || purpose_of_visit.is_empty()
        || outing_date.is_empty()
        || out_time.is_empty()
        || in_date.is_empty()
        || in_time.is_empty()
    {
        print_error("All fields are required!");
        return;
    }

    match api::vtop_get_client::submit_general_outing_form(
        client,
        out_place,
        purpose_of_visit,
        outing_date,
        out_time,
        in_date,
        in_time,
    )
    .await
    {
        Ok(response) => {
            print_success("General outing form submitted successfully!");
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Server Response:");
            println!("\x1b[37m{}\x1b[0m", response);
        }
        Err(e) => print_error(&format!("Failed to submit general outing form: {:?}", e)),
    }
}

async fn handle_weekend_outing(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m🎉 Submit Weekend Outing Form...\x1b[0m");

    let out_place = get_user_input("Enter destination/place to visit: ");
    let purpose_of_visit = get_user_input("Enter purpose of visit: ");
    let outing_date = get_user_input(
        "Enter outing date (DD-Mon-YY, e.g., 15-Dec-25 - must be Sunday or Monday): ",
    );

    println!("\x1b[36mAvailable time slots:\x1b[0m");
    println!("  1. 9:30 AM- 3:30PM");
    println!("  2. 10:30 AM- 4:30PM");
    println!("  3. 11:30 AM- 5:30PM");
    println!("  4. 12:30 PM- 6:30PM");
    let time_choice = get_user_input("Select time slot (1-4): ");
    let out_time = match time_choice.trim() {
        "1" => "9:30 AM- 3:30PM".to_string(),
        "2" => "10:30 AM- 4:30PM".to_string(),
        "3" => "11:30 AM- 5:30PM".to_string(),
        "4" => "12:30 PM- 6:30PM".to_string(),
        _ => {
            print_error("Invalid time slot selection!");
            return;
        }
    };

    let contact_number = get_user_input("Enter your contact number: ");

    if out_place.is_empty()
        || purpose_of_visit.is_empty()
        || outing_date.is_empty()
        || out_time.is_empty()
        || contact_number.is_empty()
    {
        print_error("All fields are required!");
        return;
    }

    match api::vtop_get_client::submit_weekend_outing_form(
        client,
        out_place,
        purpose_of_visit,
        outing_date,
        out_time,
        contact_number,
    )
    .await
    {
        Ok(response) => {
            print_success("Weekend outing form submitted successfully!");
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Server Response:");
            println!("\x1b[37m{}\x1b[0m", response);
        }
        Err(e) => print_error(&format!("Failed to submit weekend outing form: {:?}", e)),
    }
}

async fn handle_delete_general_outing(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m🗑️  Delete General Outing Application...\x1b[0m");

    // First, show existing outings
    print_info("Fetching your general outing reports...");
    match api::vtop_get_client::fetch_general_outing_reports(client).await {
        Ok(reports_json) => {
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Current General Outing Applications:");
            println!("\x1b[37m{}\x1b[0m", reports_json);
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
        }
        Err(e) => {
            print_error(&format!("Failed to fetch reports: {:?}", e));
            print_info("Continuing with deletion anyway...");
        }
    }

    let leave_id = get_user_input("\nEnter Leave ID to delete (e.g., L24044195432): ");

    if leave_id.is_empty() {
        print_error("Leave ID is required!");
        return;
    }

    print_info(&format!("Attempting to delete Leave ID: {}", leave_id));

    match api::vtop_get_client::delete_general_outing(client, leave_id.clone()).await {
        Ok(response) => {
            print_success(&format!(
                "General outing {} deletion request sent!",
                leave_id
            ));
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Server Response:");
            println!("\x1b[37m{}\x1b[0m", response);
        }
        Err(e) => print_error(&format!("Failed to delete general outing: {:?}", e)),
    }
}

async fn handle_delete_weekend_outing(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m🗑️  Delete Weekend Outing...\x1b[0m");

    // First, try to fetch and display weekend outing reports
    print_info("Fetching your weekend outing bookings...");
    match api::vtop_get_client::fetch_weekend_outing_reports(client).await {
        Ok(reports_json) => {
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Available Weekend Outing Bookings:");
            println!("\x1b[37m{}\x1b[0m", reports_json);
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
        }
        Err(e) => {
            print_error(&format!("Failed to fetch bookings: {:?}", e));
            print_info("Continuing with deletion anyway...");
        }
    }

    let booking_id = get_user_input("\nEnter Booking ID to delete (e.g., W24044341477): ");

    if booking_id.is_empty() {
        print_error("Booking ID is required!");
        return;
    }

    print_info(&format!("Attempting to delete Booking ID: {}", booking_id));

    match api::vtop_get_client::delete_weekend_outing(client, booking_id.clone()).await {
        Ok(response) => {
            print_success(&format!(
                "Weekend outing {} deletion request sent!",
                booking_id
            ));
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Server Response:");
            println!("\x1b[37m{}\x1b[0m", response);
        }
        Err(e) => print_error(&format!("Failed to delete weekend outing: {:?}", e)),
    }
}

async fn handle_digital_assignments(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📂 Fetching Digital Assignments...\x1b[0m");

    let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
    let semester_id = if semester_id.is_empty() {
        "AP2024254".to_string()
    } else {
        semester_id
    };

    match api::vtop_get_client::fetch_digital_assignments(client, semester_id).await {
        Ok(assignments) => {
            print_success("Digital assignments retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", assignments);
        }
        Err(e) => print_error(&format!("Failed to fetch digital assignments: {:?}", e)),
    }
}

async fn handle_digital_assignment_upload(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📂 Uploading Digital Assignment...\x1b[0m");

    let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
    let semester_id = if semester_id.is_empty() {
        "AP2024254".to_string()
    } else {
        semester_id
    };
    match api::vtop_get_client::fetch_digital_assignments(client, semester_id).await {
        Ok(assignments) => {
            print_success("Digital assignments retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", assignments);
        }
        Err(e) => print_error(&format!("Failed to fetch digital assignments: {:?}", e)),
    }
 
    let class_id = get_user_input("Enter class ID: ").to_string();
    let mode = get_user_input("Enter mode (Experiment-1 || DA01 || AST01): ").to_string();

    let path = FileDialog::new()
    .pick_file()
    .expect("No file selected");

    let file_name = path
        .file_name()
        .expect("Invalid file name")
        .to_string_lossy()
        .to_string();

    let file_bytes = fs::read(&path)
        .expect("Failed to read file");

    match api::vtop_get_client::upload_digital_assignment(
        client,
        class_id,
        mode,
        file_name,
        file_bytes,
    )
    .await{
        Ok(response) => {
            print_success("Digital assignment uploaded successfully!");
            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
            println!("Server Response:");
            println!("\x1b[37m{}\x1b[0m", response);
        }
        Err(e) => {
            match e {
                VtopError::DigitalAssignmentUploadOtpRequired => {
                    let otp_email = get_user_input("Enter OTP sent to your email: ");
                    match api::vtop_get_client::upload_digital_assignment_with_otp(client, otp_email).await {
                        Ok(response) => {
                            print_success("Digital assignment uploaded successfully with OTP!");
                            println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
                            println!("Server Response:");
                            println!("\x1b[37m{}\x1b[0m", response);
                        }
                        Err(e) => print_error(&format!("Failed to upload digital assignment with OTP: {:?}", e)),
                    }
                }
                _ => print_error(&format!("Failed to upload digital assignment: {:?}", e)),
            }
        }
    }
}
fn handle_system_info() {
    print_separator();
    println!("\x1b[33mℹ️  System Information\x1b[0m");
    println!("\x1b[36m{}\x1b[0m", "─".repeat(40));
    println!("📦 Library: lib_vtop v1.0.3");
    println!("🦀 Built with: Rust Edition 2021");
    println!("🏫 Target: VIT-AP Student Portal");
    println!("📅 Build Date: {}", chrono::Utc::now().format("%Y-%m-%d"));
    println!("🔧 Features: VTOP API, WiFi Management, Student Data");
    println!("📖 License: Apache-2.0");
}

#[tokio::main]
async fn main() {
    // Load environment variables from .env file
    dotenv().ok();

    // Clear screen and show welcome
    clear_screen();
    print_ascii_logo();
    print_welcome_message();

    // Check for credentials
    let username = env::var("VTOP_USERNAME").unwrap_or_else(|_| {
        print_info("No VTOP_USERNAME found in environment.");
        get_user_input("Enter VTOP username: ")
    });

    let password = env::var("VTOP_PASSWORD").unwrap_or_else(|_| {
        print_info("No VTOP_PASSWORD found in environment.");
        get_user_input("Enter VTOP password: ")
    });

    if username.is_empty() || password.is_empty() {
        print_error("Username and password are required!");
        print_info("Set VTOP_USERNAME and VTOP_PASSWORD environment variables or enter them when prompted.");
        return;
    }

    print_info(&format!("Using credentials for user: {}", username));

    // Create VTOP client
    let mut client = api::vtop_get_client::get_vtop_client(username, password);
    let mut is_authenticated = false;

    // Main application loop
    loop {
        print_menu();
        let choice = get_user_input("\n🎯 Enter your choice (0-18): ");
        match choice.as_str() {
            "0" => {
                clear_screen();
                print_ascii_logo();
                println!("\x1b[32m🎓 Thank you for using VTOP CLI!\x1b[0m");
                println!("\x1b[36m   Goodbye! 👋\x1b[0m");
                break;
            }
            "1" => {
                is_authenticated = handle_login(&mut client).await;
            }
            "2" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_student_profile(&mut client).await;
            }
            "3" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_timetable(&mut client).await;
            }
            "4" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_attendance(&mut client).await;
            }
            "5" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_marks(&mut client).await;
            }
            "6" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_exam_schedule(&mut client).await;
            }
            "7" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_grade_history(&mut client).await;
            }
            "8" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_faculty_search(&mut client).await;
            }
            "9" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_biometric_data(&mut client).await;
            }
            "10" => {
                handle_wifi_operations().await;
            }
            "11" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_general_outing(&mut client).await;
            }
            "12" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_weekend_outing(&mut client).await;
            }
            "13" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_delete_general_outing(&mut client).await;
            }
            "14" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_delete_weekend_outing(&mut client).await;
            }
            "15" => {
                handle_system_info();
            }
            "16" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_detailed_attendance(&mut client).await;
            }
            "17" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_digital_assignments(&mut client).await;
            }
            "18" => {
                if !is_authenticated {
                    print_error("Please login first (option 1)");
                    continue;
                }
                handle_digital_assignment_upload(&mut client).await;
            }
            _ => {
                print_error("Invalid choice! Please select a number between 0-18.");
            }
        }

        if choice != "0" {
            println!("\n\x1b[33mPress Enter to continue...\x1b[0m");
            let _ = get_user_input("");
        }
    }
}
