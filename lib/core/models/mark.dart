import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'mark.g.dart';

@Entity()
@JsonSerializable()
class Mark {
  @Id()
  int id = 0;

  final String serialNumber;
  final String classId;
  final String courseCode;
  final String courseTitle;
  final String courseType;
  final String courseSystem;
  final String faculty;
  final String slot;

  @_DetailRelToManyConverter()
  final ToMany<Detail> details = ToMany<Detail>();

  Mark({
    required this.serialNumber,
    required this.classId,
    required this.courseCode,
    required this.courseTitle,
    required this.courseType,
    required this.courseSystem,
    required this.faculty,
    required this.slot,
  });

  factory Mark.fromJson(Map<String, dynamic> json) => _$MarkFromJson(json);
  Map<String, dynamic> toJson() => _$MarkToJson(this);
}

@Entity()
@JsonSerializable()
class Detail {
  @Id()
  int id = 0;

  final String serialNumber;
  final String markTitle;
  final String maxMark;
  final String weightage;
  final String status;
  final String scoredMark;
  final String weightageMark;
  final String remark;

  Detail({
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
}

class _DetailRelToManyConverter
    implements JsonConverter<ToMany<Detail>, List<Map<String, dynamic>>?> {
  const _DetailRelToManyConverter();

  @override
  ToMany<Detail> fromJson(List<Map<String, dynamic>>? json) => ToMany<Detail>(
      items: json?.map((e) => Detail.fromJson(e)).toList() ?? []);

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Detail> rel) =>
      rel.map((e) => e.toJson()).toList();
}
