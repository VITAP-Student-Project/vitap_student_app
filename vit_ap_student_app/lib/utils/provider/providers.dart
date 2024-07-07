import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/utils/api/weather/weather_notifier.dart';
import 'package:vit_ap_student_app/utils/provider/hourly_index_notifier.dart';

import '../api/attendence_api.dart';
import '../api/biometric_api.dart';

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

// Provider to fetch biometric log
final biometricLogProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, date) async {
  return fetchBiometricLog("23BCE7625", "v+v2no@tOw", date);
});

// StateNotifier to manage fetch trigger
class FetchTrigger extends StateNotifier<bool> {
  FetchTrigger() : super(false);

  void triggerFetch() {
    state = !state;
  }
}

final fetchTriggerProvider =
    StateNotifierProvider<FetchTrigger, bool>((ref) => FetchTrigger());

// Provider to handle fetching and storing attendance data
final fetchAttendanceProvider =
    FutureProvider.family<void, Map<String, String>>((ref, params) async {
  final service = ref.read(attendanceServiceProvider);
  String username = params['username']!;
  String password = params['password']!;
  String semSubID = params['semSubID']!;
  await service.fetchAndStoreAttendanceData(username, password, semSubID);
});
