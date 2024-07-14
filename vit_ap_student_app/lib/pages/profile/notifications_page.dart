import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool needNotification = false;
  double _currentSliderVal = 5;

  @override
  Widget build(BuildContext context) {
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
                    "Notifications",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.8, // Adjust the scale as needed
                child: Switch(
                  value: needNotification,
                  onChanged: (value) {
                    setState(() {
                      needNotification = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Slider(
            label: "$_currentSliderVal",
            min: 0,
            max: 20,
            divisions: 4,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Theme.of(context).colorScheme.tertiary,
            value: _currentSliderVal,
            onChanged: (double newValue) {
              setState(() {
                _currentSliderVal = newValue;
              });
            },
          )
        ],
      ),
    );
  }
}
