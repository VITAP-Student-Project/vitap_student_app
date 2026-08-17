// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_view_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeViewCourseModel _$GradeViewCourseModelFromJson(
  Map<String, dynamic> json,
) => GradeViewCourseModel(
  serialNumber: json['serial_number'] as String,
  courseCode: json['course_code'] as String,
  courseTitle: json['course_title'] as String,
  courseType: json['course_type'] as String,
  gradingType: json['grading_type'] as String,
  grandTotal: json['grand_total'] as String,
  grade: json['grade'] as String,
  courseId: json['course_id'] as String,
);

Map<String, dynamic> _$GradeViewCourseModelToJson(
  GradeViewCourseModel instance,
) => <String, dynamic>{
  'serial_number': instance.serialNumber,
  'course_code': instance.courseCode,
  'course_title': instance.courseTitle,
  'course_type': instance.courseType,
  'grading_type': instance.gradingType,
  'grand_total': instance.grandTotal,
  'grade': instance.grade,
  'course_id': instance.courseId,
};
