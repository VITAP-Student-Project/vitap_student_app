// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesResponseModel _$CoursesResponseModelFromJson(
        Map<String, dynamic> json) =>
    CoursesResponseModel(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursesResponseModelToJson(
        CoursesResponseModel instance) =>
    <String, dynamic>{
      'courses': instance.courses,
    };

CourseOptionModel _$CourseOptionModelFromJson(Map<String, dynamic> json) =>
    CourseOptionModel(
      value: json['value'] as String,
      label: json['label'] as String,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      courseType: json['course_type'] as String,
    );

Map<String, dynamic> _$CourseOptionModelToJson(CourseOptionModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'course_code': instance.courseCode,
      'course_title': instance.courseTitle,
      'course_type': instance.courseType,
    };
