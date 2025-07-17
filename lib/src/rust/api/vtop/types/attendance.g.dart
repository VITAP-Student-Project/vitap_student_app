// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceDetailRecord _$AttendanceDetailRecordFromJson(
        Map<String, dynamic> json) =>
    _AttendanceDetailRecord(
      serial: json['serial'] as String,
      date: json['date'] as String,
      slot: json['slot'] as String,
      dayTime: json['dayTime'] as String,
      status: json['status'] as String,
      remark: json['remark'] as String,
    );

Map<String, dynamic> _$AttendanceDetailRecordToJson(
        _AttendanceDetailRecord instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'date': instance.date,
      'slot': instance.slot,
      'dayTime': instance.dayTime,
      'status': instance.status,
      'remark': instance.remark,
    };

_AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) =>
    _AttendanceRecord(
      classNumber: json['classNumber'] as String,
      courseCode: json['courseCode'] as String,
      courseName: json['courseName'] as String,
      courseType: json['courseType'] as String,
      courseSlot: json['courseSlot'] as String,
      faculty: json['faculty'] as String,
      attendedClasses: json['attendedClasses'] as String,
      totalClasses: json['totalClasses'] as String,
      attendancePercentage: json['attendancePercentage'] as String,
      attendenceBetweenPercentage:
          json['attendenceBetweenPercentage'] as String,
      debarStatus: json['debarStatus'] as String,
      courseId: json['courseId'] as String,
    );

Map<String, dynamic> _$AttendanceRecordToJson(_AttendanceRecord instance) =>
    <String, dynamic>{
      'classNumber': instance.classNumber,
      'courseCode': instance.courseCode,
      'courseName': instance.courseName,
      'courseType': instance.courseType,
      'courseSlot': instance.courseSlot,
      'faculty': instance.faculty,
      'attendedClasses': instance.attendedClasses,
      'totalClasses': instance.totalClasses,
      'attendancePercentage': instance.attendancePercentage,
      'attendenceBetweenPercentage': instance.attendenceBetweenPercentage,
      'debarStatus': instance.debarStatus,
      'courseId': instance.courseId,
    };
