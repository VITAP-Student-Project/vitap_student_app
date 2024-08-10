import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../provider/providers.dart';
import 'notification_service.dart';

void scheduleClassNotifications(WidgetRef ref) {
  final Map<String, dynamic> timetable =
      ref.read(timetableProvider); // Read the timetable data

  // Read the notification enabled state
  final bool notificationsEnabled = ref.read(notificationProvider);

  // Read the slider value for notification duration
  final double sliderValue = ref.read(sliderProvider);

  final notificationService = NotificationService();

  int getDayOfWeek(String day) {
    switch (day) {
      case 'Monday':
        return DateTime.monday;
      case 'Tuesday':
        return DateTime.tuesday;
      case 'Wednesday':
        return DateTime.wednesday;
      case 'Thursday':
        return DateTime.thursday;
      case 'Friday':
        return DateTime.friday;
      case 'Saturday':
        return DateTime.saturday;
      case 'Sunday':
        return DateTime.sunday;
      default:
        return DateTime.monday;
    }
  }

  if (!notificationsEnabled) {
    // Exit the function if notifications are disabled
    notificationService.cancelAllNotifications();
    return;
  }

  notificationService.initNotifications();
  final now = DateTime.now();
  final kolkata = tz.getLocation('Asia/Kolkata');

  int notificationId = 0;

  for (var day in timetable.keys) {
    final classes = timetable[day];

    for (var classData in classes) {
      final timeRange = classData.keys.first;
      final classDetails = classData[timeRange];

      final startTime = timeRange.split('-').first.trim();
      final hoursMinutes = startTime.split(':');
      final hour = int.parse(hoursMinutes[0]);
      final minute = int.parse(hoursMinutes[1]);

      final dayOfWeek = getDayOfWeek(day);
      int daysUntilNextClass = (dayOfWeek - now.weekday + 7) % 7;
      final nextClassDay = now.add(Duration(days: daysUntilNextClass));

      // Use the slider value for notification duration
      final notificationDuration = Duration(minutes: sliderValue.toInt());

      final classStartTime = tz.TZDateTime(
        kolkata,
        nextClassDay.year,
        nextClassDay.month,
        nextClassDay.day,
        hour,
        minute,
      ).subtract(notificationDuration);

      notificationService.scheduleNotification(
        id: notificationId++,
        title: "📅 Class Starting Soon",
        body:
            "${classDetails['course_name']} is about to begin in ${sliderValue.toInt()} minutes at ${classDetails['venue']}. Don’t miss out!",
        scheduledTime: classStartTime,
      );
    }
  }
}
