// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamSchedule _$ExamScheduleFromJson(Map<String, dynamic> json) => ExamSchedule(
      examType: json['examType'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$ExamScheduleToJson(ExamSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'examType': instance.examType,
    };

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      serialNumber: json['serialNumber'] as String,
      courseCode: json['courseCode'] as String,
      courseTitle: json['courseTitle'] as String,
      type: json['type'] as String,
      registrationNumber: json['registrationNumber'] as String,
      slot: json['slot'] as String,
      date: json['date'] as String,
      session: json['session'] as String,
      reportingTime: json['reportingTime'] as String,
      examTime: json['examTime'] as String,
      venue: json['venue'] as String,
      seatLocation: json['seatLocation'] as String,
      seatNumber: json['seatNumber'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'serialNumber': instance.serialNumber,
      'courseCode': instance.courseCode,
      'courseTitle': instance.courseTitle,
      'type': instance.type,
      'registrationNumber': instance.registrationNumber,
      'slot': instance.slot,
      'date': instance.date,
      'session': instance.session,
      'reportingTime': instance.reportingTime,
      'examTime': instance.examTime,
      'venue': instance.venue,
      'seatLocation': instance.seatLocation,
      'seatNumber': instance.seatNumber,
    };
