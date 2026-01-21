import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'slots_response.g.dart';

SlotsResponseModel slotsResponseFromJson(String str) =>
    SlotsResponseModel.fromJson(json.decode(str));

String slotsResponseToJson(SlotsResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SlotsResponseModel {
  @JsonKey(name: "slots")
  final List<SlotOptionModel> slots;
  @JsonKey(name: "class_entries")
  final List<CourseClassEntryModel> classEntries;

  SlotsResponseModel({
    required this.slots,
    required this.classEntries,
  });

  factory SlotsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SlotsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SlotsResponseModelToJson(this);
}

@JsonSerializable()
class SlotOptionModel {
  @JsonKey(name: "value")
  final String value;
  @JsonKey(name: "label")
  final String label;

  SlotOptionModel({
    required this.value,
    required this.label,
  });

  factory SlotOptionModel.fromJson(Map<String, dynamic> json) =>
      _$SlotOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SlotOptionModelToJson(this);
}

@JsonSerializable()
class CourseClassEntryModel {
  @JsonKey(name: "sl_no")
  final int slNo;
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
  @JsonKey(name: "semester_id")
  final String semesterId;
  @JsonKey(name: "erp_id")
  final String erpId;

  CourseClassEntryModel({
    required this.slNo,
    required this.classGroup,
    required this.courseCode,
    required this.courseTitle,
    required this.courseType,
    required this.classId,
    required this.slot,
    required this.faculty,
    required this.semesterId,
    required this.erpId,
  });

  factory CourseClassEntryModel.fromJson(Map<String, dynamic> json) =>
      _$CourseClassEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseClassEntryModelToJson(this);
}
