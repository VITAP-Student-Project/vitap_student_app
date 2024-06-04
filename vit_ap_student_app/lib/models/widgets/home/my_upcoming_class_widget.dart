import 'package:flutter/material.dart';

class MyUpcomingClassWidget extends StatefulWidget {
  const MyUpcomingClassWidget({super.key});

  @override
  State<MyUpcomingClassWidget> createState() => _MyUpcomingClassWidgetState();
}

class _MyUpcomingClassWidgetState extends State<MyUpcomingClassWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
