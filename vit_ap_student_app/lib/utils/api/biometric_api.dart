import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/utils/exceptions/ServerUnreachableException.dart';

Future<Map<String, dynamic>> fetchBiometricLog(String date) async {
  final prefs = await SharedPreferences.getInstance();
  String? _username = prefs.getString('username');
  String? _password = prefs.getString('password');

  if (_username == null || _password == null) {
    print('Username or password not found in SharedPreferences.');
    return {};
  }
  const r = RetryOptions(maxAttempts: 5);
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/biometric');
    Map<String, String> placeholder = {
      'username': _username,
      'password': _password,
      'date': date,
    };
    http.Response response = await r.retry(
      () async {
        final response = await http.post(
          url,
          body: placeholder,
          headers: {"API-KEY": dotenv.env['API_KEY']!},
        );

        if (response.statusCode == 404) {
          throw ServerUnreachableException(
              '404 Not Found', response.statusCode);
        }

        return response;
      },
      retryIf: (e) => e is ServerUnreachableException && e.statusCode == 404,
    );

    print(response.body);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Decode the JSON response body
      Map<String, dynamic> data = jsonDecode(response.body);
      // Access the biometric_log field
      return data["biometric_log"];
    } else {
      print('Failed to load data');
      return {};
    }
  } catch (e) {
    print("Error $e");
    return {};
  }
}
