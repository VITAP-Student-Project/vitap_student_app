// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capstone_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CapstoneAttendance _$CapstoneAttendanceFromJson(Map<String, dynamic> json) =>
    _CapstoneAttendance(
      info: CapstoneInfo.fromJson(json['info'] as Map<String, dynamic>),
      summary: CapstoneSummary.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      punches: (json['punches'] as List<dynamic>)
          .map((e) => CapstonePunch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CapstoneAttendanceToJson(_CapstoneAttendance instance) =>
    <String, dynamic>{
      'info': instance.info,
      'summary': instance.summary,
      'punches': instance.punches,
    };

_CapstoneInfo _$CapstoneInfoFromJson(Map<String, dynamic> json) =>
    _CapstoneInfo(
      title: json['title'] as String,
      guideEvaluationStatus: json['guideEvaluationStatus'] as String,
      dateOfRegistration: json['dateOfRegistration'] as String,
    );

Map<String, dynamic> _$CapstoneInfoToJson(_CapstoneInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'guideEvaluationStatus': instance.guideEvaluationStatus,
      'dateOfRegistration': instance.dateOfRegistration,
    };

_CapstonePunch _$CapstonePunchFromJson(Map<String, dynamic> json) =>
    _CapstonePunch(
      serial: json['serial'] as String,
      date: json['date'] as String,
      day: json['day'] as String,
      dayType: json['dayType'] as String,
      status: json['status'] as String,
      punchTime: json['punchTime'] as String,
    );

Map<String, dynamic> _$CapstonePunchToJson(_CapstonePunch instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'date': instance.date,
      'day': instance.day,
      'dayType': instance.dayType,
      'status': instance.status,
      'punchTime': instance.punchTime,
    };

_CapstoneSummary _$CapstoneSummaryFromJson(Map<String, dynamic> json) =>
    _CapstoneSummary(
      present: json['present'] as String,
      onDuty: json['onDuty'] as String,
      absent: json['absent'] as String,
      percentage: json['percentage'] as String,
    );

Map<String, dynamic> _$CapstoneSummaryToJson(_CapstoneSummary instance) =>
    <String, dynamic>{
      'present': instance.present,
      'onDuty': instance.onDuty,
      'absent': instance.absent,
      'percentage': instance.percentage,
    };
