import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '.././utils/provider/providers.dart';
import 'provider/biometric_provider.dart';
import 'provider/notification_utils_provider.dart';
import 'provider/student_provider.dart';

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
  // ref.invalidate(fetchAttendanceProvider);
  ref.invalidate(biometricLogProvider); // This is new
  ref.invalidate(loginProvider);
  ref.invalidate(timetableProvider);
  ref.invalidate(paymentProvider);
  ref.invalidate(classNotificationSliderProvider); // This is new
  ref.invalidate(classNotificationProvider); // This is new
  ref.invalidate(examNotificationSliderProvider); // This is new
  ref.invalidate(examNotificationProvider); // This is new
  ref.invalidate(privacyModeProvider); // Changes not needed
  ref.invalidate(generalOutingProvider);
  ref.invalidate(weekendOutingProvider);
  ref.invalidate(weekendOutingRequestsProvider);
  ref.invalidate(generalOutingRequestsProvider);
  ref.read(studentProvider.notifier).resetStudent(); // This is new
  ref.invalidate(studentProvider); // This is new
  log("Cleared main providers");

  // ref.read(loginProvider.notifier).state = LoginState();
  // ref.read(timetableProvider.notifier).state = {};
  // ref.read(sliderProvider.notifier).state = 5.0;
  // ref.read(notificationProvider.notifier).state = false;
  // ref.read(privacyModeProvider.notifier).state = false;
  // log("Cleared side providers");

  log("Login set to false");
}
