import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/provider/notification_utils_provider.dart';
import '../../utils/provider/providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
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
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(
              "Hide CGPA from home screen",
              style: TextStyle(
                fontSize: 14,
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
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
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(
              "Disable/Enable class notifications.",
              style: TextStyle(
                fontSize: 14,
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
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: Text(
              "Class Notification delay",
              style: TextStyle(
                fontSize: 18,
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
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(
              "Disable/Enable exam notifications.",
              style: TextStyle(
                fontSize: 14,
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
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: Text(
              "Exam Notification delay",
              style: TextStyle(
                fontSize: 18,
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
        ],
      ),
    );
  }
}
