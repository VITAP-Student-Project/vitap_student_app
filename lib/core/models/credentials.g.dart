// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      registrationNumber: json['registrationNumber'] as String,
      password: json['password'] as String,
      semSubId: json['semSubId'] as String,
      hostelWifiUsername: json['hostelWifiUsername'] as String?,
      hostelWifiPassword: json['hostelWifiPassword'] as String?,
      universityWifiUsername: json['universityWifiUsername'] as String?,
      universityWifiPassword: json['universityWifiPassword'] as String?,
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'registrationNumber': instance.registrationNumber,
      'password': instance.password,
      'semSubId': instance.semSubId,
      'hostelWifiUsername': instance.hostelWifiUsername,
      'hostelWifiPassword': instance.hostelWifiPassword,
      'universityWifiUsername': instance.universityWifiUsername,
      'universityWifiPassword': instance.universityWifiPassword,
    };
