import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart' as td;
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/models/user_preferences.dart';
import 'package:vit_ap_student_app/core/utils/request_notification_permission.dart';

// TODO: Test exam schedule notifications
class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    requestNotificationPermission();
    const android = AndroidInitializationSettings('app_icon');
    const ios = DarwinInitializationSettings();
    await _notifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Handle notification tap - opens file if payload is a file path
  static Future<void> _onNotificationTap(NotificationResponse response) async {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      // Check if payload is a file path (starts with /)
      if (payload.startsWith('/')) {
        await OpenFile.open(payload);
      }
      // Add other payload handling here if needed
    }
  }

  /// Show a download complete notification for outing PDFs
  /// [outingType] should be 'general' or 'weekend'
  static Future<void> showOutingPdfDownloadNotification({
    required String outingType,
    required String leaveId,
    required String filePath,
  }) async {
    final notificationId = filePath.hashCode;
    final formattedOutingType =
        outingType[0].toUpperCase() + outingType.substring(1).toLowerCase();

    final androidDetails = AndroidNotificationDetails(
      'pdf_downloads',
      'PDF Downloads',
      channelDescription: 'Notifications for PDF download completion',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'app_icon',
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(
        'Your $formattedOutingType outing pass has been downloaded successfully. Tap to view your pass.',
        contentTitle: '🎟️ $formattedOutingType outing Pass Ready',
      ),
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await _notifications.show(
      notificationId,
      '🎟️ $formattedOutingType outing Pass Ready',
      'Your $formattedOutingType outing pass has been downloaded successfully. Tap to view your pass.',
      notificationDetails,
      payload: filePath,
    );
  }

  static Future<void> scheduleTimetableNotifications({
    required User user,
    required UserPreferences prefs,
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
        if (slot.startTime != null && slot.courseName != null) {
          await _scheduleClassNotification(
            slot: slot,
            weekday: i + 1,
            delayMinutes: prefs.timetableNotificationDelay,
          );
        }
      }
    }
  }

  static Future<void> _scheduleClassNotification({
    required td.Day slot,
    required int weekday,
    required int delayMinutes,
  }) async {
    final startTime = _parseTime(slot.startTime!);
    if (startTime == null) return;

    final notificationTime = _calculateNotificationTime(
      weekday: weekday,
      time: startTime,
      delayMinutes: delayMinutes,
    );

    final androidDetails = AndroidNotificationDetails(
      'timetable_reminders',
      'Class Reminders',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      category: AndroidNotificationCategory.reminder,
      styleInformation: BigTextStyleInformation(
        'Your ${slot.courseName} class is about to begin at ${slot.venue} in $delayMinutes minutes. Don\'t miss out!',
        contentTitle: '📅 Class Starting Soon',
      ),
    );

    await _notifications.zonedSchedule(
      slot.hashCode,
      '📅 Class Starting Soon',
      'Your ${slot.courseName} class is about to begin at ${slot.venue} in $delayMinutes minutes. Don\'t miss out!',
      notificationTime,
      NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.inexact,
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

  static TimeOfDay? _parseTime(String startTime) {
    try {
      final components = startTime.split(RegExp(r'[\s:]'));
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

  static Future<void> scheduleExamNotifications({
    required User user,
    required UserPreferences prefs,
  }) async {
    if (!prefs.isExamScheduleNotificationEnabled) return;
    await _cancelExamNotifications();

    for (final examSchedule in user.examSchedule) {
      for (final subject in examSchedule.subjects) {
        await _scheduleExamNotification(
          subject: subject,
          delayMinutes: prefs.examScheduleNotificationDelay,
        );
      }
    }
  }

  static Future<void> _scheduleExamNotification({
    required Subject subject,
    required int delayMinutes,
  }) async {
    final examDateTime = _parseExamDateTime(subject.date, subject.examTime);
    if (examDateTime == null) return;

    final notificationTime =
        examDateTime.subtract(Duration(minutes: delayMinutes));
    if (notificationTime.isBefore(tz.TZDateTime.now(tz.local))) return;

    final androidDetails = AndroidNotificationDetails(
      'exam_reminders',
      'Exam Reminders',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      category: AndroidNotificationCategory.reminder,
      styleInformation: BigTextStyleInformation(
        '📍 Venue: ${subject.venue}\n📅 Date: ${subject.date}\n📘 Course Code: ${subject.courseCode}',
        contentTitle: '📢 Upcoming Exam: ${subject.courseTitle}',
      ),
    );

    await _notifications.zonedSchedule(
      'exam_${subject.courseCode}_${subject.date}'.hashCode,
      '📢 Exam Reminder: ${subject.courseTitle}',
      '📍 ${subject.venue} • ${subject.date} • ${subject.courseCode}',
      notificationTime,
      NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static tz.TZDateTime? _parseExamDateTime(String dateStr, String timeStr) {
    try {
      // Parse date in "27 - Jan - 2025" format
      final dateParts = dateStr.split(' - ').map((s) => s.trim()).toList();
      if (dateParts.length != 3) return null;

      final months = {
        'Jan': 1,
        'Feb': 2,
        'Mar': 3,
        'Apr': 4,
        'May': 5,
        'Jun': 6,
        'Jul': 7,
        'Aug': 8,
        'Sep': 9,
        'Oct': 10,
        'Nov': 11,
        'Dec': 12
      };

      final day = int.parse(dateParts[0]);
      final month = months[dateParts[1]];
      final year = int.parse(dateParts[2]);

      if (month == null) return null;

      // Parse time in "10:00 AM - 01:00 PM" format
      final timePart = timeStr.split(' - ')[0].trim();
      final timeComponents = timePart.split(RegExp(r'[\s:]'));
      var hour = int.parse(timeComponents[0]);
      final minute = int.parse(timeComponents[1]);

      // Handle AM/PM
      if (timeComponents.length > 2) {
        final period = timeComponents[2].toLowerCase();
        if (period == 'pm' && hour < 12) hour += 12;
        if (period == 'am' && hour == 12) hour = 0;
      }

      return tz.TZDateTime(tz.local, year, month, day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  static Future<void> _cancelExamNotifications() async {
    // Cancel only exam notifications
    final pending = await _notifications.pendingNotificationRequests();
    for (final notification in pending) {
      if (notification.title?.contains('Upcoming Exam') ?? false) {
        await _notifications.cancel(notification.id);
      }
    }
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}
