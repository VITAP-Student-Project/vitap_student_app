import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> logScreen(String screenName) async {
    await analytics.logScreenView(
        screenName: screenName, screenClass: screenName);
  }

  static Future<void> logEvent(String name,
      [Map<String, Object>? params]) async {
    await analytics.logEvent(name: name, parameters: params);
  }
}
