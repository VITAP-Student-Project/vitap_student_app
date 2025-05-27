import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';

class UpcomingClassCard extends StatelessWidget {
  final Day classInfo;
  final DateTime startTime;

  const UpcomingClassCard({
    super.key,
    required this.classInfo,
    required this.startTime,
  });

  @override
  Widget build(BuildContext context) {
    final (status, statusColor, textColor) = _getClassStatus();

    return Stack(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 175,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9)),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '${classInfo.courseTime}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(9)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${classInfo.courseName}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${classInfo.courseCode} - ${classInfo.courseType}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${classInfo.venue}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
        classInfo.courseType!.contains('TH')
            ? Positioned(
                bottom: -26,
                right: -15,
                child: Lottie.asset(
                  'assets/images/lottie/books.json',
                  width: 165,
                  repeat: false,
                ),
              )
            : Positioned(
                bottom: -24,
                right: -25,
                child: Lottie.asset(
                  'assets/images/lottie/lab.json',
                  width: 175,
                  repeat: true,
                ),
              ),
      ],
    );
  }

  (String, Color, Color) _getClassStatus() {
    final now = DateTime.now();
    final endTime = startTime.add(const Duration(minutes: 50));

    if (now.isBefore(startTime)) {
      return (
        'Upcoming',
        Colors.blueAccent.shade200.withOpacity(0.5),
        Colors.blue
      );
    } else if (now.isAfter(endTime)) {
      return (
        'Completed',
        Colors.greenAccent.shade200.withOpacity(0.3),
        Colors.green
      );
    }
    return ('Ongoing', Colors.orange.shade300.withOpacity(0.5), Colors.orange);
  }
}
