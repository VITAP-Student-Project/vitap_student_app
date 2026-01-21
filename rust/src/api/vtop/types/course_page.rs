use serde::{Deserialize, Serialize};

/// Represents a course option available in the course page dropdown
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CourseOption {
    /// The unique identifier for the course (e.g., "AP2025264000394")
    pub value: String,
    /// The display name (e.g., "CSE2009 - Soft Computing - ETH")
    pub label: String,
    /// The course code extracted from label (e.g., "CSE2009")
    pub course_code: String,
    /// The course title (e.g., "Soft Computing")
    pub course_title: String,
    /// The course type (e.g., "ETH", "EPJ", "ELA", "TH")
    pub course_type: String,
}

/// Represents a slot option for a course
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SlotOption {
    /// The unique identifier for the slot (e.g., "3688")
    pub value: String,
    /// The slot display name (e.g., "E1+TE1")
    pub label: String,
}

/// Represents a faculty option for a course
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FacultyOption {
    /// The faculty ERP ID
    pub erp_id: String,
    /// The faculty display name
    pub name: String,
    /// The department
    pub department: String,
}

/// Represents a class entry in the course slots table
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CourseClassEntry {
    /// Serial number
    pub sl_no: i32,
    /// Class group (e.g., "General (Semester)")
    pub class_group: String,
    /// Course code
    pub course_code: String,
    /// Course title
    pub course_title: String,
    /// Course type (e.g., "Embedded Theory")
    pub course_type: String,
    /// Class ID
    pub class_id: String,
    /// Slot (e.g., "E1/TE1")
    pub slot: String,
    /// Faculty info (e.g., "70735 - Shaik Subhani - SCOPE")
    pub faculty: String,
    /// Semester ID
    pub semester_id: String,
    /// Faculty ERP ID for view action
    pub erp_id: String,
}

/// Represents a reference material attached to a lecture
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ReferenceMaterial {
    /// Material label (e.g., "Reference Material I")
    pub label: String,
    /// Download path (e.g., "downloadPdf/AP2025264/AP2025264000442/19/10-12-2025")
    pub download_path: String,
}

/// Represents a lecture entry in the course detail page
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LectureEntry {
    /// Serial number
    pub sl_no: i32,
    /// Lecture date (e.g., "10-12-2025")
    pub date: String,
    /// Formatted date (e.g., "10-Dec-2025")
    pub formatted_date: String,
    /// Day of week (e.g., "WED")
    pub day: String,
    /// Lecture topic
    pub topic: String,
    /// Reference materials attached to this lecture
    pub reference_materials: Vec<ReferenceMaterial>,
}

/// Represents course information in the detail view
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CourseInfo {
    /// Class group
    pub class_group: String,
    /// Course code
    pub course_code: String,
    /// Course title
    pub course_title: String,
    /// Course type
    pub course_type: String,
    /// Class ID
    pub class_id: String,
    /// Slot
    pub slot: String,
    /// Faculty name
    pub faculty: String,
    /// Course ID (e.g., "AM_CSE2009_00110")
    pub course_id: String,
}

/// Represents the detailed course page with all materials
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoursePageDetail {
    /// Course information
    pub course_info: CourseInfo,
    /// Semester ID
    pub semester_id: String,
    /// Download all materials path
    pub download_all_path: Option<String>,
    /// Download general materials path
    pub download_general_materials_path: Option<String>,
    /// Syllabus download path
    pub syllabus_download_path: Option<String>,
    /// Course plan excel download path
    pub course_plan_download_path: Option<String>,
    /// All lectures with their materials
    pub lectures: Vec<LectureEntry>,
}

/// Response for getting courses for a semester
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoursesResponse {
    /// List of available courses
    pub courses: Vec<CourseOption>,
}

/// Response for getting slots for a course
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SlotsResponse {
    /// List of available slots
    pub slots: Vec<SlotOption>,
    /// List of class entries
    pub class_entries: Vec<CourseClassEntry>,
}
