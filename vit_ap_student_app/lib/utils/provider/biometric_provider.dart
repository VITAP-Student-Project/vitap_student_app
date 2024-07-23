import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/biometric_api.dart';


final biometricLogProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, date) async {
  return fetchBiometricLog(date);
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
