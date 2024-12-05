import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/user.dart';

const String studentKey = "student_data";

Future<void> saveStudentToPrefs(Student student) async {
  final prefs = await SharedPreferences.getInstance();
  final studentJson = jsonEncode(student.toJson());
  log("Saved Data To Local Storage $studentJson ");
  prefs.setString(studentKey, studentJson);
}

Future<Student?> loadStudentFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final studentJson = prefs.getString(studentKey);
  if (studentJson != null) {
    log("Student local Json: $studentJson");
    return Student.fromJson(jsonDecode(studentJson));
  }
  return null;
}

Future<void> clearStudentPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(studentKey);
}

Future<void> updateLoginStatus(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<void> storeCredentials(
    String username, String semSubId, String password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('username', username);
  prefs.setString('semSubID', semSubId);
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final secStorage = new FlutterSecureStorage(aOptions: _getAndroidOptions());
  await secStorage.write(key: 'password', value: password);
}
