import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherNotifier extends ChangeNotifier {
  Map<String, dynamic> _weatherData = {};
  Map<String, dynamic> get weatherData => _weatherData;

  Future<void> fetchCurrentWeather() async {
    double latitude = 16.514;
    double longitude = 80.516;
    try {
      Uri url = Uri.parse(
          "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,apparent_temperature,rain,weather_code,uv_index&daily=temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=1&models=best_match");

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        _weatherData = jsonDecode(response.body);
        notifyListeners();
      } else {
        throw "An unexpected error occurred";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void startDailyUpdates() {
    fetchCurrentWeather(); // Initial fetch

    const duration = Duration(days: 1); // Call API every day
    Timer.periodic(duration, (_) async {
      try {
        await fetchCurrentWeather();
      } catch (error) {
        print("Error fetching weather data: $error");
      }
    });
  }
}
