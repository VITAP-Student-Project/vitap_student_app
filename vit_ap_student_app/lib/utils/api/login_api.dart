import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future fetchLoginData(String username, String password, String semSubID) async {
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/getalldata');
    Map placeholder = {
      'username': username,
      'password': password,
      'semSubID': semSubID
    };
    http.Response response = await http.post(
      url,
      body: placeholder,
      headers: {"API-KEY": dotenv.env['API_KEY']!},
    );
    print('Response status: ${response.statusCode}');
    return response;
  } catch (e) {
    print("Error $e");
    return 500; // Return an error status code if there's an exception
  }
}
