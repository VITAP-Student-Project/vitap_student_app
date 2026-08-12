import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:vit_ap_student_app/features/connect/data/repositories/supabase_repository.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

class PushNotificationService {
  static final _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    try {
      // 1. Request permission
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        
        // 2. Set foreground presentation options to FALSE for alert/badge
        // as requested by the user (hide default dropdown banner if app is open)
        await _messaging.setForegroundNotificationPresentationOptions(
          alert: false, // Don't show banner if app is open
          badge: false, // Don't badge icon (handled by our red dot)
          sound: false,
        );

        // 3. Get the FCM Token
        final token = await _messaging.getToken();
        if (token != null) {
          await _saveTokenToDatabase(token);
        }

        // 4. Listen for token refreshes
        _messaging.onTokenRefresh.listen((newToken) {
          _saveTokenToDatabase(newToken);
        });

      }
    } catch (e) {
      debugPrint('FCM Initialization Error: $e');
    }
  }

  static Future<void> _saveTokenToDatabase(String token) async {
    try {
      final repository = serviceLocator<SupabaseRepository>();
      await repository.updateFcmToken(token);
    } catch (e) {
      debugPrint('Error saving FCM token: $e');
    }
  }
}
