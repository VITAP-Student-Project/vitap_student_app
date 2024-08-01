import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/utils/exceptions/ServerUnreachableException.dart';

import '../provider/providers.dart';

// Fetch and store credentials
Future<Map<String, String>> getCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'username': prefs.getString('username')!,
    'password': prefs.getString('password')!,
    'semSubID': prefs.getString('semSubID')!,
  };
}

Future<Map<String, dynamic>> makeApiRequest(
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
          throw ServerUnreachableException(
              '404 Not Found', response.statusCode);
        }
        return response;
      },
      retryIf: (e) => e is ServerUnreachableException && e.statusCode == 404,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return {};
    }
  } catch (e) {
    print("Error $e");
    return {};
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
Future fetchLoginData() async {
  Map<String, String> credentials = await getCredentials();
  return makeApiRequest('login/getalldata', credentials);
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
  Map<String, dynamic> data =
      await makeApiRequest('login/timetable', credentials);

  if (data.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('timetable', json.encode(data['timetable']));
    ref.read(timetableProvider.notifier).updateTimetable(data['timetable']);
  }

  return data;
}
