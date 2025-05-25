import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import '../../../models/wifi_response_model.dart';

class HostelWifiService {
  static const String url = "https://hfw.vitap.ac.in:8090/httpclient.html";
  static const int loginMode = 191;
  static const int logoutMode = 193;

  static Future<WifiResponse> login(String username, String password,
      {int productType = 0}) async {
    final data = {
      'mode': loginMode.toString(),
      'username': username,
      'password': password,
      'a': DateTime.now().millisecondsSinceEpoch.toString(),
      'producttype': productType.toString(),
    };

    try {
      // Use a custom HttpClient to bypass SSL validation
      final client = _getBypassClient();
      final response = await client.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        return WifiResponse.fromXml(response.body);
      } else {
        return WifiResponse(
          message: "Login failed with status code: ${response.statusCode}",
          color: Colors.red.shade400,
        );
      }
    } on SocketException catch (_) {
      return WifiResponse(
        message: "Please connect to the VIT-AP hostel Wi-Fi and try again.",
        color: Colors.red.shade400,
      );
    } catch (e) {
      return WifiResponse(
        message: "An unexpected error occurred: $e",
        color: Colors.red.shade400,
      );
    }
  }

  static Future<WifiResponse> logout(String username, String password,
      {int productType = 0}) async {
    final data = {
      'mode': logoutMode.toString(),
      'username': username,
      'password': password,
      'a': DateTime.now().millisecondsSinceEpoch.toString(),
      'producttype': productType.toString(),
    };

    try {
      // Use a custom HttpClient to bypass SSL validation
      final client = _getBypassClient();
      final response = await client.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        return WifiResponse.fromXml(response.body);
      } else {
        return WifiResponse(
          message: "Logout failed with status code: ${response.statusCode}",
          color: Colors.red.shade400,
        );
      }
    } on SocketException catch (_) {
      return WifiResponse(
        message: "Please connect to the VIT-AP hostel Wi-Fi and try again.",
        color: Colors.red.shade400,
      );
    } catch (e) {
      return WifiResponse(
        message: "An unexpected error occurred: $e",
        color: Colors.red.shade400,
      );
    }
  }

  // Helper function to create an HttpClient that bypasses SSL verification
  static IOClient _getBypassClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // Always trust certificates
    return IOClient(httpClient);
  }
}
