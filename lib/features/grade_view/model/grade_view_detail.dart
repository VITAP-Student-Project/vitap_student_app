import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'grade_view_detail.g.dart';

GradeViewDetailModel gradeViewDetailFromJson(String str) =>
    GradeViewDetailModel.fromJson(json.decode(str) as Map<String, dynamic>);

String gradeViewDetailToJson(GradeViewDetailModel data) =>
    json.encode(data.toJson());

/// The expanded detail for a single course: its mark breakdown, total, and the
/// class statistics.
@JsonSerializable()
class GradeViewDetailModel {
  @JsonKey(name: 'class_number')
  final String classNumber;
  @JsonKey(name: 'course_type')
  final String courseType;
  @JsonKey(name: 'marks')
  final List<MarkComponentModel> marks;
  @JsonKey(name: 'total')
  final String total;
  @JsonKey(name: 'statistics')
  final GradeStatisticsModel statistics;

  GradeViewDetailModel({
    required this.classNumber,
    required this.courseType,
    required this.marks,
    required this.total,
    required this.statistics,
  });

  factory GradeViewDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GradeViewDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$GradeViewDetailModelToJson(this);
}

/// One assessment component of a course (CAT1, FAT, a quiz, ...).
@JsonSerializable()
class MarkComponentModel {
  @JsonKey(name: 'serial_number')
  final String serialNumber;
  @JsonKey(name: 'mark_title')
  final String markTitle;
  @JsonKey(name: 'max_mark')
  final String maxMark;
  @JsonKey(name: 'weightage')
  final String weightage;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'scored_mark')
  final String scoredMark;
  @JsonKey(name: 'weightage_mark')
  final String weightageMark;

  MarkComponentModel({
    required this.serialNumber,
    required this.markTitle,
    required this.maxMark,
    required this.weightage,
    required this.status,
    required this.scoredMark,
    required this.weightageMark,
  });

  factory MarkComponentModel.fromJson(Map<String, dynamic> json) =>
      _$MarkComponentModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarkComponentModelToJson(this);
}

/// Class-level statistics shown alongside a course's grade.
@JsonSerializable()
class GradeStatisticsModel {
  @JsonKey(name: 'class_strength')
  final String classStrength;
  @JsonKey(name: 'grading_strength')
  final String gradingStrength;
  @JsonKey(name: 'mean')
  final String mean;
  @JsonKey(name: 'sd')
  final String sd;
  @JsonKey(name: 'grade_ranges')
  final List<GradeRangeModel> gradeRanges;

  GradeStatisticsModel({
    required this.classStrength,
    required this.gradingStrength,
    required this.mean,
    required this.sd,
    required this.gradeRanges,
  });

  factory GradeStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$GradeStatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GradeStatisticsModelToJson(this);
}

/// The mark range that maps to one letter grade for the class.
@JsonSerializable()
class GradeRangeModel {
  @JsonKey(name: 'grade')
  final String grade;
  @JsonKey(name: 'range')
  final String range;

  GradeRangeModel({required this.grade, required this.range});

  factory GradeRangeModel.fromJson(Map<String, dynamic> json) =>
      _$GradeRangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GradeRangeModelToJson(this);
}
