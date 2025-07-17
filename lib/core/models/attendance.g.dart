// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      classNumber: json['class_number'] as String,
      faculty: json['faculty'] as String,
      courseId: json['course_id'] as String,
      courseCode: json['course_code'] as String,
      courseName: json['course_name'] as String,
      courseType: json['course_type'] as String,
      courseSlot: json['course_slot'] as String,
      attendedClasses: json['attended_classes'] as String,
      totalClasses: json['total_classes'] as String,
      attendancePercentage: json['attendance_percentage'] as String,
      betweenAttendancePercentage:
          json['attendance_between_percentage'] as String,
      debarStatus: json['debar_status'] as String,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class_number': instance.classNumber,
      'course_code': instance.courseCode,
      'course_name': instance.courseName,
      'course_type': instance.courseType,
      'course_slot': instance.courseSlot,
      'faculty': instance.faculty,
      'attended_classes': instance.attendedClasses,
      'total_classes': instance.totalClasses,
      'attendance_percentage': instance.attendancePercentage,
      'attendance_between_percentage': instance.betweenAttendancePercentage,
      'debar_status': instance.debarStatus,
      'course_id': instance.courseId,
    };
