// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentorDetails _$MentorDetailsFromJson(Map<String, dynamic> json) =>
    MentorDetails(
      id: (json['id'] as num?)?.toInt(),
      facultyId: json['faculty_id'] as String,
      facultyName: json['faculty_name'] as String,
      facultyDesignation: json['faculty_designation'] as String,
      school: json['school'] as String,
      cabin: json['cabin'] as String,
      facultyDepartment: json['faculty_department'] as String,
      facultyEmail: json['faculty_email'] as String,
      facultyIntercom: json['faculty_intercom'] as String,
      facultyMobileNumber: json['faculty_mobile_number'] as String,
    );

Map<String, dynamic> _$MentorDetailsToJson(MentorDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'faculty_id': instance.facultyId,
      'faculty_name': instance.facultyName,
      'faculty_designation': instance.facultyDesignation,
      'school': instance.school,
      'cabin': instance.cabin,
      'faculty_department': instance.facultyDepartment,
      'faculty_email': instance.facultyEmail,
      'faculty_intercom': instance.facultyIntercom,
      'faculty_mobile_number': instance.facultyMobileNumber,
    };
