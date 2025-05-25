// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timetable _$TimetableFromJson(Map<String, dynamic> json) =>
    Timetable()..id = (json['id'] as num).toInt();

Map<String, dynamic> _$TimetableToJson(Timetable instance) => <String, dynamic>{
      'id': instance.id,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      courseName: json['courseName'] as String,
      slot: json['slot'] as String,
      venue: json['venue'] as String,
      faculty: json['faculty'] as String,
      courseCode: json['courseCode'] as String,
      courseType: json['courseType'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'id': instance.id,
      'courseName': instance.courseName,
      'slot': instance.slot,
      'venue': instance.venue,
      'faculty': instance.faculty,
      'courseCode': instance.courseCode,
      'courseType': instance.courseType,
    };
