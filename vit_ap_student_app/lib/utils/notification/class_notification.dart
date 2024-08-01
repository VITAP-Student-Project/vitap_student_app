import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../provider/providers.dart';

class MyUpcomingClassWidget extends ConsumerStatefulWidget {
  @override
  _MyUpcomingClassWidgetState createState() => _MyUpcomingClassWidgetState();
}

class _MyUpcomingClassWidgetState extends ConsumerState<MyUpcomingClassWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String day =
        DateFormat('EEEE').format(now); // Get the current day of the week
    final timetable = ref.watch(timetableProvider);
    print(timetable[day]);
    return Text(timetable[day]);
  }
}
