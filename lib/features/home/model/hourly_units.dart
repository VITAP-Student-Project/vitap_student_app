import 'package:json_annotation/json_annotation.dart';

part 'hourly_units.g.dart';

@JsonSerializable()
class HourlyUnits {
  @JsonKey(name: "time")
  String time;
  @JsonKey(name: "temperature_2m")
  String temperature2M;
  @JsonKey(name: "apparent_temperature")
  String apparentTemperature;
  @JsonKey(name: "rain")
  String rain;
  @JsonKey(name: "weather_code")
  String weatherCode;
  @JsonKey(name: "uv_index")
  String uvIndex;

  HourlyUnits({
    required this.time,
    required this.temperature2M,
    required this.apparentTemperature,
    required this.rain,
    required this.weatherCode,
    required this.uvIndex,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) =>
      _$HourlyUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyUnitsToJson(this);
}
