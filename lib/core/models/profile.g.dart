// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      applicationNumber: json['application_number'] as String,
      studentName: json['student_name'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      bloodGroup: json['blood_group'] as String,
      email: json['email'] as String,
      base64Pfp: json['base64_pfp'] as String,
      gradeHistory: const _GradeHistoryRelToOneConverter()
          .fromJson(json['grade_history'] as Map<String, dynamic>?),
      mentorDetails: const _MentorDetailsRelToOneConverter()
          .fromJson(json['mentor_details'] as Map<String, dynamic>?),
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'application_number': instance.applicationNumber,
      'student_name': instance.studentName,
      'dob': instance.dob,
      'gender': instance.gender,
      'blood_group': instance.bloodGroup,
      'email': instance.email,
      'base64_pfp': instance.base64Pfp,
      'grade_history':
          const _GradeHistoryRelToOneConverter().toJson(instance.gradeHistory),
      'mentor_details': const _MentorDetailsRelToOneConverter()
          .toJson(instance.mentorDetails),
    };
