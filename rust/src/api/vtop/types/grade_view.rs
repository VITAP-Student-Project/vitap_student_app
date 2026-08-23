use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

/// One course row from the grade view for a semester.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct GradeViewCourse {
    pub serial_number: String,
    pub course_code: String,
    pub course_title: String,
    pub course_type: String,
    pub grading_type: String,
    pub grand_total: String,
    pub grade: String,
    /// Needed to request the per-course detail.
    pub course_id: String,
}

/// One assessment component of a course (CAT1, FAT, a quiz, ...).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct MarkComponent {
    pub serial_number: String,
    pub mark_title: String,
    pub max_mark: String,
    pub weightage: String,
    pub status: String,
    pub scored_mark: String,
    pub weightage_mark: String,
}

/// The mark range that maps to one letter grade for the class.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct GradeRange {
    pub grade: String,
    pub range: String,
}

/// Class-level statistics shown alongside a course's grade.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct GradeStatistics {
    pub class_strength: String,
    pub grading_strength: String,
    pub mean: String,
    pub sd: String,
    pub grade_ranges: Vec<GradeRange>,
}

/// The expanded detail for a single course in the grade view.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct GradeViewDetail {
    pub class_number: String,
    pub course_type: String,
    pub marks: Vec<MarkComponent>,
    pub total: String,
    pub statistics: GradeStatistics,
}
