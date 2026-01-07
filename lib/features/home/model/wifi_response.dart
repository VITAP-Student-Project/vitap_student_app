import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';

class WifiResponse {
  final String message;
  final SnackBarType snackBarType;
  final bool success;

  WifiResponse({
    required this.message,
    required this.snackBarType,
    required this.success,
  });

  factory WifiResponse.fromUniversityRust(
      bool success, String message, bool isLogin) {
    if (success) {
      return WifiResponse(
        message: isLogin
            ? "You are signed in to University Wi-Fi!"
            : "You have signed out from University Wi-Fi.",
        snackBarType: SnackBarType.success,
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
        success: false,
      );
    }
  }

  factory WifiResponse.networkError() {
    return WifiResponse(
      message: "Please connect to VIT-AP campus Wi-Fi and try again.",
      snackBarType: SnackBarType.error,
      success: false,
    );
  }

  factory WifiResponse.credentialsError() {
    return WifiResponse(
      message: "Please enter your Wi-Fi username and password.",
      snackBarType: SnackBarType.error,
      success: false,
    );
  }
}
