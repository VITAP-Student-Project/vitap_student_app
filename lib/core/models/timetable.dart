import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'timetable.g.dart';

@Entity()
@JsonSerializable()
class Timetable {
  @Id()
  int id = 0;

  @_DayRelToManyConverter()
  final ToMany<Day> monday = ToMany<Day>();

  @_DayRelToManyConverter()
  final ToMany<Day> tuesday = ToMany<Day>();

  @_DayRelToManyConverter()
  final ToMany<Day> wednesday = ToMany<Day>();

  @_DayRelToManyConverter()
  final ToMany<Day> thursday = ToMany<Day>();

  @_DayRelToManyConverter()
  final ToMany<Day> friday = ToMany<Day>();

  @_DayRelToManyConverter()
  final ToMany<Day> saturday = ToMany<Day>();

  @_DayRelToManyConverter()
  final ToMany<Day> sunday = ToMany<Day>();

  Timetable();

  factory Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);
  Map<String, dynamic> toJson() => _$TimetableToJson(this);
}

@Entity()
@JsonSerializable()
class Day {
  @Id()
  int id = 0;

  final String courseName;
  final String slot;
  final String venue;
  final String faculty;
  final String courseCode;
  final String courseType;

  Day({
    required this.courseName,
    required this.slot,
    required this.venue,
    required this.faculty,
    required this.courseCode,
    required this.courseType,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
  Map<String, dynamic> toJson() => _$DayToJson(this);
}

class _DayRelToManyConverter
    implements JsonConverter<ToMany<Day>, List<Map<String, dynamic>>?> {
  const _DayRelToManyConverter();

  @override
  ToMany<Day> fromJson(List<Map<String, dynamic>>? json) =>
      ToMany<Day>(items: json?.map((e) => Day.fromJson(e)).toList() ?? []);

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Day> rel) =>
      rel.map((e) => e.toJson()).toList();
}
