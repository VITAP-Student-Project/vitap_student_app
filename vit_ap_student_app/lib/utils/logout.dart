import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '.././utils/provider/providers.dart';

Future<void> clearAllProviders(WidgetRef ref) async {
  // Clear SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  // Clear FlutterSecureStorage
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final secStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  await secStorage.deleteAll();

  // Reset each provider to its initial state
  ref.invalidate(fetchAttendanceProvider);
  ref.invalidate(biometricLogProvider);
  ref.invalidate(fetchTriggerProvider);
  ref.invalidate(loginProvider);
  ref.invalidate(timetableProvider);
  ref.invalidate(paymentProvider);
  ref.invalidate(sliderProvider);
  ref.invalidate(notificationProvider);
  ref.invalidate(privacyModeProvider);
  ref.invalidate(generalOutingProvider);
  ref.invalidate(weekendOutingProvider);
  ref.invalidate(weekendOutingRequestsProvider);
  ref.invalidate(generalOutingRequestsProvider);
  log("Cleared main providers");

  // ref.read(loginProvider.notifier).state = LoginState();
  // ref.read(timetableProvider.notifier).state = {};
  // ref.read(sliderProvider.notifier).state = 5.0;
  // ref.read(notificationProvider.notifier).state = false;
  // ref.read(privacyModeProvider.notifier).state = false;
  // log("Cleared side providers");

  prefs.setBool('isLoggedIn', false);
  log("Login set to false");
}
