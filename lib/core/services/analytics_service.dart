import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// Initialize analytics with user properties
  static Future<void> initialize() async {
    if (kDebugMode) {
      // Disable analytics in debug mode for cleaner data
      await analytics.setAnalyticsCollectionEnabled(false);
    } else {
      await analytics.setAnalyticsCollectionEnabled(true);
    }
  }

  /// Log screen views
  static Future<void> logScreen(String screenName) async {
    await analytics.logScreenView(
        screenName: screenName, screenClass: screenName);
    if (kDebugMode) {
      print('Analytics: Screen View - $screenName');
    }
  }

  /// Log custom events
  static Future<void> logEvent(String name,
      [Map<String, Object>? params]) async {
    await analytics.logEvent(name: name, parameters: params);
    if (kDebugMode) {
      print('Analytics: Event - $name with params: $params');
    }
  }

  /// Set user properties
  static Future<void> setUserProperties({
    String? userId,
    String? userType,
    String? academicYear,
    String? branch,
    String? semester,
  }) async {
    if (userId != null) {
      await analytics.setUserId(id: userId);
    }
    if (userType != null) {
      await analytics.setUserProperty(name: 'user_type', value: userType);
    }
    if (academicYear != null) {
      await analytics.setUserProperty(
          name: 'academic_year', value: academicYear);
    }
    if (branch != null) {
      await analytics.setUserProperty(name: 'branch', value: branch);
    }
    if (semester != null) {
      await analytics.setUserProperty(name: 'semester', value: semester);
    }
  }

  // User Authentication Events
  static Future<void> logLogin(String method) async {
    await analytics.logLogin(loginMethod: method);
  }

  static Future<void> logSignUp(String method) async {
    await analytics.logSignUp(signUpMethod: method);
  }

  // Navigation Events
  static Future<void> logPageView(String pageName,
      {Map<String, Object>? parameters}) async {
    await logEvent('page_view', {
      'page_name': pageName,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      ...?parameters,
    });
  }

  static Future<void> logButtonTap(String buttonName, String location) async {
    await logEvent('button_tap', {
      'button_name': buttonName,
      'location': location,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logNavigation(String from, String to) async {
    await logEvent('navigation', {
      'from_screen': from,
      'to_screen': to,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Feature Usage Events
  static Future<void> logFeatureUsed(String featureName,
      {Map<String, Object>? additionalData}) async {
    await logEvent('feature_used', {
      'feature_name': featureName,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      ...?additionalData,
    });
  }

  static Future<void> logSearch(String searchTerm, String searchType) async {
    await analytics.logSearch(searchTerm: searchTerm, parameters: {
      'search_type': searchType,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logShare(String contentType, String itemId) async {
    await analytics.logShare(
      contentType: contentType,
      itemId: itemId,
      method: 'app_share',
    );
  }

  // Academic Events
  static Future<void> logAttendanceView(String courseCode) async {
    await logEvent('attendance_viewed', {
      'course_code': courseCode,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logTimetableView(String viewType) async {
    await logEvent('timetable_viewed', {
      'view_type': viewType, // 'daily', 'weekly', etc.
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logMarksView(String examType) async {
    await logEvent('marks_viewed', {
      'exam_type': examType,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logGradeView(String semester) async {
    await logEvent('grades_viewed', {
      'semester': semester,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // System Events
  static Future<void> logDataSync(String dataType, bool success) async {
    await logEvent('data_sync', {
      'data_type': dataType,
      'success': success,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logError(String errorType, String errorMessage,
      {String? location}) async {
    await logEvent('app_error', {
      'error_type': errorType,
      'error_message': errorMessage,
      'location': location ?? 'unknown',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logPerformance(String actionName, int durationMs) async {
    await logEvent('performance_metric', {
      'action_name': actionName,
      'duration_ms': durationMs,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Settings Events
  static Future<void> logSettingChanged(
      String settingName, String newValue) async {
    await logEvent('setting_changed', {
      'setting_name': settingName,
      'new_value': newValue,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logThemeChanged(String themeMode) async {
    await logEvent('theme_changed', {
      'theme_mode': themeMode,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Notification Events
  static Future<void> logNotificationReceived(String notificationType) async {
    await logEvent('notification_received', {
      'notification_type': notificationType,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logNotificationTapped(String notificationType) async {
    await logEvent('notification_tapped', {
      'notification_type': notificationType,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // User Engagement Events
  static Future<void> logSessionEnd(int durationSeconds) async {
    await logEvent('session_end', {
      'session_duration_seconds': durationSeconds,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logTimeSpentOnScreen(
      String screenName, int durationSeconds) async {
    await logEvent('screen_time', {
      'screen_name': screenName,
      'duration_seconds': durationSeconds,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Quick Access Events
  static Future<void> logQuickAccessUsed(String feature) async {
    await logEvent('quick_access_used', {
      'feature': feature,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Payment Events
  static Future<void> logPaymentViewed() async {
    await logEvent('payment_viewed', {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logPaymentReceiptDownloaded(String paymentId) async {
    await logEvent('payment_receipt_downloaded', {
      'payment_id': paymentId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Feedback Events
  static Future<void> logFeedbackGiven(String feedbackType, int rating) async {
    await logEvent('feedback_given', {
      'feedback_type': feedbackType,
      'rating': rating,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // App Events
  static Future<void> logAppUpdate(String fromVersion, String toVersion) async {
    await logEvent('app_updated', {
      'from_version': fromVersion,
      'to_version': toVersion,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Future<void> logAppCrash(String crashReason) async {
    await logEvent('app_crash', {
      'crash_reason': crashReason,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
