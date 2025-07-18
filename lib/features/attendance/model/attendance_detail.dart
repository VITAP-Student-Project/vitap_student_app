import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'attendance_detail.g.dart';

List<AttendanceDetail> attendanceDetailFromJson(String str) =>
    List<AttendanceDetail>.from(
        json.decode(str).map((x) => AttendanceDetail.fromJson(x)));

String attendanceDetailToJson(List<AttendanceDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class AttendanceDetail {
  @JsonKey(name: "serial")
  final String serial;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "slot")
  final String slot;
  @JsonKey(name: "day_time")
  final String dayTime;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "remark")
  final String remark;

  AttendanceDetail({
    required this.serial,
    required this.date,
    required this.slot,
    required this.dayTime,
    required this.status,
    required this.remark,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailToJson(this);
}
