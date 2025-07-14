use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::vtop::types::{GradeHistory, MentorDetails};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct StudentProfile {
    pub application_number: String,
    pub student_name: String,
    pub dob: String,
    pub gender: String,
    pub blood_group: String,
    pub email: String,
    pub base64_pfp: String,
    pub grade_history: GradeHistory,
    pub mentor_details: MentorDetails,
}
