// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeHistory _$GradeHistoryFromJson(Map<String, dynamic> json) => GradeHistory(
      creditsRegistered: json['credits_registered'] as String,
      creditsEarned: json['credits_earned'] as String,
      cgpa: json['cgpa'] as String,
      courses:
          const _CourseRelToManyConverter().fromJson(json['courses'] as List?),
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$GradeHistoryToJson(GradeHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'credits_registered': instance.creditsRegistered,
      'credits_earned': instance.creditsEarned,
      'cgpa': instance.cgpa,
      'courses': const _CourseRelToManyConverter().toJson(instance.courses),
    };

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      courseType: json['course_type'] as String,
      credits: json['credits'] as String,
      grade: json['grade'] as String,
      examMonth: json['exam_month'] as String,
      courseDistribution: json['course_distribution'] as String,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'course_code': instance.courseCode,
      'course_title': instance.courseTitle,
      'course_type': instance.courseType,
      'credits': instance.credits,
      'grade': instance.grade,
      'exam_month': instance.examMonth,
      'course_distribution': instance.courseDistribution,
    };
