import 'package:json_annotation/json_annotation.dart';

part 'daily.g.dart';

@JsonSerializable()
class Daily {
  @JsonKey(name: "time")
  List<DateTime> time;
  @JsonKey(name: "temperature_2m_max")
  List<double> temperature2MMax;
  @JsonKey(name: "temperature_2m_min")
  List<double> temperature2MMin;

  Daily({
    required this.time,
    required this.temperature2MMax,
    required this.temperature2MMin,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
