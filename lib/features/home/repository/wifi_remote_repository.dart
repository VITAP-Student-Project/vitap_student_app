import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/features/home/model/hostel_wifi_response.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'wifi_remote_repository.g.dart';

@riverpod
WifiRemoteRepository wifiRemoteRepository(WifiRemoteRepositoryRef ref) {
  final noSslclient = serviceLocator<IOClient>();
  final httpClient = serviceLocator<http.Client>();
  return WifiRemoteRepository(noSslclient, httpClient);
}

class WifiRemoteRepository {
  final IOClient noSslclient;
  final http.Client httpClient;

  WifiRemoteRepository(this.noSslclient, this.httpClient);


  // Hostel Wifi
  Future<Either<Failure, HostelWifiResponse>> hostelWifiLogin(
    String username,
    String password, {
    int productType = 0,
  }) async {
    final data = {
      'mode': "191",
      'username': username,
      'password': password,
      'a': DateTime.now().millisecondsSinceEpoch.toString(),
      'producttype': productType.toString(),
    };

    try {
      final response = await noSslclient.post(
        Uri.parse(ServerConstants.hostelWifiBaseUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        final wifiResponse = HostelWifiResponse.fromXml(response.body);
        return Right(wifiResponse);
      } else {
        return Left(
            Failure("Login failed with status code: ${response.statusCode}"));
      }
    } on SocketException catch (_) {
      return Left(
          Failure("Please connect to the VIT-AP hostel Wi-Fi and try again."));
    } catch (e) {
      log("Error: ${e.toString()}");
      return Left(Failure("An unexpected error occurred: $e"));
    }
  }

  Future<Either<Failure, HostelWifiResponse>> hostelWifiLogout(
    String username,
    String password, {
    int productType = 0,
  }) async {
    final data = {
      'mode': "192",
      'username': username,
      'password': password,
      'a': DateTime.now().millisecondsSinceEpoch.toString(),
      'producttype': productType.toString(),
    };

    try {
      final response = await noSslclient.post(
        Uri.parse(ServerConstants.universityWifiBaseUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        final wifiResponse = HostelWifiResponse.fromXml(response.body);
        return Right(wifiResponse);
      } else {
        return Left(
            Failure("Logout failed with status code: ${response.statusCode}"));
      }
    } on SocketException catch (_) {
      return Left(
          Failure("Please connect to the VIT-AP hostel Wi-Fi and try again."));
    } catch (e) {
      log("Error: ${e.toString()}");
      return Left(Failure("An unexpected error occurred: $e"));
    }
  }

  // University Wifi

  Future<Map<String, String?>> getUniversityWifiPortalParameters() async {
    try {
      final client = http.Client();
      try {
        final response = await client.get(
          Uri.parse(
              '${ServerConstants.universityWifiBaseUrl}/login?redir=https%3A%2F%2F172.18.10.10%3A8443%2F'),
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


          return {
            'magic': magic,
            '4Tredir': fourTredir,
          };
        } else {
          return {};
        }
      } finally {
        client.close();
      }
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> universityWifilogin({
    required String username,
    required String password,
    required String magic,
    required String fourTredir,
  }) async {
    final client = http.Client();
    try {
      // Extract the base URL without query parameters for the POST request
      final uri = Uri.parse(
          '${ServerConstants.universityWifiBaseUrl}/login?redir=https%3A%2F%2F172.18.10.10%3A8443%2F');
      final loginUrl = '${uri.scheme}://${uri.host}:${uri.port}';

      final response = await client.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          'User-Agent': 'Mozilla/5.0',
          'Origin': loginUrl,
          'Referer':
              '${ServerConstants.hostelWifiBaseUrl}/login?redir=https%3A%2F%2F172.18.10.10%3A8443%2F',
        },
        body: {
          '4Tredir': fourTredir,
          'magic': magic,
          'username': username,
          'password': password,
        },
      ).timeout(Duration(seconds: 10));


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
      return {
        'success': false,
        'error': 'Authentication request failed: $e',
      };
    } finally {
      client.close();
    }
  }
}
