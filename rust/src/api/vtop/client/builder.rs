use crate::api::vtop::{
    session_manager::SessionManager, vtop_client::VtopClient, vtop_config::VtopConfig,
};

#[cfg(not(target_arch = "wasm32"))]
use reqwest::cookie::Jar;
use reqwest::{
    header::{HeaderMap, HeaderValue, USER_AGENT},
    Client,
};
use std::sync::Arc;

impl VtopClient {
    /// Creates a new VtopClient instance with the provided configuration and credentials.
    ///
    /// This is the primary constructor for creating a `VtopClient`. It initializes the HTTP client
    /// with appropriate headers, cookie storage, and session management. The client is configured
    /// differently depending on the target platform (native vs WebAssembly).
    ///
    /// # Arguments
    ///
    /// * `config` - Configuration object containing VTOP server URL and user agent settings
    /// * `session` - Session manager for handling authentication state and CSRF tokens
    /// * `username` - The student's registration number or login ID
    /// * `password` - The student's password for VTOP authentication
    ///
    /// # Returns
    ///
    /// Returns a new `VtopClient` instance ready for authentication and API operations.
    ///
    /// # Platform-Specific Behavior
    ///
    /// ## Native (non-WebAssembly)
    /// - Configures persistent cookie storage using `reqwest::cookie::Jar`
    /// - Sets comprehensive HTTP headers for browser-like behavior
    /// - Includes security headers (Sec-Fetch-*)
    ///
    /// ## WebAssembly
    /// - Uses browser's built-in cookie handling
    /// - Configures minimal required headers
    /// - Relies on browser security policies
    ///
    /// # Examples
    ///
    /// ```
    /// use lib_vtop::{VtopClient, VtopConfig, SessionManager};
    ///
    /// let config = VtopConfig::default();
    /// let session = SessionManager::new();
    /// let client = VtopClient::with_config(
    ///     config,
    ///     session,
    ///     "21BCE1234".to_string(),
    ///     "mypassword".to_string()
    /// );
    ///
    /// // Now you can use the client for authentication
    /// // client.login().await?;
    /// ```
    ///
    /// # Notes
    ///
    /// - The client stores credentials internally for re-authentication if the session expires
    /// - Cookie storage is automatically managed on native platforms
    /// - User agent can be customized via `VtopConfig` to match specific browser profiles
    pub fn with_config(
        config: VtopConfig,
        session: SessionManager,
        username: String,
        password: String,
    ) -> Self {
        #[cfg(not(target_arch = "wasm32"))]
        {
            let client = Self::make_client(session.get_cookie_store(), &config.user_agent);
            Self {
                client,
                config,
                session,
                current_page: None,
                username,
                password,
                captcha_data: None,
            }
        }
        #[cfg(target_arch = "wasm32")]
        {
            let mut headers = HeaderMap::new();
            headers.insert(
                USER_AGENT,
                HeaderValue::from_str(&config.user_agent).unwrap_or_else(|_| {
                    HeaderValue::from_static("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0")
                }),
            );
            headers.insert(
                "Content-Type",
                HeaderValue::from_static("application/x-www-form-urlencoded"),
            );
            let client = reqwest::Client::builder()
                .default_headers(headers)
                .build()
                .unwrap();
            Self {
                client,
                config,
                session,
                current_page: None,
                username,
                password,
                captcha_data: None,
            }
        }
    }

    /// Creates and configures an HTTP client for native (non-WebAssembly) platforms.
    ///
    /// This internal helper method constructs a `reqwest::Client` with all necessary HTTP headers
    /// and cookie storage configured for interacting with the VTOP system. The client mimics
    /// browser behavior to ensure compatibility with VTOP's server-side expectations.
    ///
    /// # Arguments
    ///
    /// * `cookie_store` - Arc-wrapped cookie jar for persistent cookie storage across requests
    /// * `user_agent` - User-Agent string to identify the client to the server
    ///
    /// # Returns
    ///
    /// Returns a fully configured `reqwest::Client` with:
    /// - Custom user agent (falls back to Firefox if invalid)
    /// - Accept headers for HTML content
    /// - Content-Type for form submissions
    /// - Security headers (Sec-Fetch-*) for modern browser compatibility
    /// - Cookie persistence enabled
    /// - Priority hints for request scheduling
    ///
    /// # HTTP Headers Set
    ///
    /// - `User-Agent`: Custom or default Firefox user agent
    /// - `Accept`: HTML and XML content types
    /// - `Accept-Language`: English (US and general)
    /// - `Content-Type`: Form URL-encoded data
    /// - `Upgrade-Insecure-Requests`: Enables HTTPS upgrade
    /// - `Sec-Fetch-Dest`, `Sec-Fetch-Mode`, `Sec-Fetch-Site`, `Sec-Fetch-User`: Security policy headers
    /// - `Priority`: Request priority hints
    #[cfg(not(target_arch = "wasm32"))]
    fn make_client(cookie_store: Arc<Jar>, user_agent: &str) -> Client {
        let mut headers = HeaderMap::new();

        headers.insert(
            USER_AGENT,
            HeaderValue::from_str(user_agent).unwrap_or_else(|_| {
                HeaderValue::from_static("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0")
            }),
        );
        headers.insert(
            "Accept",
            HeaderValue::from_static(
                "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            ),
        );
        headers.insert(
            "Accept-Language",
            HeaderValue::from_static("en-US,en;q=0.5"),
        );
        headers.insert(
            "Content-Type",
            HeaderValue::from_static("application/x-www-form-urlencoded"),
        );
        headers.insert("Upgrade-Insecure-Requests", HeaderValue::from_static("1"));
        headers.insert("Sec-Fetch-Dest", HeaderValue::from_static("document"));
        headers.insert("Sec-Fetch-Mode", HeaderValue::from_static("navigate"));
        headers.insert("Sec-Fetch-Site", HeaderValue::from_static("same-origin"));
        headers.insert("Sec-Fetch-User", HeaderValue::from_static("?1"));
        headers.insert("Priority", HeaderValue::from_static("u=0, i"));

        let client = reqwest::Client::builder()
            .default_headers(headers)
            .cookie_store(true)
            .cookie_provider(cookie_store)
            .build()
            .unwrap();
        client
    }
}
