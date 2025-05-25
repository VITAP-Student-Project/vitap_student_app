import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class FortigatePortalAuth {
  FortigatePortalAuth();

  Future<Map<String, String?>> getPortalParameters() async {
    try {
      final client = http.Client();
      try {
        final response = await client.get(
          Uri.parse(
              'http://172.18.10.10:1000/login?redir=https%3A%2F%2F172.18.10.10%3A8443%2F'),
          headers: {
            'Accept':
                'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'User-Agent': 'Mozilla/5.0',
            'Accept-Language': 'en-US,en;q=0.5',
          },
        ).timeout(Duration(seconds: 10));

        if (response.statusCode == 200) {
          final document = parser.parse(response.body);

          // Find the hidden input fields
          final fourTredirInput =
              document.querySelector('input[name="4Tredir"]');
          final magicInput = document.querySelector('input[name="magic"]');

          final fourTredir = fourTredirInput?.attributes['value'];
          final magic = magicInput?.attributes['value'];

          print('Found 4Tredir: $fourTredir');
          print('Found magic: $magic');

          return {
            'magic': magic,
            '4Tredir': fourTredir,
          };
        } else {
          print('Unexpected status code: ${response.statusCode}');
          return {};
        }
      } finally {
        client.close();
      }
    } catch (e) {
      print('Error getting portal parameters: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required String magic,
    required String fourTredir,
  }) async {
    final client = http.Client();
    try {
      // Extract the base URL without query parameters for the POST request
      final uri = Uri.parse(
          'http://172.18.10.10:1000/login?redir=https%3A%2F%2F172.18.10.10%3A8443%2F');
      final loginUrl = '${uri.scheme}://${uri.host}:${uri.port}';

      print('Sending login request to: $loginUrl');
      final response = await client.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          'User-Agent': 'Mozilla/5.0',
          'Origin': loginUrl,
          'Referer':
              'http://172.18.10.10:1000/login?redir=https%3A%2F%2F172.18.10.10%3A8443%2F',
        },
        body: {
          '4Tredir': fourTredir,
          'magic': magic,
          'username': username,
          'password': password,
        },
      ).timeout(Duration(seconds: 10));

      print('Login response status: ${response.statusCode}');
      print("Res Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 302) {
        final location = response.headers['location'];
        if (location != null) {
          return {
            'success': true,
            'redirect': location,
          };
        }

        if (response.body.toLowerCase().contains('concurrent authentication')) {
          return {
            'success': false,
            'error': 'Concurrent user limit reached',
          };
        }

        if (response.body.toLowerCase().contains('authentication failed')) {
          return {
            'success': false,
            'error': 'Authentication failed due to unknown reason',
          };
        }

        if (response.body.toLowerCase().contains('invalid credentials')) {
          return {
            'success': false,
            'error': 'Invalid credentials',
          };
        }

        return {
          'success': true,
          'data': response.body,
        };
      } else {
        return {
          'success': false,
          'error':
              'Authentication failed with status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Login error: $e');
      return {
        'success': false,
        'error': 'Authentication request failed: $e',
      };
    } finally {
      client.close();
    }
  }

  // Helper method to create a login URL with redirect
  static String createLoginUrl(String baseIp, int port, String redirectUrl) {
    final encodedRedirect = Uri.encodeComponent(redirectUrl);
    return 'http://$baseIp:$port/login?redir=$encodedRedirect';
  }
}
