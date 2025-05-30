import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';

class HostelWifiResponse {
  final String message;
  final SnackBarType snackBarType;

  HostelWifiResponse({required this.message, required this.snackBarType});

  factory HostelWifiResponse.fromXml(String xml) {
    final regex =
        RegExp(r'<message>(.*?)<\/message>').firstMatch(xml)?.group(1) ??
            "An unexpected error occurred";
    final signedInRegex = RegExp(r'<!\[CDATA\[You are signed in as .*?\]\]>');
    final signedOutRegex = RegExp(r'<!\[CDATA\[You&#39;ve signed out\]\]>');
    final loginFailedRegex = RegExp(
        r'<!\[CDATA\[Login failed\. Invalid user name/password\. Please contact the administrator\. ]]');

    if (signedInRegex.hasMatch(xml)) {
      return HostelWifiResponse(
        message: "You are signed in!",
        snackBarType: SnackBarType.success,
      );
    } else if (signedOutRegex.hasMatch(xml)) {
      return HostelWifiResponse(
        message: "You have signed out.",
        snackBarType: SnackBarType.success,
      );
    } else if (loginFailedRegex.hasMatch(xml)) {
      return HostelWifiResponse(
        message: "Login failed. Invalid username/password.",
        snackBarType: SnackBarType.error,
      );
    } else {
      return HostelWifiResponse(
        message: "An unexpected error occurred. $regex",
        snackBarType: SnackBarType.error,
      );
    }
  }
}
