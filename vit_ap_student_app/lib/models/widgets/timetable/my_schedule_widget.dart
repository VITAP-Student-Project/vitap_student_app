import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline_tile/timeline_tile.dart';
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
        final classInfo = classes[index].value;
        return _buildTimeLineTile(classInfo);
      },
    );
  }

  Widget _buildTimeLineTile(Map<String, dynamic> classInfo) {
    return ListTile(
      title: Text(classInfo['CourseName']),
      subtitle: Text('${classInfo['CourseCode']} - ${classInfo['CourseType']}'),
      trailing: Text(classInfo['Venue']),
    );
  }
}
