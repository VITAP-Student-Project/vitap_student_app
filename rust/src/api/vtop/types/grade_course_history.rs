use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct GradeCourseHistory {
    pub course_code: String,
    pub course_title: String,
    pub course_type: String,
    pub credits: String,
    pub grade: String,
    pub exam_month: String,
    pub course_distribution: String,
}
