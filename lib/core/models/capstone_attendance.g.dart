// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capstone_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapstoneAttendance _$CapstoneAttendanceFromJson(Map<String, dynamic> json) =>
    CapstoneAttendance(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      guideEvaluationStatus: json['guide_evaluation_status'] as String,
      dateOfRegistration: json['date_of_registration'] as String,
      present: json['present'] as String,
      onDuty: json['on_duty'] as String,
      absent: json['absent'] as String,
      percentage: json['percentage'] as String,
      punches: const _CapstonePunchRelToManyConverter().fromJson(
        json['punches'] as List?,
      ),
    );

Map<String, dynamic> _$CapstoneAttendanceToJson(
  CapstoneAttendance instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'guide_evaluation_status': instance.guideEvaluationStatus,
  'date_of_registration': instance.dateOfRegistration,
  'present': instance.present,
  'on_duty': instance.onDuty,
  'absent': instance.absent,
  'percentage': instance.percentage,
  'punches': const _CapstonePunchRelToManyConverter().toJson(instance.punches),
};

CapstonePunch _$CapstonePunchFromJson(Map<String, dynamic> json) =>
    CapstonePunch(
      id: (json['id'] as num?)?.toInt(),
      serial: json['serial'] as String,
      date: json['date'] as String,
      day: json['day'] as String,
      dayType: json['day_type'] as String,
      status: json['status'] as String,
      punchTime: json['punch_time'] as String,
    );

Map<String, dynamic> _$CapstonePunchToJson(CapstonePunch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serial': instance.serial,
      'date': instance.date,
      'day': instance.day,
      'day_type': instance.dayType,
      'status': instance.status,
      'punch_time': instance.punchTime,
    };
