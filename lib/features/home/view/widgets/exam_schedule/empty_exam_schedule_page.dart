import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyExamSchedulePage extends StatefulWidget {
  const EmptyExamSchedulePage({super.key});

  @override
  State<EmptyExamSchedulePage> createState() => _EmptyExamSchedulePageState();
}

class _EmptyExamSchedulePageState extends State<EmptyExamSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/lottie/cat_sleep.json',
              frameRate: const FrameRate(60),
              width: 120,
            ),
            const Text(
              textAlign: TextAlign.center,
              'Exams not yet scheduled',
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text(
                "Refresh",
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
