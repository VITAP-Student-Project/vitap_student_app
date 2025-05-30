import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wiredash/wiredash.dart';

class ErrorContentView extends StatelessWidget {
  const ErrorContentView({super.key});

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
              'assets/images/lottie/404_astronaut.json',
              frameRate: const FrameRate(60),
              width: MediaQuery.sizeOf(context).width / 1.5,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            children: [
              const Text(
                'Oops!',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                textAlign: TextAlign.center,
                'The page you are looking for does not exist or some other error occurred.Please consider reporting this now to prevent this kind of errors in the future.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  Wiredash.of(context).show();
                },
                child: Text("Report Now"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
