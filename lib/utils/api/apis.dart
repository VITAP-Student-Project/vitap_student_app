import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/utils/exceptions/CaptchaException.dart';
import 'package:vit_ap_student_app/utils/exceptions/ServerUnreachableException.dart';

import '../exceptions/MissingCredentialException.dart';
import '../provider/student_provider.dart';

Future<Map<String, String>> getCredentials() async {
  final prefs = await SharedPreferences.getInstance();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final secStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String? username = prefs.getString('username');
  String? semSubID = prefs.getString('semSubID');
  String? password = await secStorage.read(key: 'password');

  if (username == null || username.isEmpty) {
    throw MissingCredentialsException("Username is missing or empty.");
  }

  if (semSubID == null || semSubID.isEmpty) {
    throw MissingCredentialsException(
        "Semester Subject ID is missing or empty.");
  }

  if (password == null || password.isEmpty) {
    throw MissingCredentialsException("Password is missing or empty.");
  }

  return {
    'username': username,
    'password': password,
    'semSubID': semSubID,
  };
}

Future<http.Response> makeApiRequest(
  String endpoint,
  Map<String, String> body,
) async {
  const r = RetryOptions(maxAttempts: 5);
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
      log("Login response in 200 : ${response.body}");
      return response;
    } else {
      log("Login response in not 200 error : ${response.body}");
      return response;
    }
  } catch (e) {
    log("Came to try catch Error $e");
    return http.Response('{error : $e}', 500);
  }
}

Future<http.Response> makeLoginRequest(
  String endpoint,
  Map<String, String> body,
) async {
  const r = RetryOptions(maxAttempts: 5);
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/$endpoint');
    final http.Response response = await r.retry(
      () async {
        final response = await http.post(
          url,
          body: body,
          headers: {"API-KEY": dotenv.env['API_KEY']!},
        ).timeout(
          const Duration(seconds: 20),
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

Future<http.Response> fetchAttendanceData(WidgetRef ref) async {
  Map<String, String> credentials =
      await ref.read(studentProvider.notifier).getCredentials();
  return await makeApiRequest('login/attendance', credentials);
}

// Biometric API
Future<http.Response> fetchBiometricLog(String date) async {
  Map<String, String> credentials = await getCredentials();
  credentials['date'] = date;
  return await makeApiRequest('login/biometric', credentials);
}

// Login API
Future fetchStudentData(
  String username,
  String password,
  String semSubID,
  WidgetRef ref,
) async {
  Map<String, String> credentials = {
    'username': username,
    'password': password,
    'semSubID': semSubID,
  };
  return await makeLoginRequest('login/getalldata', credentials);
}

// Payments API
Future<http.Response> fetchPaymentDetails() async {
  Map<String, String> credentials = await getCredentials();
  final prefs = await SharedPreferences.getInstance();
  credentials['applno'] =
      jsonDecode(prefs.getString('profile')!)['application_number'];

  return await makeApiRequest('login/payments', credentials);
}

// Timetable API
Future<http.Response> fetchTimetable(WidgetRef ref) async {
  Map<String, String> credentials =
      await ref.read(studentProvider.notifier).getCredentials();
  return await makeApiRequest('login/timetable', credentials);
}

// General Outing API
Future<http.Response> postGeneralOutingForm(
    String outPlace,
    String purposeOfVisit,
    String outingDate,
    String outTime,
    String inDate,
    String inTime) async {
  Map<String, String> credentials = await getCredentials();
  credentials['outPlace'] = outPlace;
  credentials['purposeOfVisit'] = purposeOfVisit;
  credentials['outingDate'] = outingDate;
  credentials['outTime'] = outTime;
  credentials['inDate'] = inDate;
  credentials['inTime'] = inTime;

  return await makeApiRequest('login/generaloutingform', credentials);
}

// Weekend Outing API
Future<http.Response> postWeekendOutingForm(
    String outPlace,
    String purposeOfVisit,
    String outingDate,
    String outTime,
    String contactNumber) async {
  Map<String, String> credentials = await getCredentials();
  credentials['outPlace'] = outPlace;
  credentials['purposeOfVisit'] = purposeOfVisit;
  credentials['outingDate'] = outingDate;
  credentials['outTime'] = outTime;
  credentials['contactNumber'] = contactNumber;

  return await makeApiRequest('login/weekendoutingform', credentials);
}

//Fetch Weekend outing requests history
Future<http.Response> fetchWeekendOutingRequests() async {
  Map<String, String> credentials = await getCredentials();
  return await makeApiRequest('login/weekendoutingrequests', credentials);
}

//Fetch General outing requests history
Future<http.Response> fetchGeneralOutingRequests() async {
  Map<String, String> credentials = await getCredentials();
  return await makeApiRequest('login/generaloutingrequests', credentials);
}

//Fetch marks
Future<http.Response> fetchMarks(WidgetRef ref) async {
  Map<String, String> credentials =
      await ref.read(studentProvider.notifier).getCredentials();
  return await makeApiRequest('login/marks', credentials);
}

//Fetch exam schedule
Future<http.Response> fetchExamSchedule(WidgetRef ref) async {
  Map<String, String> credentials =
      await ref.read(studentProvider.notifier).getCredentials();
  return await makeApiRequest('login/examschedule', credentials);
}
