use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

/// A class group option, e.g. `COMB` "All Class Group (Combined)".
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct ClassGroup {
    pub id: String,
    pub name: String,
}

/// A month button on the calendar page.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct CalendarMonthRef {
    /// What VTOP shows on the button, e.g. "AUG-2026".
    pub label: String,
    /// What `processViewCalendar` expects, e.g. "01-AUG-2026". Different from
    /// the label, so both are kept.
    pub cal_date: String,
}

/// One entry on a calendar day.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct CalendarEvent {
    /// e.g. "Instructional Day - General (Semester)".
    pub description: String,
    /// The parenthesised qualifier with its brackets stripped: "WorkingDay",
    /// "Holiday", "No Instructional Day", or a named holiday. Empty when VTOP
    /// gave the entry no qualifier.
    pub label: String,
}

/// A single dated day of the academic calendar.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct CalendarDay {
    /// ISO `YYYY-MM-DD`, derived from the month being viewed.
    pub date: String,
    pub day: u32,
    /// "Sunday" through "Saturday", taken from the column the day sits in.
    pub weekday: String,
    pub events: Vec<CalendarEvent>,
}

/// A semester's academic calendar, flattened.
///
/// VTOP renders each month as a week grid, but the grid is a display concern:
/// the days are carried here as one date-ordered list, so the app can look up a
/// date, filter holidays, or lay out its own view.
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
#[frb(dart_metadata=("freezed", "immutable" import "package:meta/meta.dart" as meta))]
#[frb]
#[frb(json_serializable)]
pub struct AcademicCalendar {
    pub semester_id: String,
    pub class_group_id: String,
    pub months: Vec<CalendarMonthRef>,
    pub days: Vec<CalendarDay>,
}
