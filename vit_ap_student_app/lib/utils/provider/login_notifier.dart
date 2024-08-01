import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/widgets/custom/my_snackbar.dart';
import '../../utils/api/login_api.dart';
import '../../utils/state/login_state.dart';
import '../../pages/features/bottom_navigation_bar.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  Future<void> login(String username, String password, String semSubID,
      BuildContext context) async {
    state = state.copyWith(status: LoginStatus.loading);
    try {
      final response = await fetchLoginData(username, password, semSubID);
      print(response.toString());
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
