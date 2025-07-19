import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'general_outing_report.g.dart';

List<GeneralOutingReport> generalOutingReportFromJson(String str) =>
    List<GeneralOutingReport>.from(
        json.decode(str).map((x) => GeneralOutingReport.fromJson(x)));

String generalOutingReportToJson(List<GeneralOutingReport> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GeneralOutingReport {
  @JsonKey(name: "serial")
  final String serial;
  @JsonKey(name: "registration_number")
  final String registrationNumber;
  @JsonKey(name: "place_of_visit")
  final String placeOfVisit;
  @JsonKey(name: "purpose_of_visit")
  final String purposeOfVisit;
  @JsonKey(name: "from_date")
  final String fromDate;
  @JsonKey(name: "from_time")
  final String fromTime;
  @JsonKey(name: "to_date")
  final String toDate;
  @JsonKey(name: "to_time")
  final String toTime;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "can_download")
  final bool canDownload;
  @JsonKey(name: "leave_id")
  final String leaveId;

  GeneralOutingReport({
    required this.serial,
    required this.registrationNumber,
    required this.placeOfVisit,
    required this.purposeOfVisit,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
    required this.status,
    required this.canDownload,
    required this.leaveId,
  });

  factory GeneralOutingReport.fromJson(Map<String, dynamic> json) =>
      _$GeneralOutingReportFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralOutingReportToJson(this);
}
