import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/models/widgets/custom/my_snackbar.dart';
import 'package:vit_ap_student_app/utils/state/login_state.dart';
import 'package:vit_ap_student_app/pages/features/bottom_navigation_bar.dart';
import '../api/apis.dart';

// Attendance Provider
final fetchAttendanceProvider =
    FutureProvider.family<void, Map<String, String>>((ref, params) async {
  final service = ref.read(attendanceServiceProvider);
  await service.fetchAndStoreAttendanceData();
});

// Biometric Provider
final biometricLogProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, date) async {
  return fetchBiometricLog(date);
});

// Fetch Trigger Provider
class FetchTrigger extends StateNotifier<bool> {
  FetchTrigger() : super(false);

  void triggerFetch() {
    state = !state;
  }
}

final fetchTriggerProvider =
    StateNotifierProvider<FetchTrigger, bool>((ref) => FetchTrigger());

// Login Notifier
class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  Future<void> login(String username, String password, String semSubID,
      BuildContext context) async {
    log('Accessed Provider');
    state = state.copyWith(status: LoginStatus.loading);
    try {
      final response = await fetchLoginData(username, password, semSubID);
      log('Got response');
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setString('password', password);
        await prefs.setString('semSubID', semSubID);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('timetable', jsonEncode(data['timetable']));
        await prefs.setString('attendance', jsonEncode(data['attendance']));
        await prefs.setString('profile', jsonEncode(data['profile']));
        await prefs.setString(
            'exam_schedule', jsonEncode(data['exam_schedule']));

        state = state.copyWith(status: LoginStatus.success);
        final snackBar = MySnackBar(
          title: 'Success!',
          message: 'Logged in successfully',
          contentType: ContentType.success,
        ).build(context);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar as SnackBar);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyBNB()),
          (Route<dynamic> route) => false,
        );
      } else if (response.statusCode == 401) {
        state = state.copyWith(status: LoginStatus.failure);
        final snackBar = MySnackBar(
          title: 'Oops!',
          message:
              'Login failed : ${jsonDecode(response.body)["error"]["login"]}',
          contentType: ContentType.failure,
        ).build(context);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar as SnackBar);
      } else {
        state = state.copyWith(status: LoginStatus.failure);
        final snackBar = MySnackBar(
          title: 'Oops!',
          message: 'Login failed : ${response.body}',
          contentType: ContentType.failure,
        ).build(context);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar as SnackBar);
      }
    } catch (e) {
      state = state.copyWith(status: LoginStatus.failure);
      log('An error occurred: $e');
      final snackBar = MySnackBar(
        title: 'Error!',
        message: 'An error occurred: $e',
        contentType: ContentType.failure,
      ).build(context);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar as SnackBar);
    }
  }
}

// Login Provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

// Timetable Provider
final timetableProvider =
    StateNotifierProvider<TimetableNotifier, Map<String, dynamic>>((ref) {
  return TimetableNotifier();
});

class TimetableNotifier extends StateNotifier<Map<String, dynamic>> {
  TimetableNotifier() : super({}) {
    loadTimetable();
  }

  Future<void> loadTimetable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? timetableString = prefs.getString('timetable');
    if (timetableString != null) {
      Map<String, dynamic> timetableMap = json.decode(timetableString);
      state = timetableMap;
    } else {
      state = {};
    }
  }

  Future<void> updateTimetable(Map<String, dynamic> newTimetable) async {
    state = newTimetable;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String timetableString = json.encode(newTimetable);
    await prefs.setString('timetable', timetableString);
  }
}

//Payment Provider

final paymentProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  await fetchPaymentDetails();
  final prefs = await SharedPreferences.getInstance();
  final paymentString = prefs.getString('payments') ?? '';
  if (paymentString.isNotEmpty) {
    return json.decode(paymentString);
  }
  return {};
});
