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
    if (timetable.isEmpty || !timetable.containsKey(day)) {
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

    // Safely cast timetable[day] to Map<String, dynamic>
    final classes = (timetable[day] as Map<String, dynamic>).entries.toList();

    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classTime = classes[index].key;
        final classInfo = classes[index].value;

        if (classInfo is Map<String, dynamic>) {
          return _buildTimeLineTile(
              context, classTime, classInfo, index, classes.length);
        } else {
          // If the data is not in the expected format, handle the error gracefully
          return ListTile(
            title: Text('Invalid class data for $classTime'),
            subtitle: Text(classInfo),
          );
        }
      },
    );
  }

  Widget _buildTimeLineTile(BuildContext context, String classTime,
      Map<String, dynamic> classInfo, int index, int totalClasses) {
    bool isFirst = index == 0;
    bool isLast = index == totalClasses - 1;
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        iconStyle: IconStyle(iconData: Icons.circle),
        indicatorXY: 0.14,
        width: 15,
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 5),
      ),
      beforeLineStyle: LineStyle(
        color: Theme.of(context).colorScheme.primary,
        thickness: 1.5,
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(4.0),
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
              classInfo['CourseName'] ?? 'No Course Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${classInfo['CourseCode'] ?? 'No Code'} - ${classInfo['CourseType'] ?? 'No Type'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              classInfo['Venue'] ?? 'No Venue',
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
