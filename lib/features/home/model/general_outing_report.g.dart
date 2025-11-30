// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_outing_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralOutingReport _$GeneralOutingReportFromJson(Map<String, dynamic> json) =>
    GeneralOutingReport(
      id: (json['id'] as num?)?.toInt(),
      serial: json['serial'] as String,
      registrationNumber: json['registration_number'] as String,
      placeOfVisit: json['place_of_visit'] as String,
      purposeOfVisit: json['purpose_of_visit'] as String,
      fromDate: json['from_date'] as String,
      fromTime: json['from_time'] as String,
      toDate: json['to_date'] as String,
      toTime: json['to_time'] as String,
      status: json['status'] as String,
      canDownload: json['can_download'] as bool,
      leaveId: json['leave_id'] as String,
    );

Map<String, dynamic> _$GeneralOutingReportToJson(
        GeneralOutingReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serial': instance.serial,
      'registration_number': instance.registrationNumber,
      'place_of_visit': instance.placeOfVisit,
      'purpose_of_visit': instance.purposeOfVisit,
      'from_date': instance.fromDate,
      'from_time': instance.fromTime,
      'to_date': instance.toDate,
      'to_time': instance.toTime,
      'status': instance.status,
      'can_download': instance.canDownload,
      'leave_id': instance.leaveId,
    };
