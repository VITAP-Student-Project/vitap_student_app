import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/utils/api/weather/weather_notifier.dart';
import 'package:vit_ap_student_app/utils/provider/hourly_index_notifier.dart';

final weatherProvider = ChangeNotifierProvider((ref) => WeatherNotifier());

final weatherFutureProvider = FutureProvider<void>((ref) async {
  final weatherNotifier = ref.read(weatherProvider);
  await weatherNotifier.fetchCurrentWeather();
  weatherNotifier.startDailyUpdates();
});

final hourlyIndexProvider = ChangeNotifierProvider((ref) {
  final weatherNotifier = ref.watch(weatherProvider);
  return HourlyIndexNotifier(weatherNotifier);
});
