import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:vit_ap_student_app/core/models/timetable.dart' as td;
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/models/user_preferences.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('app_icon');
    const ios = DarwinInitializationSettings();
    await _notifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  static Future<void> scheduleTimetableNotifications({
    required User user,
    required UserPreferences prefs,
    required Ref ref,
  }) async {
    if (!prefs.isTimetableNotificationsEnabled) return;

    await _cancelTimetableNotifications();

    final timetable = user.timetable.target;
    if (timetable == null) return;

    final days = [
      timetable.monday,
      timetable.tuesday,
      timetable.wednesday,
      timetable.thursday,
      timetable.friday,
      timetable.saturday,
      timetable.sunday
    ];

    for (var i = 0; i < days.length; i++) {
      final daySlots = days[i];
      for (var slot in daySlots) {
        if (slot.courseTime != null && slot.courseName != null) {
          await _scheduleClassNotification(
            slot: slot,
            weekday: i + 1,
            delayMinutes: prefs.timetableNotificationDelay,
            ref: ref,
          );
        }
      }
    }
  }

  static Future<void> _scheduleClassNotification({
    required td.Day slot,
    required int weekday,
    required int delayMinutes,
    required Ref ref,
  }) async {
    final startTime = _parseTime(slot.courseTime!);
    if (startTime == null) return;

    final notificationTime = _calculateNotificationTime(
      weekday: weekday,
      time: startTime,
      delayMinutes: delayMinutes,
    );

    final androidDetails = const AndroidNotificationDetails(
      'timetable_reminders',
      'Class Reminders',
      importance: Importance.high,
    );

    await _notifications.zonedSchedule(
      slot.hashCode,
      '📅 Class Starting Soon',
      'Your ${slot.courseName} class is about to begin at ${slot.venue} in ${slot.courseTime} minutes. Don\'t miss out!',
      notificationTime,
      NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static tz.TZDateTime _calculateNotificationTime({
    required int weekday,
    required TimeOfDay time,
    required int delayMinutes,
  }) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + (weekday - now.weekday) % 7,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate.subtract(Duration(minutes: delayMinutes));
  }

  static TimeOfDay? _parseTime(String timeStr) {
    try {
      // Handle formats like: "9:00 AM - 10:00 AM" or "14:00 - 15:00"
      final timePart = timeStr.split(' - ')[0].trim();
      final components = timePart.split(RegExp(r'[\s:]'));
      var hour = int.parse(components[0]);
      final minute = int.parse(components[1]);

      // Handle PM times
      if (components.length > 2 &&
          components[2].toLowerCase() == 'pm' &&
          hour < 12) {
        hour += 12;
      }
      // Handle 12 AM
      else if (components.length > 2 &&
          components[2].toLowerCase() == 'am' &&
          hour == 12) {
        hour = 0;
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return null;
    }
  }

  static Future<void> _cancelTimetableNotifications() async {
    await _notifications.cancelAll();
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}
