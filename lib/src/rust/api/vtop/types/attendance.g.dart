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
      serial: json['serial'] as String,
      category: json['category'] as String,
      courseName: json['courseName'] as String,
      courseCode: json['courseCode'] as String,
      courseType: json['courseType'] as String,
      facultyDetail: json['facultyDetail'] as String,
      classesAttended: json['classesAttended'] as String,
      totalClasses: json['totalClasses'] as String,
      attendancePercentage: json['attendancePercentage'] as String,
      attendanceFatCat: json['attendanceFatCat'] as String,
      debarStatus: json['debarStatus'] as String,
      courseId: json['courseId'] as String,
    );

Map<String, dynamic> _$AttendanceRecordToJson(_AttendanceRecord instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'category': instance.category,
      'courseName': instance.courseName,
      'courseCode': instance.courseCode,
      'courseType': instance.courseType,
      'facultyDetail': instance.facultyDetail,
      'classesAttended': instance.classesAttended,
      'totalClasses': instance.totalClasses,
      'attendancePercentage': instance.attendancePercentage,
      'attendanceFatCat': instance.attendanceFatCat,
      'debarStatus': instance.debarStatus,
      'courseId': instance.courseId,
    };
