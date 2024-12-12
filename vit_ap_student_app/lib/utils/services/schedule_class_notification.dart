import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import '../model/timetable_model.dart';
import '../provider/notification_utils_provider.dart';
import '../provider/student_provider.dart';
import 'class_notification_service.dart';

Future<void> scheduleClassNotifications(WidgetRef ref) async {
  await ref.read(studentProvider).whenOrNull(
    data: (student) async {
      final Timetable timetable = student.timetable;
      if (timetable == Timetable.empty()) {
        log("Timetable is empty. Cannot schedule notifications.");
        return;
      }

      final bool notificationsEnabled = ref.read(classNotificationProvider);
      final double sliderValue = ref.read(classNotificationSliderProvider);
      final notificationService = NotificationService();

      // Exit if notifications are disabled
      if (!notificationsEnabled) {
        log("Notifications are disabled");
        notificationService.cancelAllNotifications();
        return;
      }

      final now = tz.TZDateTime.now(tz.getLocation('Asia/Kolkata'));

      // Cancel and reinitialize notifications
      notificationService.cancelAllNotifications();
      await notificationService.initNotifications();

      // Iterate through days of the week
      for (int dayOffset = 0; dayOffset < 7; dayOffset++) {
        final targetDate = now.add(Duration(days: dayOffset));
        final targetDay = _getDayName(targetDate.weekday);

        // Safely check if classes exist for this day
        final classes = timetable.toJson()[targetDay] ?? [];
        if (classes.isEmpty) {
          log("No classes found for $targetDay : ${timetable.toJson()[targetDay]}");
          continue;
        }

        for (var classData in classes) {
          final timeRange = classData.keys.first;
          final classDetails = classData[timeRange];

          final startTime = timeRange.split('-').first.trim();
          final [hour, minute] = startTime.split(':').map(int.parse).toList();

          final classDateTime = tz.TZDateTime(
            tz.getLocation('Asia/Kolkata'),
            targetDate.year,
            targetDate.month,
            targetDate.day,
            hour,
            minute,
          );

          // Skip past classes
          if (classDateTime.isBefore(now)) continue;

          final notificationDuration = Duration(minutes: sliderValue.toInt());
          final notificationTime = classDateTime.subtract(notificationDuration);

          notificationService.scheduleNotification(
            id: _generateUniqueNotificationId(targetDay, hour, minute),
            title: "📅 Class Starting Soon",
            body:
                "Your ${classDetails['course_name']} class is about to begin in ${sliderValue.toInt()} minutes at ${classDetails['venue']}. Don't miss out!",
            scheduledTime: notificationTime,
          );

          log("Notification Scheduled: ${classDetails['course_name']} at $notificationTime");
        }
      }
    },
  );
}

// Unique ID generation to prevent conflicts
int _generateUniqueNotificationId(String day, int hour, int minute) {
  final dayMap = {
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
    'Sunday': 7
  };
  return int.parse(
      '${dayMap[day]}${hour.toString().padLeft(2, '0')}${minute.toString().padLeft(2, '0')}');
}

String _getDayName(int weekday) {
  return [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ][weekday % 7];
}

// Refresh method remains the same
Future<void> refreshWeeklyNotifications(WidgetRef ref) async {
  await scheduleClassNotifications(ref);
  log("Weekly notifications refreshed");
}
