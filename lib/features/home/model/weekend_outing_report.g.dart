// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekend_outing_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekendOutingReport _$WeekendOutingReportFromJson(Map<String, dynamic> json) =>
    WeekendOutingReport(
      serial: json['serial'] as String,
      registrationNumber: json['registration_number'] as String,
      hostelBlock: json['hostel_block'] as String,
      roomNumber: json['room_number'] as String,
      placeOfVisit: json['place_of_visit'] as String,
      purposeOfVisit: json['purpose_of_visit'] as String,
      time: json['time'] as String,
      contactNumber: json['contact_number'] as String? ?? '',
      parentContactNumber: json['parent_contact_number'] as String? ?? '',
      date: DateTime.parse(json['date'] as String),
      bookingId: json['booking_id'] as String? ?? '',
      status: json['status'] as String,
      canDownload: json['can_download'] as bool,
    );

Map<String, dynamic> _$WeekendOutingReportToJson(
        WeekendOutingReport instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'registration_number': instance.registrationNumber,
      'hostel_block': instance.hostelBlock,
      'room_number': instance.roomNumber,
      'place_of_visit': instance.placeOfVisit,
      'purpose_of_visit': instance.purposeOfVisit,
      'time': instance.time,
      'contact_number': instance.contactNumber,
      'parent_contact_number': instance.parentContactNumber,
      'date': instance.date.toIso8601String(),
      'booking_id': instance.bookingId,
      'status': instance.status,
      'can_download': instance.canDownload,
    };
