// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentorDetails _$MentorDetailsFromJson(Map<String, dynamic> json) =>
    _MentorDetails(
      facultyId: json['facultyId'] as String,
      facultyName: json['facultyName'] as String,
      facultyDesignation: json['facultyDesignation'] as String,
      school: json['school'] as String,
      cabin: json['cabin'] as String,
      facultyDepartment: json['facultyDepartment'] as String,
      facultyEmail: json['facultyEmail'] as String,
      facultyIntercom: json['facultyIntercom'] as String,
      facultyMobileNumber: json['facultyMobileNumber'] as String,
    );

Map<String, dynamic> _$MentorDetailsToJson(_MentorDetails instance) =>
    <String, dynamic>{
      'facultyId': instance.facultyId,
      'facultyName': instance.facultyName,
      'facultyDesignation': instance.facultyDesignation,
      'school': instance.school,
      'cabin': instance.cabin,
      'facultyDepartment': instance.facultyDepartment,
      'facultyEmail': instance.facultyEmail,
      'facultyIntercom': instance.facultyIntercom,
      'facultyMobileNumber': instance.facultyMobileNumber,
    };
