import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

import 'attendance.dart';
import 'exam_schedule.dart';
import 'grade_history.dart';
import 'mark.dart';
import 'profile.dart';
import 'timetable.dart';

part 'user.g.dart';

@Entity()
@JsonSerializable()
class User {
  @Id()
  int? id;

  @JsonKey(name: "profile")
  @_ProfileRelToOneConverter()
  final ToOne<Profile> profile;

  @JsonKey(name: "attendance")
  @_AttendanceRelToManyConverter()
  final ToMany<Attendance> attendance;

  @JsonKey(name: "timetable")
  @_TimetableRelToOneConverter()
  final ToOne<Timetable> timetable;

  @JsonKey(name: "exam_schedule")
  @_ExamScheduleRelToManyConverter()
  final ToMany<ExamSchedule> examSchedule;

  @JsonKey(name: "marks")
  @_MarkRelToManyConverter()
  final ToMany<Mark> marks;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User(this.id,
      {required this.profile,
      required this.attendance,
      required this.timetable,
      required this.examSchedule,
      required this.marks});

  User copyWith({
    int? id,
    ToOne<Profile>? profile,
    ToMany<Attendance>? attendance,
    ToOne<Timetable>? timetable,
    ToMany<ExamSchedule>? examSchedule,
    ToOne<GradeHistory>? gradeHistory,
    ToMany<Mark>? marks,
  }) =>
      User(
        id ?? this.id,
        profile: profile ?? this.profile,
        attendance: attendance ?? this.attendance,
        timetable: timetable ?? this.timetable,
        examSchedule: examSchedule ?? this.examSchedule,
        marks: marks ?? this.marks,
      );
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// Converters for User relations
class _ProfileRelToOneConverter
    implements JsonConverter<ToOne<Profile>, Map<String, dynamic>?> {
  const _ProfileRelToOneConverter();

  @override
  ToOne<Profile> fromJson(Map<String, dynamic>? json) =>
      ToOne<Profile>(target: json == null ? null : Profile.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<Profile> rel) => rel.target?.toJson();
}

class _AttendanceRelToManyConverter
    implements JsonConverter<ToMany<Attendance>, List<dynamic>?> {
  const _AttendanceRelToManyConverter();

  @override
  ToMany<Attendance> fromJson(List<dynamic>? json) {
    final items = json
            ?.map((e) => Attendance.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return ToMany<Attendance>(items: items);
  }

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
    implements JsonConverter<ToMany<ExamSchedule>, List<dynamic>?> {
  const _ExamScheduleRelToManyConverter();

  @override
  ToMany<ExamSchedule> fromJson(List<dynamic>? json) {
    final items = json
            ?.map((e) => ExamSchedule.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return ToMany<ExamSchedule>(items: items);
  }

  @override
  List<Map<String, dynamic>>? toJson(ToMany<ExamSchedule> rel) =>
      rel.map((e) => e.toJson()).toList();
}

class _MarkRelToManyConverter
    implements JsonConverter<ToMany<Mark>, List<dynamic>?> {
  const _MarkRelToManyConverter();

  @override
  ToMany<Mark> fromJson(List<dynamic>? json) {
    final items =
        json?.map((e) => Mark.fromJson(e as Map<String, dynamic>)).toList() ??
            [];
    return ToMany<Mark>(items: items);
  }

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Mark> rel) =>
      rel.map((e) => e.toJson()).toList();
}
