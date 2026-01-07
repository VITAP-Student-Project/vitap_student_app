import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/model/wifi_response.dart';

part 'wifi_remote_repository.g.dart';

@riverpod
WifiRemoteRepository wifiRemoteRepository(WifiRemoteRepositoryRef ref) {
  return WifiRemoteRepository();
}

class WifiRemoteRepository {
  WifiRemoteRepository();

  Future<Either<Failure, WifiResponse>> universityWifiLogin(
    String username,
    String password,
  ) async {
    try {
      final client = http.Client();
      try {
        // Step 1: Get the login page to extract magic token
        final loginPageResponse = await client
            .get(Uri.parse('${ServerConstants.universityWifiBaseUrl}/login?'))
            .timeout(const Duration(seconds: 10));

        if (loginPageResponse.statusCode != 200) {
          return Right(WifiResponse(
            message:
                "Failed to reach WiFi portal. Status: ${loginPageResponse.statusCode}",
            snackBarType: SnackBarType.error,
            success: false,
          ));
        }

        // Step 2: Parse the magic token from the login page
        final magicToken = _parseMagicToken(loginPageResponse.body);
        if (magicToken == null) {
          // If no magic token, user might already be logged in
          return Right(WifiResponse(
            message: "Already logged in or portal not available.",
            snackBarType: SnackBarType.warning,
            success: true,
          ));
        }

        // Step 3: Submit login credentials
        final loginBody =
            'magic=$magicToken&username=$username&password=$password';
        final loginResponse = await client
            .post(
              Uri.parse('${ServerConstants.universityWifiBaseUrl}/?'),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'},
              body: loginBody,
            )
            .timeout(const Duration(seconds: 10));

        // Step 4: Check for error message in response
        final errorMessage = _extractTextFromTag(loginResponse.body, 'p');
        if (errorMessage != null && errorMessage.isNotEmpty) {
          return Right(WifiResponse(
            message: errorMessage,
            snackBarType: SnackBarType.error,
            success: false,
          ));
        }

        // Step 5: Verify login by checking keepalive page
        final keepaliveResponse = await client
            .get(Uri.parse(
                '${ServerConstants.universityWifiBaseUrl}/keepalive?'))
            .timeout(const Duration(seconds: 10));

        final successMessage =
            _extractTextFromTag(keepaliveResponse.body, 'h1');
        if (successMessage != null && successMessage.isNotEmpty) {
          return Right(WifiResponse(
            message: "You are signed in to University Wi-Fi!",
            snackBarType: SnackBarType.success,
            success: true,
          ));
        }

        return Right(WifiResponse(
          message: "Login completed.",
          snackBarType: SnackBarType.success,
          success: true,
        ));
      } finally {
        client.close();
      }
    } on SocketException catch (_) {
      return Left(
          Failure("Please connect to VIT-AP University Wi-Fi and try again."));
    } on http.ClientException catch (_) {
      return Left(
          Failure("Network error. Please check your Wi-Fi connection."));
    } catch (e) {
      debugPrint("University WiFi Login Error: ${e.toString()}");
      return Left(Failure("University Wi-Fi login failed: ${e.toString()}"));
    }
  }

  Future<Either<Failure, WifiResponse>> universityWifiLogout(
    String username,
    String password,
  ) async {
    try {
      final client = http.Client();
      try {
        final logoutResponse = await client
            .get(Uri.parse('${ServerConstants.universityWifiBaseUrl}/logout?'))
            .timeout(const Duration(seconds: 10));

        final logoutMessage = _extractTextFromTag(logoutResponse.body, 'H3');
        if (logoutMessage != null && logoutMessage.isNotEmpty) {
          return Right(WifiResponse(
            message: "You have signed out from University Wi-Fi.",
            snackBarType: SnackBarType.success,
            success: true,
          ));
        }

        return Right(WifiResponse(
          message: "Not logged in to University Wi-Fi.",
          snackBarType: SnackBarType.error,
          success: false,
        ));
      } finally {
        client.close();
      }
    } on SocketException catch (_) {
      return Left(
          Failure("Please connect to VIT-AP University Wi-Fi and try again."));
    } on http.ClientException catch (_) {
      return Left(
          Failure("Network error. Please check your Wi-Fi connection."));
    } catch (e) {
      debugPrint("University WiFi Logout Error: ${e.toString()}");
      return Left(Failure("University Wi-Fi logout failed: ${e.toString()}"));
    }
  }

  /// Parses the magic token from the login page HTML
  String? _parseMagicToken(String html) {
    try {
      final document = parser.parse(html);
      final magicInput =
          document.querySelector('input[type="hidden"][name="magic"]');
      return magicInput?.attributes['value'];
    } catch (e) {
      debugPrint("Error parsing magic token: $e");
      return null;
    }
  }

  /// Extracts text content from a specific HTML tag
  String? _extractTextFromTag(String html, String tagName) {
    try {
      final document = parser.parse(html);
      final element = document.querySelector(tagName);
      return element?.text.trim();
    } catch (e) {
      debugPrint("Error extracting text from tag $tagName: $e");
      return null;
    }
  }
}
