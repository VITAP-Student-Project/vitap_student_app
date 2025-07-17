// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Biometric _$BiometricFromJson(Map<String, dynamic> json) => Biometric(
      time: json['in_time'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$BiometricToJson(Biometric instance) => <String, dynamic>{
      'in_time': instance.time,
      'location': instance.location,
    };
