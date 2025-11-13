import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';

class HostelWifiResponse {
  final String message;
  final SnackBarType snackBarType;

  HostelWifiResponse({required this.message, required this.snackBarType});

  factory HostelWifiResponse.fromXml(String xml) {
    // Extract the raw message content
    final messageContent =
        RegExp(r'<message>(.*?)<\/message>').firstMatch(xml)?.group(1) ??
            "An unexpected error occurred";

    // Extract text from CDATA if present
    final cdataMatch =
        RegExp(r'<!\[CDATA\[(.*?)\]\]>').firstMatch(messageContent);
    final cleanMessage = cdataMatch?.group(1) ?? messageContent;

    // Check for different response types using the clean message
    final signedInRegex = RegExp(r'You are signed in as', caseSensitive: false);
    final signedOutRegex =
        RegExp(r'You.{0,10}signed out', caseSensitive: false);
    final loginFailedInvalidRegex = RegExp(
        r'Login failed.*Invalid user name/password',
        caseSensitive: false);
    final loginLimitReachedRegex =
        RegExp(r'Login failed.*Limit Reached', caseSensitive: false);

    if (signedInRegex.hasMatch(cleanMessage)) {
      return HostelWifiResponse(
        message: "You are signed in!",
        snackBarType: SnackBarType.success,
      );
    } else if (signedOutRegex.hasMatch(cleanMessage)) {
      return HostelWifiResponse(
        message: "You have signed out.",
        snackBarType: SnackBarType.success,
      );
    } else if (loginLimitReachedRegex.hasMatch(cleanMessage)) {
      return HostelWifiResponse(
        message:
            "Login failed. Limit Reached. Please try after 15-20 Min. (or) Signout from other device.",
        snackBarType: SnackBarType.error,
      );
    } else if (loginFailedInvalidRegex.hasMatch(cleanMessage)) {
      return HostelWifiResponse(
        message: "Login failed. Invalid username/password.",
        snackBarType: SnackBarType.error,
      );
    } else {
      return HostelWifiResponse(
        message: "An unexpected error occurred. $cleanMessage",
        snackBarType: SnackBarType.error,
      );
    }
  }
}
