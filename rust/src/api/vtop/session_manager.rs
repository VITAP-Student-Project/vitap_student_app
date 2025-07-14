use std::sync::Arc;

#[cfg(not(target_arch = "wasm32"))]
use reqwest::cookie::Jar;

#[derive(Debug)]

pub struct SessionManager {
    csrf_token: Option<String>,
    #[cfg(not(target_arch = "wasm32"))]
    cookie_store: Arc<Jar>,
    is_authenticated: bool,
}

impl SessionManager {
    pub fn new() -> Self {
        #[cfg(not(target_arch = "wasm32"))]
        let jar = Jar::default();
        #[cfg(not(target_arch = "wasm32"))]
        let cookie_store = Arc::new(jar);
        Self {
            csrf_token: None,
            #[cfg(not(target_arch = "wasm32"))]
            cookie_store,
            is_authenticated: false,
        }
    }

    pub fn set_csrf_token(&mut self, token: String) {
        self.csrf_token = Some(token);
    }

    pub fn get_csrf_token(&self) -> Option<String> {
        self.csrf_token.clone()
    }
    #[cfg(not(target_arch = "wasm32"))]
    pub fn get_cookie_store(&self) -> Arc<Jar> {
        self.cookie_store.clone()
    }

    pub fn set_authenticated(&mut self, authenticated: bool) {
        self.is_authenticated = authenticated;
    }

    pub fn is_authenticated(&self) -> bool {
        self.is_authenticated
    }

    pub fn clear(&mut self) {
        self.csrf_token = None;
        self.is_authenticated = false;
    }

    pub fn set_csrf_from_external(&mut self, token: String) {
        self.csrf_token = Some(token);
    }
    //  pub fn set_cookie_from_external(&mut self, token: String) {
    //     self.csrf_token = Some(token);

    // }
}
