// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'mark.g.dart';

List<Mark> markFromJson(String str) =>
    List<Mark>.from(json.decode(str).map((x) => Mark.fromJson(x)));

String markToJson(List<Mark> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Entity()
@JsonSerializable()
class Mark {
  @Id()
  int? id;

  @JsonKey(name: "serial_number")
  final String serialNumber;

  @JsonKey(name: "course_code")
  final String courseCode;

  @JsonKey(name: "course_title")
  final String courseTitle;

  @JsonKey(name: "course_type")
  final String courseType;

  @JsonKey(name: "faculty")
  final String faculty;

  @JsonKey(name: "slot")
  final String slot;

  @JsonKey(name: "details")
  @_DetailRelToManyConverter()
  final ToMany<Detail> details;

  Mark({
    this.id,
    required this.serialNumber,
    required this.courseCode,
    required this.courseTitle,
    required this.courseType,
    required this.faculty,
    required this.slot,
    required this.details,
  });

  factory Mark.fromJson(Map<String, dynamic> json) => _$MarkFromJson(json);
  Map<String, dynamic> toJson() => _$MarkToJson(this);

  @override
  String toString() {
    return 'Mark(id: $id, serialNumber: $serialNumber, courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, faculty: $faculty, slot: $slot, details: ${details.toString()})';
  }
}

@Entity()
@JsonSerializable()
class Detail {
  @Id()
  int? id;

  @JsonKey(name: "serial_number")
  final String serialNumber;

  @JsonKey(name: "mark_title")
  final String markTitle;

  @JsonKey(name: "max_mark")
  final String maxMark;

  @JsonKey(name: "weightage")
  final String weightage;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "scored_mark")
  final String scoredMark;

  @JsonKey(name: "weightage_mark")
  final String weightageMark;

  @JsonKey(name: "remark")
  final String remark;

  Detail({
    this.id,
    required this.serialNumber,
    required this.markTitle,
    required this.maxMark,
    required this.weightage,
    required this.status,
    required this.scoredMark,
    required this.weightageMark,
    required this.remark,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
  Map<String, dynamic> toJson() => _$DetailToJson(this);

  @override
  String toString() {
    return 'Detail(id: $id, serialNumber: $serialNumber, markTitle: $markTitle, maxMark: $maxMark, weightage: $weightage, status: $status, scoredMark: $scoredMark, weightageMark: $weightageMark, remark: $remark)';
  }
}

class _DetailRelToManyConverter
    implements JsonConverter<ToMany<Detail>, List<dynamic>?> {
  const _DetailRelToManyConverter();

  @override
  ToMany<Detail> fromJson(List<dynamic>? json) {
    final items =
        json?.map((e) => Detail.fromJson(e as Map<String, dynamic>)).toList() ??
            [];
    return ToMany<Detail>(items: items);
  }

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Detail> rel) =>
      rel.map((e) => e.toJson()).toList();
}
