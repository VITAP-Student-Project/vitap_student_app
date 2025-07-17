use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct BiometricRecord {
    pub serial: String,
    pub date: String,
    pub day: String,
    pub in_time: String,
    pub out_time: String,
    pub duration: String,
    pub location: String,
}
