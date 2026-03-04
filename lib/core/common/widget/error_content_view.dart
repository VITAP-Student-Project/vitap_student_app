import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wiredash/wiredash.dart';

class ErrorContentView extends StatelessWidget {
  final String error;
  const ErrorContentView({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Lottie.asset(
              'assets/lottie/404_astronaut.json',
              frameRate: const FrameRate(60),
              width: MediaQuery.sizeOf(context).width / 1.5,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Column(
            children: [
              const Text(
                'Oops!',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                textAlign: TextAlign.center,
                error,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Please consider reporting this error now to prevent this behaviour in the future.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  Wiredash.of(context).show();
                },
                child: const Text('Report Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
