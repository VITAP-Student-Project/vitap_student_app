import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/providers.dart';
import 'notification_service.dart';

Future<void> scheduleClassNotifications(WidgetRef ref) async {
  final Map<String, dynamic> timetable = ref.read(timetableProvider);

  final bool notificationsEnabled = ref.read(notificationProvider);
  final double sliderValue = ref.read(sliderProvider);

  final notificationService = NotificationService();

  // Initialize shared preferences to store the last notification ID
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int lastNotificationId = prefs.getInt('lastNotificationId') ?? 0;

  // Exit if notifications are disabled
  if (!notificationsEnabled) {
    notificationService.cancelAllNotifications();
    return;
  }

  // Cancel existing notifications before scheduling new ones
  notificationService.cancelAllNotifications();
  notificationService.initNotifications();

  final now = DateTime.now();
  final kolkata = tz.getLocation('Asia/Kolkata');

  int notificationId = lastNotificationId;

  // Helper function to get the day name (e.g., 'Monday', 'Tuesday')
  String getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return 'Monday'; // Default to Monday if unknown day
    }
  }

  // Get today's day name
  final String today = getDayName(now.weekday);

  // Check if today's classes are present in the timetable
  if (!timetable.containsKey(today)) {
    return;
  }

  final classes = timetable[today];

  for (var classData in classes) {
    final timeRange = classData.keys.first;
    final classDetails = classData[timeRange];

    final startTime = timeRange.split('-').first.trim();
    final hoursMinutes = startTime.split(':');
    final hour = int.parse(hoursMinutes[0]);
    final minute = int.parse(hoursMinutes[1]);

    final classStartTimeToday = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (now.isAfter(classStartTimeToday)) {
      // If the class has already passed today, skip it
      continue;
    }

    final notificationDuration = Duration(minutes: sliderValue.toInt());

    final classStartTime = tz.TZDateTime(
      kolkata,
      classStartTimeToday.year,
      classStartTimeToday.month,
      classStartTimeToday.day,
      hour,
      minute,
    ).subtract(notificationDuration);

    notificationService.scheduleNotification(
      id: notificationId++,
      title: "📅 Class Starting Soon",
      body:
          "Your ${classDetails['course_name']} class is about to begin in ${sliderValue.toInt()} minutes at ${classDetails['venue']}. Don’t miss out!",
      scheduledTime: classStartTime,
    );
  }

  // Save the last notification ID
  prefs.setInt('lastNotificationId', notificationId);
}
