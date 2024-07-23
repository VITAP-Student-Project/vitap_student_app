import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchPaymentDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? applno =
      jsonDecode(prefs.getString('profile')!)['application_number'];
  String? _username = prefs.getString('username')!;
  String? _password = prefs.getString('password')!;
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/payments');
    Map placeholder = {
      'username': _username,
      'password': _password,
      'applno': applno
    };
    http.Response response = await http.post(
      url,
      body: placeholder,
      headers: {"API-KEY": dotenv.env['API_KEY']!},
    );
    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["payments"];
    await prefs.setString('payments', jsonEncode(data));
  } catch (e) {
    print("Error $e"); // Return an error status code if there's an exception
  }
}
