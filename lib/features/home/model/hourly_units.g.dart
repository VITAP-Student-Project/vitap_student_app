// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_units.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyUnits _$HourlyUnitsFromJson(Map<String, dynamic> json) => HourlyUnits(
      time: json['time'] as String,
      temperature2M: json['temperature_2m'] as String,
      apparentTemperature: json['apparent_temperature'] as String,
      rain: json['rain'] as String,
      weatherCode: json['weather_code'] as String,
      uvIndex: json['uv_index'] as String,
    );

Map<String, dynamic> _$HourlyUnitsToJson(HourlyUnits instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature2M,
      'apparent_temperature': instance.apparentTemperature,
      'rain': instance.rain,
      'weather_code': instance.weatherCode,
      'uv_index': instance.uvIndex,
    };
