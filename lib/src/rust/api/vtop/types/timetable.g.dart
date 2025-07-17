// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Timetable _$TimetableFromJson(Map<String, dynamic> json) => _Timetable(
      monday: (json['monday'] as List<dynamic>)
          .map((e) => TimetableClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      tuesday: (json['tuesday'] as List<dynamic>)
          .map((e) => TimetableClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      wednesday: (json['wednesday'] as List<dynamic>)
          .map((e) => TimetableClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      thursday: (json['thursday'] as List<dynamic>)
          .map((e) => TimetableClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      friday: (json['friday'] as List<dynamic>)
          .map((e) => TimetableClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      saturday: (json['saturday'] as List<dynamic>)
          .map((e) => TimetableClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      sunday: (json['sunday'] as List<dynamic>)
          .map((e) => TimetableClass.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimetableToJson(_Timetable instance) =>
    <String, dynamic>{
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
    };

_TimetableClass _$TimetableClassFromJson(Map<String, dynamic> json) =>
    _TimetableClass(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      courseName: json['courseName'] as String,
      slot: json['slot'] as String,
      venue: json['venue'] as String,
      faculty: json['faculty'] as String,
      courseCode: json['courseCode'] as String,
      courseType: json['courseType'] as String,
    );

Map<String, dynamic> _$TimetableClassToJson(_TimetableClass instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'courseName': instance.courseName,
      'slot': instance.slot,
      'venue': instance.venue,
      'faculty': instance.faculty,
      'courseCode': instance.courseCode,
      'courseType': instance.courseType,
    };
