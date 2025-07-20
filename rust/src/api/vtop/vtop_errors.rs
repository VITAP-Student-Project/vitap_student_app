use flutter_rust_bridge::frb;
use serde::Serialize;

#[derive(Debug, Clone, Serialize)]
#[frb(non_opaque)]
pub enum VtopError {
    NetworkError,
    VtopServerError,
    AuthenticationFailed(String),
    RegistrationParsingError,
    InvalidCredentials,
    SessionExpired,
    ParseError(String),
    ConfigurationError(String),
    CaptchaRequired,
    InvalidResponse,
}

impl VtopError {
    /// Get a human-readable error message for display to users
    #[frb]
    pub fn message(&self) -> String {
        match self {
            VtopError::NetworkError => "No internet connection. Please check your network and try again.".to_string(),
            VtopError::VtopServerError => "VTOP server is temporarily unavailable. Please try again later.".to_string(),
            VtopError::AuthenticationFailed(msg) => {
                if msg.is_empty() {
                    "Login failed. Please check your credentials.".to_string()
                } else {
                    format!("Login failed: {}", msg)
                }
            },
            VtopError::RegistrationParsingError => "Invalid registration number format. Please check and try again.".to_string(),
            VtopError::InvalidCredentials => "Invalid username or password. Please try again.".to_string(),
            VtopError::SessionExpired => "Your session has expired. Please login again.".to_string(),
            VtopError::ParseError(msg) => {
                if msg.is_empty() {
                    "Unable to process server response. Please try again.".to_string()
                } else {
                    format!("Data processing error: {}", msg)
                }
            },
            VtopError::ConfigurationError(msg) => {
                if msg.is_empty() {
                    "App configuration error. Please restart the app.".to_string()
                } else {
                    format!("Configuration error: {}", msg)
                }
            },
            VtopError::CaptchaRequired => "Please complete the captcha verification.".to_string(),
            VtopError::InvalidResponse => "Received unexpected response from server. Please try again.".to_string(),
        }
    }
    
    /// Get the error type as a string for programmatic handling
    #[frb]
    pub fn error_type(&self) -> String {
        match self {
            VtopError::NetworkError => "NetworkError".to_string(),
            VtopError::VtopServerError => "VtopServerError".to_string(),
            VtopError::AuthenticationFailed(_) => "AuthenticationFailed".to_string(),
            VtopError::RegistrationParsingError => "RegistrationParsingError".to_string(),
            VtopError::InvalidCredentials => "InvalidCredentials".to_string(),
            VtopError::SessionExpired => "SessionExpired".to_string(),
            VtopError::ParseError(_) => "ParseError".to_string(),
            VtopError::ConfigurationError(_) => "ConfigurationError".to_string(),
            VtopError::CaptchaRequired => "CaptchaRequired".to_string(),
            VtopError::InvalidResponse => "InvalidResponse".to_string(),
        }
    }

    /// Get the raw error details for debugging (not for end users)
    #[frb]
    pub fn debug_message(&self) -> String {
        format!("{}", self)
    }
}

impl std::fmt::Display for VtopError {
    #[frb]
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            VtopError::NetworkError => write!(f, "Network connection error"),
            VtopError::VtopServerError => write!(f, "VTOP server error"),
            VtopError::AuthenticationFailed(msg) => write!(f, "Authentication failed: {}", msg),
            VtopError::RegistrationParsingError => write!(f, "Failed to parse registration number"),
            VtopError::InvalidCredentials => write!(f, "Invalid username or password"),
            VtopError::SessionExpired => write!(f, "Session has expired"),
            VtopError::ParseError(msg) => write!(f, "Parse error: {}", msg),
            VtopError::ConfigurationError(msg) => write!(f, "Configuration error: {}", msg),
            VtopError::CaptchaRequired => write!(f, "Captcha verification required"),
            VtopError::InvalidResponse => write!(f, "Invalid response from server"),
        }
    }
}

impl std::error::Error for VtopError {}

pub type VtopResult<T> = Result<T, VtopError>;
