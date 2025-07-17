// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HostelLeaveData _$HostelLeaveDataFromJson(Map<String, dynamic> json) =>
    _HostelLeaveData(
      records: (json['records'] as List<dynamic>)
          .map((e) => LeaveRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      updateTime: BigInt.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$HostelLeaveDataToJson(_HostelLeaveData instance) =>
    <String, dynamic>{
      'records': instance.records,
      'updateTime': instance.updateTime.toString(),
    };

_HostelOutingData _$HostelOutingDataFromJson(Map<String, dynamic> json) =>
    _HostelOutingData(
      records: (json['records'] as List<dynamic>)
          .map((e) => OutingRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      updateTime: BigInt.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$HostelOutingDataToJson(_HostelOutingData instance) =>
    <String, dynamic>{
      'records': instance.records,
      'updateTime': instance.updateTime.toString(),
    };

_LeaveRecord _$LeaveRecordFromJson(Map<String, dynamic> json) => _LeaveRecord(
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

Map<String, dynamic> _$LeaveRecordToJson(_LeaveRecord instance) =>
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

_OutingRecord _$OutingRecordFromJson(Map<String, dynamic> json) =>
    _OutingRecord(
      serial: json['serial'] as String,
      registrationNumber: json['registrationNumber'] as String,
      hostelBlock: json['hostelBlock'] as String,
      roomNumber: json['roomNumber'] as String,
      placeOfVisit: json['placeOfVisit'] as String,
      purposeOfVisit: json['purposeOfVisit'] as String,
      time: json['time'] as String,
      contactNumber: json['contactNumber'] as String,
      parentContactNumber: json['parentContactNumber'] as String,
      date: json['date'] as String,
      bookingId: json['bookingId'] as String,
      status: json['status'] as String,
      canDownload: json['canDownload'] as bool,
    );

Map<String, dynamic> _$OutingRecordToJson(_OutingRecord instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'registrationNumber': instance.registrationNumber,
      'hostelBlock': instance.hostelBlock,
      'roomNumber': instance.roomNumber,
      'placeOfVisit': instance.placeOfVisit,
      'purposeOfVisit': instance.purposeOfVisit,
      'time': instance.time,
      'contactNumber': instance.contactNumber,
      'parentContactNumber': instance.parentContactNumber,
      'date': instance.date,
      'bookingId': instance.bookingId,
      'status': instance.status,
      'canDownload': instance.canDownload,
    };
