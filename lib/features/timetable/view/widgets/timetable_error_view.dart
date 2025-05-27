import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TimetableErrorView extends StatelessWidget {
  const TimetableErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.sizeOf(context).height / 4)),
        SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  "assets/images/lottie/data_not_found.json",
                  width: 150,
                  frameRate: const FrameRate(60),
                ),
                Text(
                  'Error fetching timetable',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Text(
                  'Please refresh to try again',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
