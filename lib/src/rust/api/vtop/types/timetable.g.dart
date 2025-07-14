// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimetableSlot _$TimetableSlotFromJson(Map<String, dynamic> json) =>
    _TimetableSlot(
      serial: json['serial'] as String,
      day: json['day'] as String,
      slot: json['slot'] as String,
      courseCode: json['courseCode'] as String,
      courseType: json['courseType'] as String,
      roomNo: json['roomNo'] as String,
      block: json['block'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TimetableSlotToJson(_TimetableSlot instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'day': instance.day,
      'slot': instance.slot,
      'courseCode': instance.courseCode,
      'courseType': instance.courseType,
      'roomNo': instance.roomNo,
      'block': instance.block,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'name': instance.name,
    };
