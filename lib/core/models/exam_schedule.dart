import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'exam_schedule.g.dart';

@Entity()
@JsonSerializable()
class ExamSchedule {
  @Id()
  int id = 0;

  final String examType;

  @_SubjectRelToManyConverter()
  final ToMany<Subject> subjects = ToMany<Subject>();

  ExamSchedule({required this.examType});

  factory ExamSchedule.fromJson(Map<String, dynamic> json) =>
      _$ExamScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ExamScheduleToJson(this);
}

@Entity()
@JsonSerializable()
class Subject {
  @Id()
  int id = 0;

  final String serialNumber;
  final String courseCode;
  final String courseTitle;
  final String type;
  final String registrationNumber;
  final String slot;
  final String date;
  final String session;
  final String reportingTime;
  final String examTime;
  final String venue;
  final String seatLocation;
  final String seatNumber;

  Subject({
    required this.serialNumber,
    required this.courseCode,
    required this.courseTitle,
    required this.type,
    required this.registrationNumber,
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
    implements JsonConverter<ToMany<Subject>, List<Map<String, dynamic>>?> {
  const _SubjectRelToManyConverter();

  @override
  ToMany<Subject> fromJson(List<Map<String, dynamic>>? json) => ToMany<Subject>(
      items: json?.map((e) => Subject.fromJson(e)).toList() ?? []);

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Subject> rel) =>
      rel.map((e) => e.toJson()).toList();
}
