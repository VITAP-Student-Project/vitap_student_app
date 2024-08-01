import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../exceptions/ServerUnreachableException.dart';
import '../provider/timetable_provider.dart';

Future<Map<String, dynamic>> fetchTimetable(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  const r = RetryOptions(maxAttempts: 5);
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/timetable');
    Map<String, String> placeholder = {
      'username': prefs.getString('username')!,
      'password': prefs.getString('password')!,
      'semSubID': prefs.getString('semSubID')!,
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
      retryIf: (e) => e is ServerUnreachableException,
    );

    if (response.statusCode == 200) {
      // Decode the JSON response body
      dynamic data = jsonDecode(response.body)['timetable'];

      // Access the biometric_log field
      print(data);

      // Store the timetable data in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('timetable', json.encode(data));

      // Update the Riverpod provider with the new data
      ref.read(timetableProvider.notifier).updateTimetable(data);

      return data;
    } else {
      print(response.body);
      return {};
    }
  } catch (e) {
    print("Error $e");
    return {};
  }
}
