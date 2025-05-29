// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num?)?.toInt(),
      profile: const _ProfileRelToOneConverter()
          .fromJson(json['profile'] as Map<String, dynamic>?),
      attendance: const _AttendanceRelToManyConverter()
          .fromJson(json['attendance'] as List?),
      timetable: const _TimetableRelToOneConverter()
          .fromJson(json['timetable'] as Map<String, dynamic>?),
      examSchedule: const _ExamScheduleRelToManyConverter()
          .fromJson(json['exam_schedule'] as List?),
      gradeHistory: const _GradeHistoryRelToOneConverter()
          .fromJson(json['grade_history'] as Map<String, dynamic>?),
      marks: const _MarkRelToManyConverter().fromJson(json['marks'] as List?),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'profile': const _ProfileRelToOneConverter().toJson(instance.profile),
      'attendance':
          const _AttendanceRelToManyConverter().toJson(instance.attendance),
      'timetable':
          const _TimetableRelToOneConverter().toJson(instance.timetable),
      'exam_schedule':
          const _ExamScheduleRelToManyConverter().toJson(instance.examSchedule),
      'grade_history':
          const _GradeHistoryRelToOneConverter().toJson(instance.gradeHistory),
      'marks': const _MarkRelToManyConverter().toJson(instance.marks),
    };
