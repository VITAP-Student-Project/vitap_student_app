import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'grade_view_course.g.dart';

List<GradeViewCourseModel> gradeViewCoursesFromJson(String str) =>
    List<GradeViewCourseModel>.from(
      (json.decode(str) as List).map(
        (x) => GradeViewCourseModel.fromJson(x as Map<String, dynamic>),
      ),
    );

String gradeViewCoursesToJson(List<GradeViewCourseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// One course row from the grade view for a semester.
@JsonSerializable()
class GradeViewCourseModel {
  @JsonKey(name: 'serial_number')
  final String serialNumber;
  @JsonKey(name: 'course_code')
  final String courseCode;
  @JsonKey(name: 'course_title')
  final String courseTitle;
  @JsonKey(name: 'course_type')
  final String courseType;
  @JsonKey(name: 'grading_type')
  final String gradingType;
  @JsonKey(name: 'grand_total')
  final String grandTotal;
  @JsonKey(name: 'grade')
  final String grade;

  /// Needed to request the per-course detail.
  @JsonKey(name: 'course_id')
  final String courseId;

  GradeViewCourseModel({
    required this.serialNumber,
    required this.courseCode,
    required this.courseTitle,
    required this.courseType,
    required this.gradingType,
    required this.grandTotal,
    required this.grade,
    required this.courseId,
  });

  factory GradeViewCourseModel.fromJson(Map<String, dynamic> json) =>
      _$GradeViewCourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GradeViewCourseModelToJson(this);
}
