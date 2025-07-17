import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'exam_schedule.g.dart';

List<ExamSchedule> examScheduleFromJson(String str) => List<ExamSchedule>.from(
    json.decode(str).map((x) => ExamSchedule.fromJson(x)));

String examScheduleToJson(List<ExamSchedule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Entity()
@JsonSerializable()
class ExamSchedule {
  @Id()
  int? id;

  @JsonKey(name: 'exam_type')
  final String examType;

  @JsonKey(name: 'subjects')
  @_SubjectRelToManyConverter()
  final ToMany<Subject> subjects;

  ExamSchedule(this.subjects, {required this.examType});

  factory ExamSchedule.fromJson(Map<String, dynamic> json) =>
      _$ExamScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ExamScheduleToJson(this);
}

@Entity()
@JsonSerializable()
class Subject {
  @Id()
  int? id;

  @JsonKey(name: "serial_number")
  final String serialNumber;
  @JsonKey(name: "course_code")
  final String courseCode;
  @JsonKey(name: "course_title")
  final String courseTitle;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "course_id")
  final String courseId;
  @JsonKey(name: "slot")
  final String slot;
  @JsonKey(name: "exam_date")
  final String date;
  @JsonKey(name: "exam_session")
  final String session;
  @JsonKey(name: "reporting_time")
  final String reportingTime;
  @JsonKey(name: "exam_time")
  final String examTime;
  @JsonKey(name: "venue")
  final String venue;
  @JsonKey(name: "seat_location")
  final String seatLocation;
  @JsonKey(name: "seat_number")
  final String seatNumber;

  Subject({
    required this.serialNumber,
    required this.courseCode,
    required this.courseTitle,
    required this.type,
    required this.courseId,
    required this.slot,
    required this.date,
    required this.session,
    required this.reportingTime,
    required this.examTime,
    required this.venue,
    required this.seatLocation,
    required this.seatNumber,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

class _SubjectRelToManyConverter
    implements JsonConverter<ToMany<Subject>, List<dynamic>?> {
  const _SubjectRelToManyConverter();

  @override
  ToMany<Subject> fromJson(List<dynamic>? json) {
    final items = json
            ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return ToMany<Subject>(items: items);
  }

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Subject> rel) =>
      rel.map((e) => e.toJson()).toList();
}
