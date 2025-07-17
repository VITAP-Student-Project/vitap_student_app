mod api;

use std::env;

use dotenv::dotenv;

fn info() -> &'static str {
    "lib_vtop v0.1.0"
}

#[tokio::main]
async fn main() {
    // Load environment variables from .env file
    dotenv().ok();

    // Initialize logging
    env_logger::init();

    println!("=== lib_vtop Dry Run Demo ===");
    println!("Library: {}", info());

    // Test basic greeting functionality
    let greeting = api::simple::greet("Dry Run User".to_string());
    println!("Greeting: {}", greeting);

    // Check if credentials are provided via environment variables
    let username = env::var("VTOP_USERNAME").unwrap_or_else(|_| "demo_user".to_string());
    let password = env::var("VTOP_PASSWORD").unwrap_or_else(|_| "demo_pass".to_string());

    println!("\n=== VTOP Client Demo ===");
    println!("Username: {}", username);

    // Create VTOP client
    let mut client = api::vtop_get_client::get_vtop_client(username, password);
    println!(
        "VTOP client created. Authenticated: {:?}",
        client.is_authenticated()
    );

    // If real credentials are provided, attempt login
    if env::var("VTOP_USERNAME").is_ok() && env::var("VTOP_PASSWORD").is_ok() {
        println!("Attempting real login...");
        match api::vtop_get_client::vtop_client_login(&mut client).await {
            Ok(_) => println!("✅ VTOP login successful"),
            Err(e) => println!("❌ VTOP login failed: {:?}", e),
        }
        //  "AP2024258".to_string()
        match api::vtop_get_client::fetch_exam_shedule(&mut client, "AP2024252".to_string()).await {
            Ok(result) => match serde_json::to_string_pretty(&result) {
                Ok(json) => println!("✅ Profile (JSON):\n{}", json),
                Err(e) => println!("❌ Failed to serialize profile to JSON: {:?}", e),
            },
            Err(e) => println!("❌ VTOP fetch_all_data failed: {:?}", e),
        }
    } else {
        println!("ℹ️  No real credentials provided. Use VTOP_USERNAME and VTOP_PASSWORD env vars for real testing.");
    }

    println!("\n=== Dry Run Complete ===");
}
