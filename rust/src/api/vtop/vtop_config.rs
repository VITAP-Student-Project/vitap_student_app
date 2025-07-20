use serde::{Deserialize, Serialize};
use fake_useragent::UserAgents;

use super::{session_manager::SessionManager, vtop_client::VtopClient};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VtopConfig {
    pub base_url: String,
    pub timeout_seconds: u64,
    pub user_agent: String,
}

impl Default for VtopConfig {
    fn default() -> Self {
        let base_url = "https://vtop.vitap.ac.in".to_string();
        #[cfg(target_arch = "wasm32")]
        {}

        Self {
            base_url: base_url,
            timeout_seconds: 30,
            user_agent: Self::random_user_agent(),
        }
    }
}

impl VtopConfig {
    fn random_user_agent() -> String {
        let user_agents = UserAgents::new();
        user_agents.random().to_string()
    }
}

pub struct VtopClientBuilder {
    config: VtopConfig,
    session: SessionManager,
}

impl VtopClientBuilder {
    pub fn new() -> Self {
        Self {
            config: VtopConfig::default(),
            session: SessionManager::new(),
        }
    }

    pub fn timeout(mut self, seconds: u64) -> Self {
        self.config.timeout_seconds = seconds;
        self
    }

    pub fn build(self, username: String, password: String) -> VtopClient {
        VtopClient::with_config(self.config, self.session, username.to_uppercase(), password)
    }
}
