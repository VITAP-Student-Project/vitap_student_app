import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'exam_schedule.g.dart';

@Entity()
@JsonSerializable()
class ExamSchedule {
  @Id()
  int? id;

  @JsonKey(name: 'exam_type')
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
  int? id;

  @JsonKey(name: "serial_number")
  final String serialNumber;
  @JsonKey(name: "course_code")
  final String courseCode;
  @JsonKey(name: "course_title")
  final String courseTitle;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "registration_number")
  final String registrationNumber;
  @JsonKey(name: "slot")
  final String slot;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "session")
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
