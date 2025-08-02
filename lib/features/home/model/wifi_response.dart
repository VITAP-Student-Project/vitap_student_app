import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';

enum WifiType { hostel, university }

class WifiResponse {
  final String message;
  final SnackBarType snackBarType;
  final WifiType wifiType;
  final bool success;

  WifiResponse({
    required this.message,
    required this.snackBarType,
    required this.wifiType,
    required this.success,
  });

  factory WifiResponse.fromHostelXml(String xml) {
    final regex =
        RegExp(r'<message>(.*?)<\/message>').firstMatch(xml)?.group(1) ??
            "An unexpected error occurred";
    final signedInRegex = RegExp(r'<!\[CDATA\[You are signed in as .*?\]\]>');
    final signedOutRegex = RegExp(r'<!\[CDATA\[You&#39;ve signed out\]\]>');
    final loginFailedRegex = RegExp(
        r'<!\[CDATA\[Login failed\. Invalid user name/password\. Please contact the administrator\. ]]');

    if (signedInRegex.hasMatch(xml)) {
      return WifiResponse(
        message: "You are signed in to Hostel Wi-Fi!",
        snackBarType: SnackBarType.success,
        wifiType: WifiType.hostel,
        success: true,
      );
    } else if (signedOutRegex.hasMatch(xml)) {
      return WifiResponse(
        message: "You have signed out from Hostel Wi-Fi.",
        snackBarType: SnackBarType.success,
        wifiType: WifiType.hostel,
        success: true,
      );
    } else if (loginFailedRegex.hasMatch(xml)) {
      return WifiResponse(
        message: "Hostel Wi-Fi login failed. Invalid username/password.",
        snackBarType: SnackBarType.error,
        wifiType: WifiType.hostel,
        success: false,
      );
    } else {
      return WifiResponse(
        message: "Hostel Wi-Fi: An unexpected error occurred. $regex",
        snackBarType: SnackBarType.error,
        wifiType: WifiType.hostel,
        success: false,
      );
    }
  }

  factory WifiResponse.fromUniversityRust(
      bool success, String message, bool isLogin) {
    if (success) {
      return WifiResponse(
        message: isLogin
            ? "You are signed in to University Wi-Fi!"
            : "You have signed out from University Wi-Fi.",
        snackBarType: SnackBarType.success,
        wifiType: WifiType.university,
        success: true,
      );
    } else {
      // Handle specific error cases
      String errorMessage = message;
      if (message.contains("NE")) {
        errorMessage = "Network error. Please check your connection.";
      } else if (message.contains("NL")) {
        errorMessage = "Not logged in to University Wi-Fi.";
      } else if (message.isEmpty) {
        errorMessage = "University Wi-Fi authentication failed.";
      } else {
        errorMessage = "University Wi-Fi: $message";
      }

      return WifiResponse(
        message: errorMessage,
        snackBarType: SnackBarType.error,
        wifiType: WifiType.university,
        success: false,
      );
    }
  }

  factory WifiResponse.networkError() {
    return WifiResponse(
      message: "Please connect to VIT-AP campus Wi-Fi and try again.",
      snackBarType: SnackBarType.error,
      wifiType: WifiType.hostel, // Default to hostel
      success: false,
    );
  }

  factory WifiResponse.credentialsError() {
    return WifiResponse(
      message: "Please enter your Wi-Fi username and password.",
      snackBarType: SnackBarType.error,
      wifiType: WifiType.hostel, // Default to hostel
      success: false,
    );
  }
}
