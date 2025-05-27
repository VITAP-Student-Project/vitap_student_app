import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/timetable/view/widgets/schedule_timeline.dart';

class ScheduleList extends ConsumerWidget {
  final String day;

  const ScheduleList({super.key, required this.day});

  List<Day> _getClassesForDay(Timetable timetable, String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return timetable.monday.toList();
      case 'tuesday':
        return timetable.tuesday.toList();
      case 'wednesday':
        return timetable.wednesday.toList();
      case 'thursday':
        return timetable.thursday.toList();
      case 'friday':
        return timetable.friday.toList();
      case 'saturday':
        return timetable.saturday.toList();
      case 'sunday':
        return timetable.sunday.toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    final Timetable? timetable = user?.timetable.target;

    if (timetable == null) return const EmptySchedule();

    final List<Day> classes = _getClassesForDay(timetable, day);
    if (classes.isEmpty) return const EmptySchedule();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classItem = classes[index];
        return ScheduleTimeline(
          classInfo: classItem,
          isFirst: index == 0,
          isLast: index == classes.length - 1,
          index: index,
        );
      },
    );
  }
}

class EmptySchedule extends StatelessWidget {
  const EmptySchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/images/lottie/cat_sleep.json", width: 150),
          Text(
            'No classes found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            'Seems like a day off 😪',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
