// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timetable _$TimetableFromJson(Map<String, dynamic> json) => Timetable(
      monday: const _DayRelToManyConverter().fromJson(json['Monday'] as List?),
      tuesday:
          const _DayRelToManyConverter().fromJson(json['Tuesday'] as List?),
      wednesday:
          const _DayRelToManyConverter().fromJson(json['Wednesday'] as List?),
      thursday:
          const _DayRelToManyConverter().fromJson(json['Thursday'] as List?),
      friday: const _DayRelToManyConverter().fromJson(json['Friday'] as List?),
      saturday:
          const _DayRelToManyConverter().fromJson(json['Saturday'] as List?),
      sunday: const _DayRelToManyConverter().fromJson(json['Sunday'] as List?),
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$TimetableToJson(Timetable instance) => <String, dynamic>{
      'id': instance.id,
      'Monday': const _DayRelToManyConverter().toJson(instance.monday),
      'Tuesday': const _DayRelToManyConverter().toJson(instance.tuesday),
      'Wednesday': const _DayRelToManyConverter().toJson(instance.wednesday),
      'Thursday': const _DayRelToManyConverter().toJson(instance.thursday),
      'Friday': const _DayRelToManyConverter().toJson(instance.friday),
      'Saturday': const _DayRelToManyConverter().toJson(instance.saturday),
      'Sunday': const _DayRelToManyConverter().toJson(instance.sunday),
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      courseName: json['course_name'] as String?,
      slot: json['slot'] as String?,
      venue: json['venue'] as String?,
      faculty: json['faculty'] as String?,
      courseCode: json['course_code'] as String?,
      courseType: json['course_type'] as String?,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'id': instance.id,
      'course_name': instance.courseName,
      'slot': instance.slot,
      'venue': instance.venue,
      'faculty': instance.faculty,
      'course_code': instance.courseCode,
      'course_type': instance.courseType,
    };
