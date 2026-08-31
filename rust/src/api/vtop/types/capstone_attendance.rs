use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

/// The registration details shown above the capstone attendance summary.
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct CapstoneInfo {
    /// "Capstone" or "SDP".
    pub title: String,
    pub guide_evaluation_status: String,
    pub date_of_registration: String,
}

/// The present / on-duty / absent tally for the capstone.
///
/// Deliberately not folded into attended/total the way a course is: a day
/// marked on duty is neither attended nor absent, and collapsing the three
/// counts loses that.
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct CapstoneSummary {
    pub present: String,
    pub on_duty: String,
    pub absent: String,
    /// The "%" sign is stripped, matching `AttendanceRecord::attendance_percentage`,
    /// so the Dart side can `double.tryParse` it.
    pub percentage: String,
}

/// One day in the capstone attendance calendar.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct CapstonePunch {
    pub serial: String,
    pub date: String,
    pub day: String,
    /// Free text from VTOP: "Instructional", "Holiday", "No Instructional",
    /// "CAT1", ... Deliberately not an enum, since VTOP adds day types.
    pub day_type: String,
    /// "Present", "Absent" or "On Duty". Empty for days carrying no status at
    /// all (holidays, non-instructional days, days not yet reached), which VTOP
    /// renders as "-".
    pub status: String,
    /// Empty when there was no punch, which VTOP also renders as "-".
    pub punch_time: String,
}

/// Capstone/SDP attendance for one semester.
///
/// This is not per-course, so it does not fit [`super::attendance::AttendanceRecord`]:
/// there is no course code, faculty or slot, and the tally is
/// present/on-duty/absent rather than attended/total. VTOP returns the summary
/// and the day-by-day calendar in a single response, so both live here.
///
/// The sub-structs group the fields the way VTOP's three tables do, but they
/// are flattened on the wire: the app persists a capstone as one record, so a
/// flat JSON object is what the Dart side wants to read.
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct CapstoneAttendance {
    #[serde(flatten)]
    pub info: CapstoneInfo,
    #[serde(flatten)]
    pub summary: CapstoneSummary,
    pub punches: Vec<CapstonePunch>,
}
