// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiometricRecord _$BiometricRecordFromJson(Map<String, dynamic> json) =>
    _BiometricRecord(
      serial: json['serial'] as String,
      date: json['date'] as String,
      day: json['day'] as String,
      inTime: json['inTime'] as String,
      outTime: json['outTime'] as String,
      duration: json['duration'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$BiometricRecordToJson(_BiometricRecord instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'date': instance.date,
      'day': instance.day,
      'inTime': instance.inTime,
      'outTime': instance.outTime,
      'duration': instance.duration,
      'location': instance.location,
    };
