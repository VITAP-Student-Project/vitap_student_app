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
          // Add a Slider
          Slider(
            value: currentSliderVal,
            min: 0,
            max: 10,
            divisions: 10,
            label: currentSliderVal.toString(),
            onChanged: (value) {
              sliderNotifier.updateSlider(value);
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Save the current slider value
              final savedValue = ref.read(sliderProvider);
              // Implement your save logic here
              print("Saved slider value: $savedValue");
              print("Notification enabled: ${ref.read(notificationProvider)}");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
