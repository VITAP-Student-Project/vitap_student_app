// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekend_outing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeekendOutingRecord _$WeekendOutingRecordFromJson(Map<String, dynamic> json) =>
    _WeekendOutingRecord(
      serial: json['serial'] as String,
      registrationNumber: json['registrationNumber'] as String,
      hostelBlock: json['hostelBlock'] as String,
      roomNumber: json['roomNumber'] as String,
      placeOfVisit: json['placeOfVisit'] as String,
      purposeOfVisit: json['purposeOfVisit'] as String,
      time: json['time'] as String,
      date: json['date'] as String,
      bookingId: json['bookingId'] as String,
      status: json['status'] as String,
      canDownload: json['canDownload'] as bool,
    );

Map<String, dynamic> _$WeekendOutingRecordToJson(
        _WeekendOutingRecord instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'registrationNumber': instance.registrationNumber,
      'hostelBlock': instance.hostelBlock,
      'roomNumber': instance.roomNumber,
      'placeOfVisit': instance.placeOfVisit,
      'purposeOfVisit': instance.purposeOfVisit,
      'time': instance.time,
      'date': instance.date,
      'bookingId': instance.bookingId,
      'status': instance.status,
      'canDownload': instance.canDownload,
    };
