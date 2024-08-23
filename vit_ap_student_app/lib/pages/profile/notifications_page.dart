import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/provider/providers.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSliderVal = ref.watch(sliderProvider);
    final sliderNotifier = ref.watch(sliderProvider.notifier);

    final needNotification = ref.watch(notificationProvider);
    final notificationNotifier = ref.watch(notificationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    "Notification",
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
                ),
              ),
              Transform.scale(
                scale: 0.8, // Adjust the scale as needed
                child: Switch(
                  value: needNotification,
                  onChanged: (value) {
                    notificationNotifier.toggleNotification(value);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: Text(
              "Notification delay",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          // Add a Slider
          Slider(
            value: currentSliderVal,
            min: 0,
            max: 15,
            divisions: 15,
            label: currentSliderVal.toString(),
            onChanged: (value) {
              sliderNotifier.updateSliderDelay(value);
            },
          ),
        ],
      ),
    );
  }
}
