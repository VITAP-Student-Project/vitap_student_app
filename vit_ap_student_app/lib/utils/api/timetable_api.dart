import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/timetable_provider.dart';

Future<Map<String, dynamic>> fetchTimetable(
    String username, String password, String semSubID, WidgetRef ref) async {
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/timetable');
    Map<String, String> placeholder = {
      'username': username,
      'password': password,
      'semSubID': semSubID,
    };
    http.Response response = await http.post(url, body: placeholder);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Decode the JSON response body
      dynamic data = jsonDecode(response.body);
      
      // Access the biometric_log field
      print(data);

      // Store the timetable data in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('timetable', json.encode(data));

      // Update the Riverpod provider with the new data
      ref.read(timetableProvider.notifier).updateTimetable(data);

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
