import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/provider/notification_utils_provider.dart';
import '../../utils/provider/providers.dart';
import '../../utils/services/class_notification_service.dart';
import '../../utils/services/notification_manager.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  void _clearAllNotifications(BuildContext context) async {
    try {
      NotificationService notificationService = await NotificationService();
      notificationService.cancelAllNotifications();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All notifications have been cleared'),
          backgroundColor: Colors.green.shade200,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to clear notifications: $e'),
          backgroundColor: Colors.redAccent..shade200,
        ),
      );
    }
  }

  // Method to check scheduled notifications
  void _checkScheduledNotifications(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final _lastRefreshTime = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt('lastNotificationRefresh') ?? 0);
      NotificationService notificationService = NotificationService();
      final activeNotifications =
          await notificationService.getAllActiveNotifications();

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Scheduled Notifications'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications last scheduled on $_lastRefreshTime',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                ...activeNotifications.map(
                  (notification) => Text(
                    "Notification ID: ${notification.id}, Title: ${notification.title}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error checking notifications: $e'),
          backgroundColor: Colors.red.shade200,
        ),
      );
    }
  }

  // Method to force reschedule notifications
  void _forceRescheduleNotifications(
      BuildContext context, WidgetRef ref) async {
    try {
      // Call your existing method to refresh notifications
      await NotificationManager.forceRefresh(ref);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notifications have been rescheduled'),
          backgroundColor: Colors.green.shade200,
        ),
      );
    } catch (e) {
      log('Failed to reschedule notifications', error: e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reschedule notifications: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needPrivacyMode = ref.watch(privacyModeProvider);
    final needPrivacyModeNotifier = ref.watch(privacyModeProvider.notifier);
    final currentClassSliderVal = ref.watch(classNotificationSliderProvider);
    final classSliderNotifier =
        ref.watch(classNotificationSliderProvider.notifier);

    final classNeedNotification = ref.watch(classNotificationProvider);
    final classNotificationNotifier =
        ref.watch(classNotificationProvider.notifier);

    final currentExamSliderVal = ref.watch(examNotificationSliderProvider);
    final examSliderNotifier =
        ref.watch(examNotificationSliderProvider.notifier);

    final examNeedNotification = ref.watch(examNotificationProvider);
    final examNotificationNotifier =
        ref.watch(examNotificationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                title: const Text(
                  "Privacy",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                leading: Icon(
                  Icons.abc_outlined,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              ListTile(
                tileColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  "Privacy mode",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  "Hide CGPA from home screen",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8, // Adjust the scale as needed
                  child: Switch(
                    value: needPrivacyMode,
                    onChanged: (value) {
                      needPrivacyModeNotifier.togglePrivacyMode(value);
                    },
                  ),
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                title: const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                leading: Icon(
                  Icons.abc_outlined,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              ListTile(
                tileColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  "Class Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  "Disable/Enable class notifications.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: classNeedNotification,
                    onChanged: (value) {
                      classNotificationNotifier.toggleNotification(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
                child: Text(
                  "Class Notification delay",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              // Add a Slider
              Column(
                children: [
                  Slider(
                    value: currentClassSliderVal,
                    min: 0,
                    max: 15,
                    divisions: 15,
                    label: currentClassSliderVal.toString(),
                    onChanged: (value) {
                      classSliderNotifier.updateSliderDelay(value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('0'),
                        Text('5'),
                        Text('10'),
                        Text('15'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),

              ListTile(
                tileColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  "Exam Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  "Disable/Enable exam notifications.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: examNeedNotification,
                    onChanged: (value) {
                      examNotificationNotifier.toggleNotification(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
                child: Text(
                  "Exam Notification delay",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              // Add a Slider
              Column(
                children: [
                  Slider(
                    value: currentExamSliderVal,
                    min: 0,
                    max: 15,
                    divisions: 15,
                    label: currentExamSliderVal.toString(),
                    onChanged: (value) {
                      examSliderNotifier.updateSliderDelay(value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('0'),
                        Text('5'),
                        Text('10'),
                        Text('15'),
                      ],
                    ),
                  ),
                ],
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                title: const Text(
                  "Adavanced",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                leading: Icon(
                  Icons.abc_outlined,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ListTile(
                tileColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  "Clear Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  "Clear all scheduled notifications.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                onTap: () => _clearAllNotifications(context),
              ),
              SizedBox(
                height: 8,
              ),
              ListTile(
                tileColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  "Reschedule Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  "Force reschedule all notifications.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                onTap: () => _forceRescheduleNotifications(context, ref),
              ),
              ListTile(
                tileColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  "Check Scheduled Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  "Check last notification refresh time.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                onTap: () => _checkScheduledNotifications(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
