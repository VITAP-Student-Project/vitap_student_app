import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart' as td;
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/models/user_preferences.dart';
import 'package:vit_ap_student_app/core/utils/request_notification_permission.dart';

/// Type of file download for notification display
enum DownloadType {
  generalOuting('General Outing Pass', '🎟️'),
  weekendOuting('Weekend Outing Pass', '🎟️'),
  courseMaterial('Course Material', '📚'),
  courseSyllabus('Course Syllabus', '📘'),
  allCourseMaterials('Course Materials (ZIP)', '📦'),
  digitalAssignment('Digital Assignment', '📝'),
  pdf('PDF Document', '📄');

  final String label;
  final String emoji;
  const DownloadType(this.label, this.emoji);
}

// ---------------------------------------------------------------------------
// Notification Group Keys
// ---------------------------------------------------------------------------
// Android uses groupKey strings; iOS uses threadIdentifier strings.
// When multiple notifications share the same key, the OS groups them together.

/// Group key for all file download notifications
const _groupKeyDownloads = 'com.vitap.downloads';

/// Group key for class/timetable reminder notifications
const _groupKeyClassReminders = 'com.vitap.class_reminders';

/// Group key for exam reminder notifications
const _groupKeyExamReminders = 'com.vitap.exam_reminders';

/// Fixed notification IDs for group summaries (must not collide with content IDs)
const _downloadGroupSummaryId = 0x7F000001;
// ignore: unused_element
const _classGroupSummaryId = 0x7F000002;
// ignore: unused_element
const _examGroupSummaryId = 0x7F000003;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  /// Notification action identifiers
  static const _openFileActionId = 'open_file';

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    await requestNotificationPermission();
    const android = AndroidInitializationSettings('app_icon');

    // Request iOS to show "Configure in App" button in system notification settings
    const ios = DarwinInitializationSettings(
      requestProvidesAppNotificationSettings: true,
    );

    await _notifications.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Handle notification tap and action button presses.
  /// Opens the file using the payload (file path).
  static Future<void> _onNotificationTap(NotificationResponse response) async {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;

    // Both the default tap and the "Open File" action open the file
    if (response.notificationResponseType ==
            NotificationResponseType.selectedNotification ||
        response.actionId == _openFileActionId) {
      if (payload.startsWith('/') || payload.startsWith('content://')) {
        await OpenFile.open(payload);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Generic File Download Notification
  // ---------------------------------------------------------------------------

  /// Shows an instant notification when a file download completes.
  ///
  /// Works for all download types: outing PDFs, course materials,
  /// digital assignments, syllabus, etc.
  ///
  /// The notification includes an Android semantic action button ("Open File")
  /// that opens the downloaded file directly.
  ///
  /// Notifications are grouped under [_groupKeyDownloads] so multiple downloads
  /// stack together in the notification shade.
  ///
  /// [downloadType] — the type of download for display text
  /// [fileName] — the human-readable name (e.g. course code, leave ID)
  /// [filePath] — the saved file path used as payload to open on tap
  static Future<void> showDownloadCompleteNotification({
    required DownloadType downloadType,
    required String fileName,
    required String filePath,
  }) async {
    final notificationId = filePath.hashCode;

    // Android notification with grouping + semantic "Open File" action
    final androidDetails = AndroidNotificationDetails(
      'file_downloads',
      'File Downloads',
      channelDescription: 'Notifications for file download completion',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'app_icon',
      playSound: true,
      enableVibration: true,
      category: AndroidNotificationCategory.status,
      groupKey: _groupKeyDownloads,
      styleInformation: BigTextStyleInformation(
        '$fileName has been downloaded successfully. Tap to open.',
        contentTitle: '${downloadType.emoji} ${downloadType.label} Ready',
      ),
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          _openFileActionId,
          'Open File',
          showsUserInterface: true,
          semanticAction: SemanticAction.none,
        ),
      ],
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(threadIdentifier: _groupKeyDownloads),
    );

    await _notifications.show(
      id: notificationId,
      title: '${downloadType.emoji} ${downloadType.label} Ready',
      body: '$fileName downloaded successfully. Tap to open.',
      notificationDetails: notificationDetails,
      payload: filePath,
    );

    // Post a group summary so Android bundles individual download notifications
    if (Platform.isAndroid) {
      await _showDownloadGroupSummary();
    }
  }

  /// Android group summary notification for downloads.
  /// This is the "header" that bundles individual download notifications together
  /// (e.g. "3 downloads"). It must use [setAsGroupSummary: true].
  static Future<void> _showDownloadGroupSummary() async {
    const androidDetails = AndroidNotificationDetails(
      'file_downloads',
      'File Downloads',
      channelDescription: 'Notifications for file download completion',
      importance: Importance.low,
      priority: Priority.low,
      icon: 'app_icon',
      playSound: false,
      enableVibration: false,
      groupKey: _groupKeyDownloads,
      setAsGroupSummary: true,
      styleInformation: InboxStyleInformation(
        [],
        contentTitle: 'File Downloads',
        summaryText: 'Downloads',
      ),
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      id: _downloadGroupSummaryId,
      title: 'File Downloads',
      body: '',
      notificationDetails: notificationDetails,
    );
  }

  // ---------------------------------------------------------------------------
  // Download Progress Notifications
  // ---------------------------------------------------------------------------

  /// Shows an indeterminate progress notification when a download starts.
  ///
  /// Call this before the network request begins. The notification will show
  /// a spinning progress bar until [updateDownloadProgress] or
  /// [showDownloadCompleteNotification] replaces it.
  ///
  /// Returns the [notificationId] so callers can update/complete it later.
  static Future<int> showDownloadProgressIndeterminate({
    required DownloadType downloadType,
    required String fileName,
  }) async {
    final notificationId = '${downloadType.name}_$fileName'.hashCode;

    final androidDetails = AndroidNotificationDetails(
      'file_downloads',
      'File Downloads',
      channelDescription: 'Notifications for file download completion',
      importance: Importance.low,
      priority: Priority.low,
      icon: 'app_icon',
      playSound: false,
      enableVibration: false,
      category: AndroidNotificationCategory.progress,
      groupKey: _groupKeyDownloads,
      ongoing: true,
      showProgress: true,
      indeterminate: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(threadIdentifier: _groupKeyDownloads),
    );

    await _notifications.show(
      id: notificationId,
      title: '${downloadType.emoji} Downloading ${downloadType.label}',
      body: fileName,
      notificationDetails: notificationDetails,
    );

    return notificationId;
  }

  /// Updates an existing download progress notification with a determinate
  /// progress bar showing [progress] out of [maxProgress].
  ///
  /// Use when the total size is known (e.g. from a Content-Length header).
  static Future<void> updateDownloadProgress({
    required int notificationId,
    required DownloadType downloadType,
    required String fileName,
    required int progress,
    required int maxProgress,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'file_downloads',
      'File Downloads',
      channelDescription: 'Notifications for file download completion',
      importance: Importance.low,
      priority: Priority.low,
      icon: 'app_icon',
      playSound: false,
      enableVibration: false,
      category: AndroidNotificationCategory.progress,
      groupKey: _groupKeyDownloads,
      ongoing: true,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(threadIdentifier: _groupKeyDownloads),
    );

    await _notifications.show(
      id: notificationId,
      title: '${downloadType.emoji} Downloading ${downloadType.label}',
      body: fileName,
      notificationDetails: notificationDetails,
    );
  }

  /// Cancels an in-progress download notification (e.g. on error or cancel).
  static Future<void> cancelDownloadProgress(int notificationId) async {
    await _notifications.cancel(id: notificationId);
  }

  /// Legacy wrapper — redirects to the new generic method.
  /// Kept for backward compatibility; prefer [showDownloadCompleteNotification].
  @Deprecated('Use showDownloadCompleteNotification instead')
  static Future<void> showOutingPdfDownloadNotification({
    required String outingType,
    required String leaveId,
    required String filePath,
  }) async {
    final type = outingType.toLowerCase() == 'weekend'
        ? DownloadType.weekendOuting
        : outingType.toLowerCase() == 'general'
        ? DownloadType.generalOuting
        : DownloadType.pdf;

    await showDownloadCompleteNotification(
      downloadType: type,
      fileName:
          '${outingType[0].toUpperCase()}${outingType.substring(1)} Outing Pass ($leaveId)',
      filePath: filePath,
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
      timetable.sunday,
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
      groupKey: _groupKeyClassReminders,
      styleInformation: BigTextStyleInformation(
        'Your ${slot.courseName} class is about to begin at ${slot.venue} in $delayMinutes minutes. Don\'t miss out!',
        contentTitle: '📅 Class Starting Soon',
      ),
    );

    await _notifications.zonedSchedule(
      id: slot.hashCode,
      title: '📅 Class Starting Soon',
      body:
          'Your ${slot.courseName} class is about to begin at ${slot.venue} in $delayMinutes minutes. Don\'t miss out!',
      scheduledDate: notificationTime,
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(
          threadIdentifier: _groupKeyClassReminders,
        ),
      ),
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
    await _notifications.cancelAllPendingNotifications();
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

    final notificationTime = examDateTime.subtract(
      Duration(minutes: delayMinutes),
    );
    if (notificationTime.isBefore(tz.TZDateTime.now(tz.local))) return;

    final androidDetails = AndroidNotificationDetails(
      'exam_reminders',
      'Exam Reminders',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      category: AndroidNotificationCategory.reminder,
      groupKey: _groupKeyExamReminders,
      styleInformation: BigTextStyleInformation(
        '📍 Venue: ${subject.venue}\n📅 Date: ${subject.date}\n📘 Course Code: ${subject.courseCode}',
        contentTitle: '📢 Upcoming Exam: ${subject.courseTitle}',
      ),
    );

    await _notifications.zonedSchedule(
      id: 'exam_${subject.courseCode}_${subject.date}'.hashCode,
      title: '📢 Exam Reminder: ${subject.courseTitle}',
      body: '📍 ${subject.venue} • ${subject.date} • ${subject.courseCode}',
      scheduledDate: notificationTime,
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(
          threadIdentifier: _groupKeyExamReminders,
        ),
      ),
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
        'Dec': 12,
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
        await _notifications.cancel(id: notification.id);
      }
    }
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
    await _notifications.cancelAllPendingNotifications();
  }

  /// Cancels only pending (scheduled) notifications, leaving active ones intact
  static Future<void> cancelAllScheduledNotifications() async {
    await _notifications.cancelAllPendingNotifications();
  }
}
