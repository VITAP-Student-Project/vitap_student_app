import 'dart:io' show Platform;

class ServerConstants {
  static String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';

  // static const String hostUrl = "prod.velvizhiconstruction.site";

  // API Configuration
  static const int apiTimeout = 10000; // milliseconds
  static const int maxRetryAttempts = 3;
}
