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

impl std::fmt::Display for VtopError {
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
