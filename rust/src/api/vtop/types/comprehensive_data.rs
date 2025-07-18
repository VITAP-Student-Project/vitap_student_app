use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::vtop::types::{
    AttendanceRecord, GradeCourseHistory, Marks, PerExamScheduleRecord,
    StudentProfile, Timetable,
};

/// Comprehensive response containing all student data in a single structure.
/// This includes profile, attendance, timetable, exam schedule, grade history, and marks.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb(json_serializable)]
#[frb]
pub struct ComprehensiveDataResponse {
    /// Student profile information including basic details and mentor information
    pub profile: StudentProfile,
    /// List of attendance records for all courses in the semester
    pub attendance: Vec<AttendanceRecord>,
    /// Timetable slots showing class schedules
    pub timetable: Timetable,
    /// Exam schedule records for the semester
    pub exam_schedule: Vec<PerExamScheduleRecord>,
    /// Marks records for all courses in the semester
    pub marks: Vec<Marks>,
}
