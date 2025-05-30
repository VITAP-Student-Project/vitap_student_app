import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingSlide extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingSlide(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: Center(
            child: SizedBox(
              width: 450.0,
              child: SvgPicture.asset(
                imagePath,
                width: MediaQuery.sizeOf(context).width - 150,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
