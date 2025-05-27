import 'package:json_annotation/json_annotation.dart';

part 'hourly.g.dart';

@JsonSerializable()
class Hourly {
  @JsonKey(name: "time")
  List<String> time;
  @JsonKey(name: "temperature_2m")
  List<double> temperature2M;
  @JsonKey(name: "apparent_temperature")
  List<double> apparentTemperature;
  @JsonKey(name: "rain")
  List<double> rain;
  @JsonKey(name: "weather_code")
  List<int> weatherCode;
  @JsonKey(name: "uv_index")
  List<double> uvIndex;

  Hourly({
    required this.time,
    required this.temperature2M,
    required this.apparentTemperature,
    required this.rain,
    required this.weatherCode,
    required this.uvIndex,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}
