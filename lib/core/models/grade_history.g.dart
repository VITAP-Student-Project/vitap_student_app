// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeHistory _$GradeHistoryFromJson(Map<String, dynamic> json) => GradeHistory(
      creditsRegistered: json['creditsRegistered'] as String,
      creditsEarned: json['creditsEarned'] as String,
      cgpa: json['cgpa'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$GradeHistoryToJson(GradeHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creditsRegistered': instance.creditsRegistered,
      'creditsEarned': instance.creditsEarned,
      'cgpa': instance.cgpa,
    };
