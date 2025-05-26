// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      registrationNumber: json['registrationNumber'] as String,
      password: json['password'] as String,
      semSubId: json['semSubId'] as String,
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'registrationNumber': instance.registrationNumber,
      'password': instance.password,
      'semSubId': instance.semSubId,
    };
