import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TimetableEmptyState extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  const TimetableEmptyState(
      {super.key,
      this.primaryText = 'No more classes for the day',
      this.secondaryText = 'Time to rest 😪'});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(9),
      ),
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset(
              "assets/lottie/cat_sleep.json",
              width: 150,
              frameRate: const FrameRate(60),
            ),
            Text(
              primaryText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              secondaryText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
