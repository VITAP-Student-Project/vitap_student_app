import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/provider/timetable_provider.dart';

class MySchedule extends ConsumerWidget {
  final String day;

  MySchedule({required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetable = ref.watch(timetableProvider);
    if (timetable.isEmpty || !timetable["timetable"].containsKey(day)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(9),
          ),
          height: 150,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/images/lottie/cat_sleep.json",
                    frameRate: FrameRate(60), width: 150),
                Text(
                  'No classes found',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Text(
                  'Seems like a day off 😪',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final classes = timetable["timetable"][day].entries.toList();

    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classTime = classes[index].key;
        final classInfo = classes[index].value;
        return _buildTimeLineTile(
            context, classTime, classInfo, index, classes.length);
      },
    );
  }

  Widget _buildTimeLineTile(BuildContext context, String classTime,
      Map<String, dynamic> classInfo, int index, int totalClasses) {
    bool isFirst = index == 0;
    bool isLast = index == totalClasses - 1;
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.all(6),
      ),
      beforeLineStyle: LineStyle(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2,
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classTime,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              classInfo['CourseName'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${classInfo['CourseCode']} - ${classInfo['CourseType']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              classInfo['Venue'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
