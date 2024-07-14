import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/biometric_api.dart';

String username = '';
String password = '';
void getUserDetails() async {
  final prefs = await SharedPreferences.getInstance();
  username = prefs.getString('username')!;
  password = prefs.getString('password')!;
}

final biometricLogProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, date) async {
  return fetchBiometricLog(username, password, date);
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
