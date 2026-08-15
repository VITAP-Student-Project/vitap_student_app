import 'package:timezone/timezone.dart' as tz;
import 'package:vit_ap_student_app/core/constants/wmo_code.dart';
import 'package:vit_ap_student_app/core/utils/find_hour_index.dart';
import 'package:vit_ap_student_app/features/home/model/weather.dart';

/// The handful of numbers the home page actually shows, picked out of the
/// forecast once.
///
/// The API returns parallel hourly arrays that have to be indexed by the current
/// hour in the campus timezone. Doing that inside a widget meant the strip and
/// its detail sheet would each repeat the lookup — and could disagree if they
/// resolved on either side of an hour boundary.
class WeatherSnapshot {
  const WeatherSnapshot({
    required this.temperature,
    required this.apparentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.weatherCode,
  });

  /// Reads the forecast for the current hour, or `null` when the payload is too
  /// sparse to index — [findHourIndex] throws on an empty series.
  static WeatherSnapshot? from(Weather weather) {
    if (weather.hourly.time.isEmpty) return null;
    if (weather.daily.temperature2MMin.isEmpty ||
        weather.daily.temperature2MMax.isEmpty) {
      return null;
    }

    final tz.Location location = tz.getLocation(weather.timezone);
    final List<tz.TZDateTime> hourlyTimes = weather.hourly.time
        .map((String time) => tz.TZDateTime.parse(location, time))
        .toList();
    final int index = findHourIndex(hourlyTimes, tz.TZDateTime.now(location));

    if (index >= weather.hourly.temperature2M.length ||
        index >= weather.hourly.apparentTemperature.length ||
        index >= weather.hourly.weatherCode.length) {
      return null;
    }

    return WeatherSnapshot(
      temperature: weather.hourly.temperature2M[index],
      apparentTemperature: weather.hourly.apparentTemperature[index],
      minTemperature: weather.daily.temperature2MMin[0],
      maxTemperature: weather.daily.temperature2MMax[0],
      weatherCode: weather.hourly.weatherCode[index],
    );
  }

  final double temperature;
  final double apparentTemperature;
  final double minTemperature;
  final double maxTemperature;
  final int weatherCode;

  String get description =>
      getWeatherDescription(weatherCode)['description'] ?? '';

  String get iconAsset =>
      getWeatherDescription(weatherCode)['assetPath'] ??
      'assets/weather_icons/not-available.json';
}
