use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct AssignmentRecordEach {
    pub serial_number: String,
    pub assignment_title: String,
    pub max_assignment_mark: String,
    pub assignment_weightage_mark: String,
    pub due_date: String,
    pub can_qp_download: bool,
    pub qp_download_url: String,
    pub submission_status: String,
    pub can_update: bool,
    pub can_da_download: bool,
    pub da_download_url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct DigitalAssignments {
    pub serial_number: String,
    pub class_id: String,
    pub course_code: String,
    pub course_title: String,
    pub course_type: String,
    pub faculty: String,
    pub details: Vec<AssignmentRecordEach>,
}
