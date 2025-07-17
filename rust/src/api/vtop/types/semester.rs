use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct SemesterInfo {
    pub id: String,
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct SemesterData {
    pub semesters: Vec<SemesterInfo>,
    pub update_time: u64,
}
