use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
pub struct GetFaculty {
    pub faculty_name: String,
    pub designation: String,
    pub school_or_centre: String,
    pub emp_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct FacultyDetails {
    pub name: String,
    pub designation: String,
    pub department: String,
    pub school_centre: String,
    pub email: String,
    pub cabin_number: String,
    pub office_hours: Vec<OfficeHour>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct OfficeHour {
    pub day: String,
    pub timings: String,
}
