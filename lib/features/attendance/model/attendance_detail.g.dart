// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceDetail _$AttendanceDetailFromJson(Map<String, dynamic> json) =>
    AttendanceDetail(
      serial: json['serial'] as String,
      date: json['date'] as String,
      slot: json['slot'] as String,
      dayTime: json['day_time'] as String,
      status: json['status'] as String,
      remark: json['remark'] as String,
    );

Map<String, dynamic> _$AttendanceDetailToJson(AttendanceDetail instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'date': instance.date,
      'slot': instance.slot,
      'day_time': instance.dayTime,
      'status': instance.status,
      'remark': instance.remark,
    };
