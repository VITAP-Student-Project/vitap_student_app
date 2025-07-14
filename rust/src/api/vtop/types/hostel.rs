use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct OutingRecord {
    pub serial: String,
    pub registration_number: String,
    pub hostel_block: String,
    pub room_number: String,
    pub place_of_visit: String,
    pub purpose_of_visit: String,
    pub time: String,
    pub contact_number: String,
    pub parent_contact_number: String,
    pub date: String,
    pub booking_id: String,
    pub status: String,
    pub can_download: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct HostelOutingData {
    pub records: Vec<OutingRecord>,
    pub update_time: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct OutingFormData {
    pub purpose_of_visit: String,
    pub outing_date: String,
    pub contact_number: String,
    pub out_place: String,
    pub out_time: String,
    pub parent_contact_number: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct LeaveRecord {
    pub serial: String,
    pub registration_number: String,
    pub place_of_visit: String,
    pub purpose_of_visit: String,
    pub from_date: String,
    pub from_time: String,
    pub to_date: String,
    pub to_time: String,
    pub status: String,
    pub can_download: bool,
    pub leave_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct HostelLeaveData {
    pub records: Vec<LeaveRecord>,
    pub update_time: u64,
}

