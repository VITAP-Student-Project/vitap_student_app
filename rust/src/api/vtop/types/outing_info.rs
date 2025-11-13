use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[frb(dart_metadata=("freezed"))]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
/// Student information pre-filled in outing forms
pub struct OutingInfo {
    pub registration_number: String,
    pub name: String,
    pub application_no: String,
    pub gender: String,
    pub hostel_block: String,
    pub room_number: String,
    pub parent_contact_number: String,
}
