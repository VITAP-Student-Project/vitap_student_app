import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import '../exceptions/ServerUnreachableException.dart';

Future fetchLoginData(String username, String password, String semSubID) async {
  const r = RetryOptions(maxAttempts: 5);
  try {
    Uri url = Uri.parse('https://vit-ap.fly.dev/login/getalldata');
    Map<String, String> placeholder = {
      'username': username,
      'password': password,
      'semSubID': semSubID
    };
    final response = await r.retry(
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

    print('Response status: ${response.statusCode}');
    return response;
  } catch (e) {
    print("Error $e");
    return 500; // Return an error status code if there's an exception
  }
}
