import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class UniversityWifi {
  final String baseUrl;
  final String initialMagic;
  late final http.Client _client;

  UniversityWifi({
    required this.baseUrl,
    required this.initialMagic,
  }) {
    _client = http.Client();
    // Override the default HttpClient to accept invalid certificates
    HttpOverrides.global = _MyHttpOverrides();
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      // Step 1: Get the login page with initial magic token
      final loginPageUrl = '$baseUrl?magic=$initialMagic';
      final loginPageResponse = await _client.get(
        Uri.parse(loginPageUrl),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.5',
          'Connection': 'keep-alive',
        },
      );

      if (loginPageResponse.statusCode != 200) {
        log('Failed to get login page: ${loginPageResponse.statusCode}');
        return false;
      }

      // Step 2: Parse the HTML to get hidden fields
      final document = parser.parse(loginPageResponse.body);
      final hiddenInputs = document.querySelectorAll('input[type="hidden"]');

      // Create form data including hidden fields
      final formData = <String, String>{
        'username': username,
        'password': password,
      };

      // Add all hidden fields to form data
      for (var input in hiddenInputs) {
        final name = input.attributes['name'];
        final value = input.attributes['value'];
        if (name != null) {
          formData[name] = value ?? '';
        }
      }

      // Step 3: Submit login form
      final loginResponse = await _client.post(
        Uri.parse(baseUrl),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.5',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
        },
        body: formData,
      );

      // Step 4: Check login result
      final isSuccess = _checkLoginSuccess(loginResponse);

      log(isSuccess ? 'Login successful!' : 'Login failed.');
      return isSuccess;
    } catch (e) {
      log('Error during login: $e');
      return false;
    }
  }

  bool _checkLoginSuccess(http.Response response) {
    if (response.statusCode == 200) {
      final body = response.body.toLowerCase();
      return body.contains('success') || body.contains('welcome');
    }
    return false;
  }
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}
