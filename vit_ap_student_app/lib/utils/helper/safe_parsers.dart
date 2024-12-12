// Safe parsing methods to handle potential errors or empty data
import 'dart:developer';

import '../model/attendance_model.dart';
import '../model/exam_schedule_model.dart';
import '../model/marks_model.dart';
import '../model/profile_model.dart';
import '../model/timetable_model.dart';

Map<String, Attendance> safeParseAttendance(dynamic attendanceData) {
  try {
    if (attendanceData == null) return {};
    return Map.from(attendanceData).map(
      (k, v) => MapEntry<String, Attendance>(
          k.toString(),
          v is Map
              ? Attendance.fromJson(Map<String, dynamic>.from(v))
              : Attendance.empty()),
    );
  } catch (e) {
    log("Error parsing attendance: $e");
    return {};
  }
}

List<ExamSchedule> safeParseExamSchedule(dynamic examScheduleData) {
  try {
    if (examScheduleData == null) return [];
    return List<ExamSchedule>.from(
      examScheduleData.map((x) => x is Map
          ? ExamSchedule.fromJson(Map<String, dynamic>.from(x))
          : ExamSchedule.empty()),
    );
  } catch (e) {
    log("Error parsing exam schedule: $e");
    return [];
  }
}

List<Mark> safeParseMarks(dynamic marksData) {
  try {
    if (marksData == null) return [];
    return List<Mark>.from(
      marksData.map((x) => x is Map
          ? Mark.fromJson(Map<String, dynamic>.from(x))
          : Mark.empty()),
    );
  } catch (e) {
    log("Error parsing marks: $e");
    return [];
  }
}

Profile safeParseProfile(dynamic profileData) {
  try {
    return profileData is Map
        ? Profile.fromJson(Map<String, dynamic>.from(profileData))
        : Profile.empty();
  } catch (e) {
    log("Error parsing profile: $e");
    return Profile.empty();
  }
}

Timetable safeParseTimetable(dynamic timetableData) {
  try {
    return timetableData is Map
        ? Timetable.fromJson(Map<String, dynamic>.from(timetableData))
        : Timetable.empty();
  } catch (e) {
    log("Error parsing timetable: $e");
    return Timetable.empty();
  }
}
