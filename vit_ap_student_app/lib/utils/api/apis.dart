import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/utils/exceptions/CaptchaException.dart';
import 'package:vit_ap_student_app/utils/exceptions/ServerUnreachableException.dart';
import '../provider/providers.dart';

// Fetch and store credentials
Future<Map<String, String>> getCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    final secStorage = new FlutterSecureStorage(aOptions: _getAndroidOptions());
  String password = await secStorage.read(key: 'password') ?? '';
  if (password == '') {
    log("No password found");
  }
  return {
    'username': prefs.getString('username')!,
    'password': password,
    'semSubID': prefs.getString('semSubID')!,
  };
}

Future<Map<String, dynamic>> makeApiRequest(
  String endpoint,
  Map<String, String> body,
) async {
  const r = RetryOptions(maxAttempts: 5);
  log('Came to API ${dotenv.env['API_KEY']!}');
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/$endpoint');
    final http.Response response = await r.retry(
      () async {
        final response = await http.post(
          url,
          body: body,
          headers: {"API-KEY": dotenv.env['API_KEY']!},
        );
        log('Response Body : ${response.body}');
        if (response.statusCode == 404) {
          log('Status 404 ${response.body}');
          throw ServerUnreachableException(
              '404 Not Found', response.statusCode);
        }
        if (response.statusCode == 401 &&
            jsonDecode(response.body)["error"]["login"] == "Invalid Captcha") {
          log('Status 401 ${response.body}');
          throw InvalidCaptchaException('Invalid Captcha', response.statusCode);
        }
        return response;
      },
      retryIf: (e) =>
          e is ServerUnreachableException || e is InvalidCaptchaException,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log("Login Error ${response.body}");
      return {'error': "Unknown"};
    }
  } catch (e) {
    log("Came to unknown Error $e");
    return {'error': '${e}'};
  }
}

Future<http.Response> makeLoginRequest(
  String endpoint,
  Map<String, String> body,
) async {
  const r = RetryOptions(maxAttempts: 5);
  debugPrint('Came to API ${dotenv.env['API_KEY']!}');
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/$endpoint');
    final http.Response response = await r.retry(
      () async {
        final response = await http.post(
          url,
          body: body,
          headers: {"API-KEY": dotenv.env['API_KEY']!},
        );
        if (response.statusCode == 404) {
          throw ServerUnreachableException(
              '404 Not Found', response.statusCode);
        }
        if (response.statusCode == 401 &&
            jsonDecode(response.body)["error"]["login"] == "Invalid Captcha") {
          throw InvalidCaptchaException('Invalid Captcha', response.statusCode);
        }

        return response;
      },
      retryIf: (e) =>
          e is ServerUnreachableException || e is InvalidCaptchaException,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return response;
    } else {
      print(response.body);
    }

    return response;
  } catch (e) {
    print("Error $e");
    return http.Response('{}', 500); // Return a default error response
  }
}

// Attendance API
class AttendanceService {
  Future<Map<String, dynamic>> fetchAndStoreAttendanceData() async {
    Map<String, String> credentials = await getCredentials();
    Map<String, dynamic> jsonData =
        await makeApiRequest('login/attendance', credentials);

    if (jsonData.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('attendance', jsonEncode(jsonData['attendance']));
    }

    return jsonData['attendance'];
  }

  Future<Map<String, dynamic>> getStoredAttendanceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('attendance');
    if (jsonData != null) {
      return json.decode(jsonData);
    } else {
      throw Exception('No data found');
    }
  }
}

final attendanceServiceProvider = Provider((ref) => AttendanceService());

// Biometric API
Future<Map<String, dynamic>> fetchBiometricLog(String date) async {
  Map<String, String> credentials = await getCredentials();
  credentials['date'] = date;
  return makeApiRequest('login/biometric', credentials);
}

// Login API
Future fetchLoginData(String username, String password, String semSubID) async {
  Map<String, String> credentials = {
    'username': username,
    'password': password,
    'semSubID': semSubID,
  };
  return makeLoginRequest('login/getalldata', credentials);
}

// Payments API
Future<void> fetchPaymentDetails() async {
  Map<String, String> credentials = await getCredentials();
  final prefs = await SharedPreferences.getInstance();
  credentials['applno'] =
      jsonDecode(prefs.getString('profile')!)['application_number'];

  Map<String, dynamic> data =
      await makeApiRequest('login/payments', credentials);

  if (data.isNotEmpty) {
    prefs.setString('payments', jsonEncode(data['payments']));
  }
}

// Timetable API
Future<Map<String, dynamic>> fetchTimetable(WidgetRef ref) async {
  Map<String, String> credentials = await getCredentials();
  dynamic data = await makeApiRequest('login/timetable', credentials);
  log('Updated Data : $data');
  if (data.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();

    // Check if data['timetable'] is a Map
    if (data['timetable'] is Map) {
      prefs.setString('timetable', json.encode(data['timetable']));
      ref.read(timetableProvider.notifier).updateTimetable(data['timetable']);
    } else if (data['timetable'] is String) {
      // If it is already a String (possibly JSON-encoded), use it directly
      prefs.setString('timetable', data['timetable']);
      ref
          .read(timetableProvider.notifier)
          .updateTimetable(json.decode(data['timetable']));
    } else {
      log('Unexpected type for ${data["timetable"]}');
    }
  }

  return data['timetable'];
}
