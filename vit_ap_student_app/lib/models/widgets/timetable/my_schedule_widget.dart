import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/utils/text_newline.dart';
import '../../../utils/provider/providers.dart';

class MySchedule extends ConsumerWidget {
  final String day;

  const MySchedule({super.key, required this.day});

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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/images/lottie/cat_sleep.json",
                    frameRate: const FrameRate(60), width: 150),
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

    final data = timetable[day] as List<dynamic>;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final classItem = data[index] as Map<String, dynamic>;
        final classEntries = classItem.entries.toList();

        if (classEntries.isNotEmpty) {
          final classTime = classEntries[0].key;
          final classInfo = classEntries[0].value as Map<String, dynamic>;

          return _buildTimeLineTile(
              context, classTime, classInfo, index, data.length);
        } else {
          // Handle cases where classItem is empty or invalid
          return ListTile(
            title: const Text('Invalid class data'),
            subtitle: Text(classItem.toString()),
          );
        }
      },
    );
  }

  Widget _buildTimeLineTile(BuildContext context, String classTime,
      Map<String, dynamic> classInfo, int index, int totalClasses) {
    bool isFirst = index == 0;
    bool isLast = index == totalClasses - 1;
    String startTime = classTime.split('-')[0].trim();

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        iconStyle: IconStyle(
          fontSize: 5.0,
          iconData: Icons.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        indicatorXY: 0.13,
        width: 12,
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 5),
      ),
      beforeLineStyle: LineStyle(
        color: Theme.of(context).colorScheme.tertiary,
        thickness: 1.5,
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  startTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width - 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.zero,
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      bottom: 10,
                      top: 4,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addNewlines(
                              classInfo['course_name'] ?? 'Unavailable', 30),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          classInfo['faculty'] ?? 'Unavailable',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${classInfo['course_code'] ?? 'Unavailable'} - ${classInfo['course_type'] ?? 'Unavailable'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          classInfo['venue'] ?? 'Unavailable',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
