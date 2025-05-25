import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'attendance.dart';
import 'timetable.dart';
import 'exam_schedule.dart';
import 'grade_history.dart';
import 'mark.dart';
import 'profile.dart';

part 'user.g.dart';

@Entity()
@JsonSerializable()
class User {
  @Id()
  int id = 0;

  @_ProfileRelToOneConverter()
  final ToOne<Profile> profile = ToOne<Profile>();

  @_AttendanceRelToManyConverter()
  final ToMany<Attendance> attendance = ToMany<Attendance>();

  @_TimetableRelToOneConverter()
  final ToOne<Timetable> timetable = ToOne<Timetable>();

  @_ExamScheduleRelToManyConverter()
  final ToMany<ExamSchedule> examSchedule = ToMany<ExamSchedule>();

  @_GradeHistoryRelToOneConverter()
  final ToOne<GradeHistory> gradeHistory = ToOne<GradeHistory>();

  @_MarkRelToManyConverter()
  final ToMany<Mark> marks = ToMany<Mark>();

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// Converters for User relations
class _ProfileRelToOneConverter
    implements JsonConverter<ToOne<Profile>, Map<String, dynamic>?> {
  const _ProfileRelToOneConverter();

  @override
  ToOne<Profile> fromJson(Map<String, dynamic>? json) =>
      ToOne<Profile>(target: json != null ? Profile.fromJson(json) : null);

  @override
  Map<String, dynamic>? toJson(ToOne<Profile> rel) => rel.target?.toJson();
}

class _AttendanceRelToManyConverter
    implements JsonConverter<ToMany<Attendance>, List<Map<String, dynamic>>?> {
  const _AttendanceRelToManyConverter();

  @override
  ToMany<Attendance> fromJson(List<Map<String, dynamic>>? json) =>
      ToMany<Attendance>(
          items: json?.map((e) => Attendance.fromJson(e)).toList() ?? []);

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Attendance> rel) =>
      rel.map((e) => e.toJson()).toList();
}

class _TimetableRelToOneConverter
    implements JsonConverter<ToOne<Timetable>, Map<String, dynamic>?> {
  const _TimetableRelToOneConverter();

  @override
  ToOne<Timetable> fromJson(Map<String, dynamic>? json) =>
      ToOne<Timetable>(target: json != null ? Timetable.fromJson(json) : null);

  @override
  Map<String, dynamic>? toJson(ToOne<Timetable> rel) => rel.target?.toJson();
}

class _ExamScheduleRelToManyConverter
    implements
        JsonConverter<ToMany<ExamSchedule>, List<Map<String, dynamic>>?> {
  const _ExamScheduleRelToManyConverter();

  @override
  ToMany<ExamSchedule> fromJson(List<Map<String, dynamic>>? json) =>
      ToMany<ExamSchedule>(
          items: json?.map((e) => ExamSchedule.fromJson(e)).toList() ?? []);

  @override
  List<Map<String, dynamic>>? toJson(ToMany<ExamSchedule> rel) =>
      rel.map((e) => e.toJson()).toList();
}

class _GradeHistoryRelToOneConverter
    implements JsonConverter<ToOne<GradeHistory>, Map<String, dynamic>?> {
  const _GradeHistoryRelToOneConverter();

  @override
  ToOne<GradeHistory> fromJson(Map<String, dynamic>? json) =>
      ToOne<GradeHistory>(
          target: json != null ? GradeHistory.fromJson(json) : null);

  @override
  Map<String, dynamic>? toJson(ToOne<GradeHistory> rel) => rel.target?.toJson();
}

class _MarkRelToManyConverter
    implements JsonConverter<ToMany<Mark>, List<Map<String, dynamic>>?> {
  const _MarkRelToManyConverter();

  @override
  ToMany<Mark> fromJson(List<Map<String, dynamic>>? json) =>
      ToMany<Mark>(items: json?.map((e) => Mark.fromJson(e)).toList() ?? []);

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Mark> rel) =>
      rel.map((e) => e.toJson()).toList();
}
