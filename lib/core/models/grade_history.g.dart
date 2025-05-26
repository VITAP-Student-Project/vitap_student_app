// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeHistory _$GradeHistoryFromJson(Map<String, dynamic> json) => GradeHistory(
      creditsRegistered: json['credits_registered'] as String,
      creditsEarned: json['credits_earned'] as String,
      cgpa: json['cgpa'] as String,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$GradeHistoryToJson(GradeHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'credits_registered': instance.creditsRegistered,
      'credits_earned': instance.creditsEarned,
      'cgpa': instance.cgpa,
    };
