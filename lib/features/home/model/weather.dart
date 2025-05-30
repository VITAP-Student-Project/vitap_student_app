import 'package:json_annotation/json_annotation.dart';
import 'package:vit_ap_student_app/features/home/model/daily.dart';
import 'package:vit_ap_student_app/features/home/model/daily_units.dart';
import 'package:vit_ap_student_app/features/home/model/hourly.dart';
import 'package:vit_ap_student_app/features/home/model/hourly_units.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  @JsonKey(name: "latitude")
  double latitude;
  @JsonKey(name: "longitude")
  double longitude;
  @JsonKey(name: "generationtime_ms")
  double generationtimeMs;
  @JsonKey(name: "utc_offset_seconds")
  int utcOffsetSeconds;
  @JsonKey(name: "timezone")
  String timezone;
  @JsonKey(name: "timezone_abbreviation")
  String timezoneAbbreviation;
  @JsonKey(name: "elevation")
  int elevation;
  @JsonKey(name: "hourly_units")
  HourlyUnits hourlyUnits;
  @JsonKey(name: "hourly")
  Hourly hourly;
  @JsonKey(name: "daily_units")
  DailyUnits dailyUnits;
  @JsonKey(name: "daily")
  Daily daily;

  Weather({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
