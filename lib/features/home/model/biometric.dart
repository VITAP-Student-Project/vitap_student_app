import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'biometric.g.dart';

List<Biometric> biometricFromJson(String str) =>
    List<Biometric>.from(json.decode(str).map((x) => Biometric.fromJson(x)));

String biometricToJson(List<Biometric> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Biometric {
  @JsonKey(name: "time")
  String time;
  @JsonKey(name: "location")
  String location;

  Biometric({
    required this.time,
    required this.location,
  });

  factory Biometric.fromJson(Map<String, dynamic> json) =>
      _$BiometricFromJson(json);

  Map<String, dynamic> toJson() => _$BiometricToJson(this);
}
