import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'schedule_class_notification.dart';

class NotificationManager {
  static DateTime? _lastRefreshTime;
  static Timer? _refreshTimer;
  static bool _isRefreshInitialized = false;

  static Future<void> initialize(WidgetRef ref) async {
    if (_isRefreshInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    _lastRefreshTime = DateTime.fromMillisecondsSinceEpoch(
        prefs.getInt('lastNotificationRefresh') ?? 0);

    // Check if we need to refresh notifications
    if (_shouldRefreshNotifications()) {
      await refreshWeeklyNotifications();
      await _updateLastRefreshTime();
    }

    // Set up periodic refresh
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(Duration(days: 6), (_) async {
      await refreshWeeklyNotifications();
      await _updateLastRefreshTime();
    });

    _isRefreshInitialized = true;
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
    await refreshWeeklyNotifications();
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
