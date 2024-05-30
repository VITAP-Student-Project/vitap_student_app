import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void fetchLoginData(username, password) async {
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/getAllData');
    Map placeholder = {'username': username, 'password': password};
    http.Response response = await http.post(url, body: placeholder);
    print('Response status: ${response.statusCode}');
    dynamic data = response.body;
    print(data);
    if (data) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('attendanceJson', json.decode(data["attendance"]));
    prefs.setString('profileJson', json.decode(data["profile"]));
    prefs.setString('timetableJson', json.decode(data["timetable"]));

    }
  } catch (e) {
    print("Error $e");
  }
}