use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct TimetableClass {
    pub start_time: String,
    pub end_time: String,
    pub course_name: String,
    pub slot: String,
    pub venue: String,
    pub faculty: String,
    pub course_code: String,
    pub course_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct Timetable {
    #[serde(rename = "Monday")]
    pub monday: Vec<TimetableClass>,
    #[serde(rename = "Tuesday")]
    pub tuesday: Vec<TimetableClass>,
    #[serde(rename = "Wednesday")]
    pub wednesday: Vec<TimetableClass>,
    #[serde(rename = "Thursday")]
    pub thursday: Vec<TimetableClass>,
    #[serde(rename = "Friday")]
    pub friday: Vec<TimetableClass>,
    #[serde(rename = "Saturday")]
    pub saturday: Vec<TimetableClass>,
    #[serde(rename = "Sunday")]
    pub sunday: Vec<TimetableClass>,
}
