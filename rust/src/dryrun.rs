mod api;

use std::env;
use std::io::{self, Write};

use dotenv::dotenv;

fn print_ascii_logo() {
    println!("\x1b[36m"); // Cyan color
    println!(r#"
╦ ╦╔╦╗╔═╗╔═╗  ╔═╗╦  ╦
║ ║ ║ ║ ║╠═╝  ║  ║  ║
╩═╝ ╩ ╚═╝╩    ╚═╝╩═╝╩

    ┌─────────────────────────────────────┐
    │        VTOP Client Terminal         │
    │       Interactive Test Suite        │
    └─────────────────────────────────────┘
    "#);
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
    println!("│ 11. ℹ️  System Information                              │");
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
            let semester_id = if semester_id.is_empty() { "AP2024254".to_string() } else { semester_id };
            
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
    let semester_id = if semester_id.is_empty() { "AP2024254".to_string() } else { semester_id };
    
    match api::vtop_get_client::fetch_attendance(client, semester_id).await {
        Ok(attendance) => {
            print_success("Attendance retrieved successfully!");
            println!("\x1b[37m{}\x1b[0m", attendance);
        }
        Err(e) => print_error(&format!("Failed to fetch attendance: {:?}", e)),
    }
}

async fn handle_marks(client: &mut api::vtop::vtop_client::VtopClient) {
    print_separator();
    println!("\x1b[33m📝 Fetching Marks...\x1b[0m");
    
    let semester_id = get_user_input("Enter semester ID (or press Enter for default): ");
    let semester_id = if semester_id.is_empty() { "AP2024254".to_string() } else { semester_id };
    
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
    let semester_id = if semester_id.is_empty() { "AP2024254".to_string() } else { semester_id };
    
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
        let choice = get_user_input("\n🎯 Enter your choice (0-11): ");
        
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
                handle_system_info();
            }
            _ => {
                print_error("Invalid choice! Please select a number between 0-11.");
            }
        }
        
        if choice != "0" {
            println!("\n\x1b[33mPress Enter to continue...\x1b[0m");
            let _ = get_user_input("");
        }
    }
}
