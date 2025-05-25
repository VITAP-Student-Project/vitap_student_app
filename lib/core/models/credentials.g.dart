// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      registrationNumber: json['registration_number'] as String,
      password: json['password'] as String,
      semSubId: json['semSubId'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registration_number': instance.registrationNumber,
      'password': instance.password,
      'semSubId': instance.semSubId,
    };
