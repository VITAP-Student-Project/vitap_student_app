// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @JsonKey(name: 'class_number')
  final String classNumber;

  @JsonKey(name: 'course_code')
  final String courseCode;

  @JsonKey(name: 'course_name')
  final String courseName;

  @JsonKey(name: 'course_type')
  final String courseType;

  @JsonKey(name: 'course_type_code')
  final String courseTypeCode;

  @JsonKey(name: 'course_slot')
  final String courseSlot;

  @JsonKey(name: 'faculty')
  final String faculty;

  @JsonKey(name: 'attended_classes')
  final String attendedClasses;

  @JsonKey(name: 'total_classes')
  final String totalClasses;

  @JsonKey(name: 'attendance_percentage')
  final String attendancePercentage;

  @JsonKey(name: 'attendance_between_percentage')
  final String betweenAttendancePercentage;

  @JsonKey(name: 'debar_status')
  final String debarStatus;

  @JsonKey(name: 'course_id')
  final String courseId;

  Attendance({
    this.id,
    required this.classNumber,
    required this.faculty,
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.courseType,
    required this.courseTypeCode,
    required this.courseSlot,
    required this.attendedClasses,
    required this.totalClasses,
    required this.attendancePercentage,
    required this.betweenAttendancePercentage,
    required this.debarStatus,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);

  @override
  String toString() {
    return 'Attendance(id: $id, classNumber: $classNumber, courseCode: $courseCode, courseName: $courseName, courseType: $courseType, courseTypeCode: $courseTypeCode, courseSlot: $courseSlot, faculty: $faculty, attendedClasses: $attendedClasses, totalClasses: $totalClasses, attendancePercentage: $attendancePercentage, betweenAttendancePercentage: $betweenAttendancePercentage, debarStatus: $debarStatus, courseId: $courseId)';
  }
}
