import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'courses_response.g.dart';

CoursesResponseModel coursesResponseFromJson(String str) =>
    CoursesResponseModel.fromJson(json.decode(str));

String coursesResponseToJson(CoursesResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CoursesResponseModel {
  @JsonKey(name: "courses")
  final List<CourseOptionModel> courses;

  CoursesResponseModel({
    required this.courses,
  });

  factory CoursesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CoursesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoursesResponseModelToJson(this);
}

@JsonSerializable()
class CourseOptionModel {
  @JsonKey(name: "value")
  final String value;
  @JsonKey(name: "label")
  final String label;
  @JsonKey(name: "course_code")
  final String courseCode;
  @JsonKey(name: "course_title")
  final String courseTitle;
  @JsonKey(name: "course_type")
  final String courseType;

  CourseOptionModel({
    required this.value,
    required this.label,
    required this.courseCode,
    required this.courseTitle,
    required this.courseType,
  });

  factory CourseOptionModel.fromJson(Map<String, dynamic> json) =>
      _$CourseOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseOptionModelToJson(this);
}
