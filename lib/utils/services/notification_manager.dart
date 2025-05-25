import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/notification_utils_provider.dart';
import 'class_notification_service.dart';
import 'schedule_class_notification.dart';

class NotificationManager {
  static DateTime? _lastRefreshTime;
  static Timer? _refreshTimer;
  static bool _isRefreshInitialized = false;
  NotificationService notificationService = NotificationService();

  Future<void> initialize(WidgetRef ref) async {
    if (_isRefreshInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    _lastRefreshTime = DateTime.fromMillisecondsSinceEpoch(
        prefs.getInt('lastNotificationRefresh') ?? 0);

    // Check if we need to refresh notifications
    if (_shouldRefreshNotifications()) {
      await refreshWeeklyNotifications(ref);
      await _updateLastRefreshTime();
    }

    // Set up periodic refresh
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(Duration(days: 6), (_) async {
      await refreshWeeklyNotifications(ref);
      await _updateLastRefreshTime();
    });

    // Set up listeners for the Riverpod providers
    _listenToNotificationSettings(ref);

    _isRefreshInitialized = true;
  }

  void _listenToNotificationSettings(WidgetRef ref) {
    // Listen to notificationsEnabled provider
    ref.listen<bool>(classNotificationProvider, (previous, current) async {
      if (!current) {
        // Cancel all notifications when notifications are disabled
        notificationService.cancelAllNotifications();
      } else {
        // Reschedule notifications if they were re-enabled
        await refreshWeeklyNotifications(ref);
        await _updateLastRefreshTime();
      }
    });

    // Listen to sliderValue provider
    ref.listen<double>(classNotificationSliderProvider,
        (previous, current) async {
      // Cancel all notifications and reschedule with the new slider value
      notificationService.cancelAllNotifications();
    });
  }

  static bool _shouldRefreshNotifications() {
    if (_lastRefreshTime == null) return true;
    final timeSinceLastRefresh = DateTime.now().difference(_lastRefreshTime!);
    return timeSinceLastRefresh.inHours >= 24;
  }

  static Future<void> _updateLastRefreshTime() async {
    _lastRefreshTime = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'lastNotificationRefresh', _lastRefreshTime!.millisecondsSinceEpoch);
  }

  static Future<void> forceRefresh(WidgetRef ref) async {
    await refreshWeeklyNotifications(ref);
    await _updateLastRefreshTime();
  }

  static Future<void> checkAndRefreshIfNeeded(WidgetRef ref) async {
    if (_shouldRefreshNotifications()) {
      await forceRefresh(ref);
    }
  }

  static void dispose() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }
}
