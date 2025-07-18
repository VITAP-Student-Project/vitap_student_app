// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_outing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneralOutingRecord _$GeneralOutingRecordFromJson(Map<String, dynamic> json) =>
    _GeneralOutingRecord(
      serial: json['serial'] as String,
      registrationNumber: json['registrationNumber'] as String,
      placeOfVisit: json['placeOfVisit'] as String,
      purposeOfVisit: json['purposeOfVisit'] as String,
      fromDate: json['fromDate'] as String,
      fromTime: json['fromTime'] as String,
      toDate: json['toDate'] as String,
      toTime: json['toTime'] as String,
      status: json['status'] as String,
      canDownload: json['canDownload'] as bool,
      leaveId: json['leaveId'] as String,
    );

Map<String, dynamic> _$GeneralOutingRecordToJson(
        _GeneralOutingRecord instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'registrationNumber': instance.registrationNumber,
      'placeOfVisit': instance.placeOfVisit,
      'purposeOfVisit': instance.purposeOfVisit,
      'fromDate': instance.fromDate,
      'fromTime': instance.fromTime,
      'toDate': instance.toDate,
      'toTime': instance.toTime,
      'status': instance.status,
      'canDownload': instance.canDownload,
      'leaveId': instance.leaveId,
    };
