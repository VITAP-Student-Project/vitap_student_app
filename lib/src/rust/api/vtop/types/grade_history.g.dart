// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GradeHistory _$GradeHistoryFromJson(Map<String, dynamic> json) =>
    _GradeHistory(
      creditsRegistered: json['creditsRegistered'] as String,
      creditsEarned: json['creditsEarned'] as String,
      cgpa: json['cgpa'] as String,
    );

Map<String, dynamic> _$GradeHistoryToJson(_GradeHistory instance) =>
    <String, dynamic>{
      'creditsRegistered': instance.creditsRegistered,
      'creditsEarned': instance.creditsEarned,
      'cgpa': instance.cgpa,
    };
