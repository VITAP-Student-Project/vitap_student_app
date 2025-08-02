import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/model/hostel_wifi_response.dart';
import 'package:vit_ap_student_app/features/home/model/wifi_response.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/wifi.dart';
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
      debugPrint("Error: ${e.toString()}");
      return Left(Failure("An unexpected error occurred: $e"));
    }
  }

  Future<Either<Failure, HostelWifiResponse>> hostelWifiLogout(
    String username,
    String password, {
    int productType = 0,
  }) async {
    final data = {
      'mode': "193",
      'username': username,
      'a': DateTime.now().millisecondsSinceEpoch.toString(),
      'producttype': productType.toString(),
    };

    try {
      final response = await noSslclient.post(
        Uri.parse(ServerConstants.hostelWifiBaseUrl),
        body: data,
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final wifiResponse = HostelWifiResponse.fromXml(response.body);
        debugPrint(wifiResponse.message);
        return Right(wifiResponse);
      } else {
        return Left(
            Failure("Logout failed with status code: ${response.statusCode}"));
      }
    } on SocketException catch (_) {
      return Left(
          Failure("Please connect to the VIT-AP hostel Wi-Fi and try again."));
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return Left(Failure("An unexpected error occurred: $e"));
    }
  }

  // University Wifi using Rust bindings
  Future<Either<Failure, WifiResponse>> universityWifiLogin(
    String username,
    String password,
  ) async {
    try {
      final (success, message) = await universityWifiLoginLogout(
        i: 0, // 0 for login
        username: username,
        password: password,
      );

      final wifiResponse =
          WifiResponse.fromUniversityRust(success, message, true);
      return Right(wifiResponse);
    } on SocketException catch (_) {
      return Left(Failure(
          "Please connect to the VIT-AP university Wi-Fi and try again."));
    } catch (e) {
      debugPrint("University WiFi Login Error: ${e.toString()}");
      return Left(Failure("University Wi-Fi login failed: $e"));
    }
  }

  Future<Either<Failure, WifiResponse>> universityWifiLogout(
    String username,
    String password,
  ) async {
    try {
      final (success, message) = await universityWifiLoginLogout(
        i: 1, // 1 for logout
        username: username,
        password: password,
      );

      final wifiResponse =
          WifiResponse.fromUniversityRust(success, message, false);
      return Right(wifiResponse);
    } on SocketException catch (_) {
      return Left(Failure(
          "Please connect to the VIT-AP university Wi-Fi and try again."));
    } catch (e) {
      debugPrint("University WiFi Logout Error: ${e.toString()}");
      return Left(Failure("University Wi-Fi logout failed: $e"));
    }
  }

  // Unified WiFi login that tries hostel first, then university
  Future<Either<Failure, WifiResponse>> unifiedWifiLogin(
    String username,
    String password,
  ) async {
    // Try hostel WiFi first (fast fail on local network)
    try {
      final hostelResult = await hostelWifiLogin(username, password);

      if (hostelResult case Right(value: final hostelResponse)) {
        // Convert HostelWifiResponse to WifiResponse
        return Right(WifiResponse(
          message: hostelResponse.message,
          snackBarType: hostelResponse.snackBarType,
          wifiType: WifiType.hostel,
          success: hostelResponse.snackBarType == SnackBarType.success,
        ));
      }
    } catch (e) {
      debugPrint("Hostel WiFi failed, trying university WiFi: $e");
    }

    // If hostel fails, try university WiFi
    try {
      final universityResult = await universityWifiLogin(username, password);
      return universityResult;
    } catch (e) {
      debugPrint("University WiFi also failed: $e");
      return Left(Failure(
          "Both hostel and university Wi-Fi login failed. Please check your connection and credentials."));
    }
  }

  // Unified WiFi logout that tries both but returns immediately on first success
  Future<Either<Failure, WifiResponse>> unifiedWifiLogout(
    String username,
    String password,
  ) async {
    String lastErrorMessage = "";

    // Try hostel WiFi logout first (with timeout)
    try {
      final hostelResult = await hostelWifiLogout(username, password)
          .timeout(const Duration(seconds: 10));

      if (hostelResult case Right(value: final hostelResponse)) {
        if (hostelResponse.snackBarType == SnackBarType.success) {
          // Return immediately on successful hostel logout
          return Right(WifiResponse(
            message: hostelResponse.message,
            snackBarType: SnackBarType.success,
            wifiType: WifiType.hostel,
            success: true,
          ));
        }
      }
    } catch (e) {
      lastErrorMessage = "Hostel logout failed: $e";
      debugPrint(lastErrorMessage);
    }

    // Only try university WiFi logout if hostel logout failed
    try {
      final universityResult = await universityWifiLogout(username, password)
          .timeout(const Duration(seconds: 10));

      if (universityResult case Right(value: final universityResponse)) {
        if (universityResponse.success) {
          return Right(WifiResponse(
            message: universityResponse.message,
            snackBarType: SnackBarType.success,
            wifiType: WifiType.university,
            success: true,
          ));
        }
      }
    } catch (e) {
      lastErrorMessage = "University logout failed: $e";
      debugPrint(lastErrorMessage);
    }

    // If both failed
    return Left(Failure("Logout failed for both networks. $lastErrorMessage"));
  }

  // Legacy methods below (keep for backward compatibility)

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
