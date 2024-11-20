import 'package:flutter/material.dart';

class WifiResponse {
  final String message;
  Color color;

  WifiResponse({required this.message, this.color = Colors.white});

  factory WifiResponse.fromXml(String xml) {
    final regex =
        RegExp(r'<message>(.*?)<\/message>').firstMatch(xml)?.group(1) ??
            "An unexpected error occurred";
    final signedInRegex = RegExp(r'<!\[CDATA\[You are signed in as .*?\]\]>');
    final signedOutRegex = RegExp(r'<!\[CDATA\[You&#39;ve signed out\]\]>');
    final loginFailedRegex = RegExp(
        r'<!\[CDATA\[Login failed\. Invalid user name/password\. Please contact the administrator\. ]]');

    if (signedInRegex.hasMatch(xml)) {
      return WifiResponse(
        message: "You are signed in!",
        color: Colors.green.shade300,
      );
    } else if (signedOutRegex.hasMatch(xml)) {
      return WifiResponse(
        message: "You have signed out.",
        color: Colors.green.shade300,
      );
    } else if (loginFailedRegex.hasMatch(xml)) {
      return WifiResponse(
        message: "Login failed. Invalid username/password.",
        color: Colors.red.shade400,
      );
    } else {
      return WifiResponse(
        message: "An unexpected error occurred. $regex",
        color: Colors.red.shade400,
      );
    }
  }
}
