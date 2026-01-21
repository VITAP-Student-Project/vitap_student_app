import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'course_page_detail.g.dart';

CoursePageDetailModel coursePageDetailFromJson(String str) =>
    CoursePageDetailModel.fromJson(json.decode(str));

String coursePageDetailToJson(CoursePageDetailModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CoursePageDetailModel {
  @JsonKey(name: "course_info")
  final CourseInfoModel courseInfo;
  @JsonKey(name: "semester_id")
  final String semesterId;
  @JsonKey(name: "download_all_path")
  final String? downloadAllPath;
  @JsonKey(name: "download_general_materials_path")
  final String? downloadGeneralMaterialsPath;
  @JsonKey(name: "syllabus_download_path")
  final String? syllabusDownloadPath;
  @JsonKey(name: "course_plan_download_path")
  final String? coursePlanDownloadPath;
  @JsonKey(name: "lectures")
  final List<LectureEntryModel> lectures;

  CoursePageDetailModel({
    required this.courseInfo,
    required this.semesterId,
    this.downloadAllPath,
    this.downloadGeneralMaterialsPath,
    this.syllabusDownloadPath,
    this.coursePlanDownloadPath,
    required this.lectures,
  });

  factory CoursePageDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CoursePageDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePageDetailModelToJson(this);
}

@JsonSerializable()
class CourseInfoModel {
  @JsonKey(name: "class_group")
  final String classGroup;
  @JsonKey(name: "course_code")
  final String courseCode;
  @JsonKey(name: "course_title")
  final String courseTitle;
  @JsonKey(name: "course_type")
  final String courseType;
  @JsonKey(name: "class_id")
  final String classId;
  @JsonKey(name: "slot")
  final String slot;
  @JsonKey(name: "faculty")
  final String faculty;
  @JsonKey(name: "course_id")
  final String courseId;

  CourseInfoModel({
    required this.classGroup,
    required this.courseCode,
    required this.courseTitle,
    required this.courseType,
    required this.classId,
    required this.slot,
    required this.faculty,
    required this.courseId,
  });

  factory CourseInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CourseInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInfoModelToJson(this);
}

@JsonSerializable()
class LectureEntryModel {
  @JsonKey(name: "sl_no")
  final int slNo;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "formatted_date")
  final String formattedDate;
  @JsonKey(name: "day")
  final String day;
  @JsonKey(name: "topic")
  final String topic;
  @JsonKey(name: "reference_materials")
  final List<ReferenceMaterialModel> referenceMaterials;

  LectureEntryModel({
    required this.slNo,
    required this.date,
    required this.formattedDate,
    required this.day,
    required this.topic,
    required this.referenceMaterials,
  });

  factory LectureEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LectureEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LectureEntryModelToJson(this);

  bool get hasMaterials => referenceMaterials.isNotEmpty;
}

@JsonSerializable()
class ReferenceMaterialModel {
  @JsonKey(name: "label")
  final String label;
  @JsonKey(name: "download_path")
  final String downloadPath;

  ReferenceMaterialModel({
    required this.label,
    required this.downloadPath,
  });

  factory ReferenceMaterialModel.fromJson(Map<String, dynamic> json) =>
      _$ReferenceMaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceMaterialModelToJson(this);
}
