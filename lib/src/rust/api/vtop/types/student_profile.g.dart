// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentProfile _$StudentProfileFromJson(Map<String, dynamic> json) =>
    _StudentProfile(
      applicationNumber: json['applicationNumber'] as String,
      studentName: json['studentName'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      bloodGroup: json['bloodGroup'] as String,
      email: json['email'] as String,
      base64Pfp: json['base64Pfp'] as String,
      gradeHistory:
          GradeHistory.fromJson(json['gradeHistory'] as Map<String, dynamic>),
      mentorDetails:
          MentorDetails.fromJson(json['mentorDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentProfileToJson(_StudentProfile instance) =>
    <String, dynamic>{
      'applicationNumber': instance.applicationNumber,
      'studentName': instance.studentName,
      'dob': instance.dob,
      'gender': instance.gender,
      'bloodGroup': instance.bloodGroup,
      'email': instance.email,
      'base64Pfp': instance.base64Pfp,
      'gradeHistory': instance.gradeHistory,
      'mentorDetails': instance.mentorDetails,
    };
