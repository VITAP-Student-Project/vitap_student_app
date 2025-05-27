import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';

class NotificationSettingsPage extends ConsumerWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreferences = ref.watch(userPreferencesNotifierProvider);
    final userPreferencesNotifier =
        ref.read(userPreferencesNotifierProvider.notifier);

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
                tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
                title: Text(
                  "Class Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "Disable/Enable class notifications.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: userPreferences.isTimetableNotificationsEnabled,
                    onChanged: (value) async {
                      final updatedPreferences = userPreferences.copyWith(
                        isTimetableNotificationsEnabled: value,
                      );
                      await userPreferencesNotifier
                          .updatePreferences(updatedPreferences);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
                child: Text(
                  "Class Notification delay (${userPreferences.timetableNotificationDelay} min)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                children: [
                  Slider(
                    value:
                        userPreferences.timetableNotificationDelay.toDouble(),
                    min: 0,
                    max: 60,
                    divisions: 12,
                    label:
                        userPreferences.timetableNotificationDelay.toString(),
                    onChanged: (value) async {
                      final updatedPreferences = userPreferences.copyWith(
                        timetableNotificationDelay: value.round(),
                      );
                      await userPreferencesNotifier
                          .updatePreferences(updatedPreferences);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('0'),
                        Text('15'),
                        Text('30'),
                        Text('45'),
                        Text('60'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              ListTile(
                tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
                title: Text(
                  "Exam Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "Disable/Enable exam notifications.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: userPreferences.isExamScheduleNotificationEnabled,
                    onChanged: (value) async {
                      final updatedPreferences = userPreferences.copyWith(
                        isExamScheduleNotificationEnabled: value,
                      );
                      await userPreferencesNotifier
                          .updatePreferences(updatedPreferences);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
                child: Text(
                  "Exam Notification delay (${userPreferences.examScheduleNotificationDelay} min)",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                children: [
                  Slider(
                    value: userPreferences.examScheduleNotificationDelay
                        .toDouble(),
                    min: 0,
                    max: 180,
                    divisions: 18,
                    label: userPreferences.examScheduleNotificationDelay
                        .toString(),
                    onChanged: (value) async {
                      final updatedPreferences = userPreferences.copyWith(
                        examScheduleNotificationDelay: value.round(),
                      );
                      await userPreferencesNotifier
                          .updatePreferences(updatedPreferences);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('0'),
                        Text('45'),
                        Text('90'),
                        Text('135'),
                        Text('180'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
