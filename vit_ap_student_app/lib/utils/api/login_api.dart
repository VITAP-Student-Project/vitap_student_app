// login_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> fetchLoginData(String username, String password, String semSubID) async {
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/getalldata');
    Map placeholder = {'username': username, 'password': password,'semSubID':semSubID};
    http.Response response = await http.post(url, body: placeholder);
    print('Response status: ${response.statusCode}');
    dynamic data = response.body;
    print(data);
    return response.statusCode;
  } catch (e) {
    print("Error $e");
    return 500; // Return an error status code if there's an exception
  }
}
