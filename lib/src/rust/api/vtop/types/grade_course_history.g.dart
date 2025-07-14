// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_course_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GradeCourseHistory _$GradeCourseHistoryFromJson(Map<String, dynamic> json) =>
    _GradeCourseHistory(
      courseCode: json['courseCode'] as String,
      courseTitle: json['courseTitle'] as String,
      courseType: json['courseType'] as String,
      credits: json['credits'] as String,
      grade: json['grade'] as String,
      examMonth: json['examMonth'] as String,
      courseDistribution: json['courseDistribution'] as String,
    );

Map<String, dynamic> _$GradeCourseHistoryToJson(_GradeCourseHistory instance) =>
    <String, dynamic>{
      'courseCode': instance.courseCode,
      'courseTitle': instance.courseTitle,
      'courseType': instance.courseType,
      'credits': instance.credits,
      'grade': instance.grade,
      'examMonth': instance.examMonth,
      'courseDistribution': instance.courseDistribution,
    };
