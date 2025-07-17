// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExamScheduleRecord _$ExamScheduleRecordFromJson(Map<String, dynamic> json) =>
    _ExamScheduleRecord(
      serialNumber: json['serialNumber'] as String,
      slot: json['slot'] as String,
      courseName: json['courseName'] as String,
      courseCode: json['courseCode'] as String,
      courseType: json['courseType'] as String,
      courseId: json['courseId'] as String,
      examDate: json['examDate'] as String,
      examSession: json['examSession'] as String,
      reportingTime: json['reportingTime'] as String,
      examTime: json['examTime'] as String,
      venue: json['venue'] as String,
      seatLocation: json['seatLocation'] as String,
      seatNumber: json['seatNumber'] as String,
    );

Map<String, dynamic> _$ExamScheduleRecordToJson(_ExamScheduleRecord instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'slot': instance.slot,
      'courseName': instance.courseName,
      'courseCode': instance.courseCode,
      'courseType': instance.courseType,
      'courseId': instance.courseId,
      'examDate': instance.examDate,
      'examSession': instance.examSession,
      'reportingTime': instance.reportingTime,
      'examTime': instance.examTime,
      'venue': instance.venue,
      'seatLocation': instance.seatLocation,
      'seatNumber': instance.seatNumber,
    };

_PerExamScheduleRecord _$PerExamScheduleRecordFromJson(
        Map<String, dynamic> json) =>
    _PerExamScheduleRecord(
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => ExamScheduleRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      examType: json['examType'] as String,
    );

Map<String, dynamic> _$PerExamScheduleRecordToJson(
        _PerExamScheduleRecord instance) =>
    <String, dynamic>{
      'subjects': instance.subjects,
      'examType': instance.examType,
    };
