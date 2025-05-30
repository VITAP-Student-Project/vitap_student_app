import 'package:json_annotation/json_annotation.dart';

part 'daily_units.g.dart';

@JsonSerializable()
class DailyUnits {
  @JsonKey(name: "time")
  String time;
  @JsonKey(name: "temperature_2m_max")
  String temperature2MMax;
  @JsonKey(name: "temperature_2m_min")
  String temperature2MMin;

  DailyUnits({
    required this.time,
    required this.temperature2MMax,
    required this.temperature2MMin,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) =>
      _$DailyUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$DailyUnitsToJson(this);
}
