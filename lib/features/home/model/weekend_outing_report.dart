import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'dart:convert';

part 'weekend_outing_report.g.dart';

List<WeekendOutingReport> weekendOutingReportFromJson(String str) =>
    List<WeekendOutingReport>.from(
        json.decode(str).map((x) => WeekendOutingReport.fromJson(x)));

String weekendOutingReportToJson(List<WeekendOutingReport> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Entity()
@JsonSerializable()
class WeekendOutingReport {
  @Id()
  int? id;

  @JsonKey(name: "serial")
  final String serial;
  @JsonKey(name: "registration_number")
  final String registrationNumber;
  @JsonKey(name: "hostel_block")
  final String hostelBlock;
  @JsonKey(name: "room_number")
  final String roomNumber;
  @JsonKey(name: "place_of_visit")
  final String placeOfVisit;
  @JsonKey(name: "purpose_of_visit")
  final String purposeOfVisit;
  @JsonKey(name: "time")
  final String time;
  @JsonKey(name: "contact_number", defaultValue: "")
  final String contactNumber;
  @JsonKey(name: "parent_contact_number", defaultValue: "")
  final String parentContactNumber;
  @JsonKey(name: "date")
  @Property(type: PropertyType.date)
  final DateTime date;
  @JsonKey(name: "booking_id", defaultValue: "")
  final String bookingId;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "can_download")
  final bool canDownload;

  WeekendOutingReport({
    this.id,
    required this.serial,
    required this.registrationNumber,
    required this.hostelBlock,
    required this.roomNumber,
    required this.placeOfVisit,
    required this.purposeOfVisit,
    required this.time,
    this.contactNumber = "",
    this.parentContactNumber = "",
    required this.date,
    this.bookingId = "",
    required this.status,
    required this.canDownload,
  });

  factory WeekendOutingReport.fromJson(Map<String, dynamic> json) =>
      _$WeekendOutingReportFromJson(json);

  Map<String, dynamic> toJson() => _$WeekendOutingReportToJson(this);
}
