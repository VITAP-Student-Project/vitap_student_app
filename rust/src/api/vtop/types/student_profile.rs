use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::vtop::types::{GradeHistory, MentorDetails};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct StudentProfile {
    pub application_number: String,
    /// The student's registration number (e.g. `23BCE7625`).
    ///
    /// This is *not* the value the user typed on the login screen — VTOP accepts
    /// several login ids — so it is scraped from the `authorizedIDX` hidden field
    /// after authentication and filled in by `VtopClient::get_student_profile`.
    /// The HTML profile page itself does not carry it, so the parser leaves this
    /// empty and the client populates it.
    #[serde(default)]
    pub registration_number: String,
    pub student_name: String,
    pub dob: String,
    pub gender: String,
    pub blood_group: String,
    pub email: String,
    pub base64_pfp: String,
    pub grade_history: GradeHistory,
    pub mentor_details: MentorDetails,
}
