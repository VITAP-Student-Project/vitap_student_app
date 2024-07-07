// attendance_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceService {
  Future<Map<String, dynamic>> fetchAndStoreAttendanceData(
      String username, String password, String semSubID) async {
    try {
      Uri url = Uri.parse('https://vit-ap.fly.dev/login/attendence');
      Map<String, String> placeholder = {
        'username': username,
        'password': password,
        'semSubID': semSubID,
      };
      http.Response response = await http.post(url, body: placeholder);
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body)['attendence'];
        print('Fetched Data: $data');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('attendanceData', jsonEncode(data));

        return data;
      } else {
        print('Failed to load data');
        return {};
      }
    } catch (e) {
      print("Error $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> getStoredAttendanceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('attendanceData');

    if (jsonData != null) {
      return json.decode(jsonData);
    } else {
      throw Exception('No data found');
    }
  }
}

final attendanceServiceProvider = Provider((ref) => AttendanceService());

