pub use super::session_manager::SessionManager;
pub use super::types::*;
pub use super::vtop_config::VtopConfig;
pub use super::vtop_errors::VtopError;
pub use super::vtop_errors::VtopResult;

#[cfg(not(target_arch = "wasm32"))]
pub use reqwest::cookie::{CookieStore, Jar};
use reqwest::Client;

pub struct VtopClient {
    pub(crate) client: Client,
    pub(crate) config: VtopConfig,
    pub(crate) session: SessionManager,
    pub(crate) current_page: Option<String>,
    pub(crate) username: String,
    pub(crate) password: String,
    pub(crate) captcha_data: Option<String>,
}
