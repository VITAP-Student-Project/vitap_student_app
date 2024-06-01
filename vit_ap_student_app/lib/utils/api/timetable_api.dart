import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchTimetable(
    String username, String password) async {
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/timetable');
    Map<String, String> placeholder = {
      'username': username,
      'password': password,
    };
    http.Response response = await http.post(url, body: placeholder);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Decode the JSON response body
      dynamic data = jsonDecode(response.body);
      // Access the biometric_log field
      print(data);
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
