import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:vit_ap_student_app/utils/api/weather/weather_notifier.dart';

class HourlyIndexNotifier extends ChangeNotifier {
  final WeatherNotifier weatherNotifier;
  int _index = 0; // Initial value
  int get index => _index;

  HourlyIndexNotifier(this.weatherNotifier) {
    // Initial check
    _updateIndex();
    // Set up a listener to update index when weather data changes
    weatherNotifier.addListener(_updateIndex);
    // Set up a timer to update the index every hour
    Timer.periodic(Duration(hours: 1), (timer) {
      _updateIndex();
    });
  }

  void _updateIndex() {
    var now = DateTime.now(); // Convert to UTC
    var formatter = DateFormat('yyyy-MM-ddTHH:00');
    String currentTime = formatter.format(now);
    int newIndex = -1; // Default to -1, indicating not found

    if (weatherNotifier.weatherData != null &&
        weatherNotifier.weatherData['hourly'] != null &&
        weatherNotifier.weatherData['hourly']['time'] != null) {
      newIndex =
          weatherNotifier.weatherData['hourly']['time'].indexOf(currentTime);
    }

    // Only update _index if newIndex is valid
    if (newIndex != -1 && newIndex != _index) {
      _index = newIndex;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    weatherNotifier.removeListener(_updateIndex);
    super.dispose();
  }
}
