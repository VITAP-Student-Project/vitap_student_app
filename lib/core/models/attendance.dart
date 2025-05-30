import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'attendance.g.dart';

List<Attendance> attendanceFromJson(String str) =>
    List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendanceToJson(List<Attendance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Entity()
@JsonSerializable()
class Attendance {
  @Id()
  int? id;

  @JsonKey(name: 'course_id')
  final String courseId;

  @JsonKey(name: 'course_code')
  final String courseCode;

  @JsonKey(name: 'course_name')
  final String courseName;

  @JsonKey(name: 'course_type')
  final String courseType;

  @JsonKey(name: 'course_slot')
  final String courseSlot;

  @JsonKey(name: 'attended_classes')
  final String attendedClasses;

  @JsonKey(name: 'total_classes')
  final String totalClasses;

  @JsonKey(name: 'attendance_percentage')
  final String attendancePercentage;

  @JsonKey(name: 'within_attendance_percentage')
  final String withinAttendancePercentage;

  @JsonKey(name: 'debar_status')
  final String debarStatus;

  Attendance({
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.courseType,
    required this.courseSlot,
    required this.attendedClasses,
    required this.totalClasses,
    required this.attendancePercentage,
    required this.withinAttendancePercentage,
    required this.debarStatus,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
