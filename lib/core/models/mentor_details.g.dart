// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentorDetails _$MentorDetailsFromJson(Map<String, dynamic> json) =>
    MentorDetails(
      facultyId: json['facultyId'] as String,
      facultyName: json['facultyName'] as String,
      facultyDesignation: json['facultyDesignation'] as String,
      school: json['school'] as String,
      cabin: json['cabin'] as String,
      facultyDepartment: json['facultyDepartment'] as String,
      facultyEmail: json['facultyEmail'] as String,
      facultyIntercom: json['facultyIntercom'] as String,
      facultyMobileNumber: json['facultyMobileNumber'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$MentorDetailsToJson(MentorDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
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
