// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      courseId: json['course_id'] as String,
      courseCode: json['course_code'] as String,
      courseName: json['course_name'] as String,
      courseType: json['course_type'] as String,
      courseSlot: json['course_slot'] as String,
      attendedClasses: json['attended_classes'] as String,
      totalClasses: json['total_classes'] as String,
      attendancePercentage: json['attendance_percentage'] as String,
      withinAttendancePercentage:
          json['within_attendance_percentage'] as String,
      debarStatus: json['debar_status'] as String,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'course_code': instance.courseCode,
      'course_name': instance.courseName,
      'course_type': instance.courseType,
      'course_slot': instance.courseSlot,
      'attended_classes': instance.attendedClasses,
      'total_classes': instance.totalClasses,
      'attendance_percentage': instance.attendancePercentage,
      'within_attendance_percentage': instance.withinAttendancePercentage,
      'debar_status': instance.debarStatus,
    };
