// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      applicationNumber: json['applicationNumber'] as String,
      studentName: json['studentName'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      bloodGroup: json['bloodGroup'] as String,
      email: json['email'] as String,
      base64Pfp: json['base64Pfp'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'applicationNumber': instance.applicationNumber,
      'studentName': instance.studentName,
      'dob': instance.dob,
      'gender': instance.gender,
      'bloodGroup': instance.bloodGroup,
      'email': instance.email,
      'base64Pfp': instance.base64Pfp,
    };
