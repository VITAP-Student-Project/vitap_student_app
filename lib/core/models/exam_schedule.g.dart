// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamSchedule _$ExamScheduleFromJson(Map<String, dynamic> json) => ExamSchedule(
      const _SubjectRelToManyConverter().fromJson(json['subjects'] as List?),
      examType: json['exam_type'] as String,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$ExamScheduleToJson(ExamSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exam_type': instance.examType,
      'subjects': const _SubjectRelToManyConverter().toJson(instance.subjects),
    };

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      serialNumber: json['serial_number'] as String,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_name'] as String,
      type: json['course_type'] as String,
      courseId: json['course_id'] as String,
      slot: json['slot'] as String,
      date: json['exam_date'] as String,
      session: json['exam_session'] as String,
      reportingTime: json['reporting_time'] as String,
      examTime: json['exam_time'] as String,
      venue: json['venue'] as String,
      seatLocation: json['seat_location'] as String,
      seatNumber: json['seat_number'] as String,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'serial_number': instance.serialNumber,
      'course_code': instance.courseCode,
      'course_name': instance.courseTitle,
      'course_type': instance.type,
      'course_id': instance.courseId,
      'slot': instance.slot,
      'exam_date': instance.date,
      'exam_session': instance.session,
      'reporting_time': instance.reportingTime,
      'exam_time': instance.examTime,
      'venue': instance.venue,
      'seat_location': instance.seatLocation,
      'seat_number': instance.seatNumber,
    };
