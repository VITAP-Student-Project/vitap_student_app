import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

class UpcomingClassWidget extends StatelessWidget {
  final AsyncValue<Map<String, dynamic>> timetableState;

  const UpcomingClassWidget({Key? key, required this.timetableState})
      : super(key: key);

  void updateWidget() async {
    final now = DateTime.now();
    final day = _getDayString(now.weekday);

    if (timetableState.hasValue) {
      final todayClasses = timetableState.value![day] as List?;
      final nextClass = _getNextClass(todayClasses, now);
      if (nextClass != null) {
        await HomeWidget.saveWidgetData<String>(
            'next_class', nextClass['course_name']);
        await HomeWidget.saveWidgetData<String>(
            'faculty_name', nextClass['faculty']);
        await HomeWidget.saveWidgetData<String>('venue', nextClass['venue']);
        await HomeWidget.updateWidget(
          name: 'UpcomingClassWidgetProvider',
          iOSName: 'UpcomingClassWidgetProvider',
        );
      } else {
        await HomeWidget.saveWidgetData<String>(
            'next_class', 'No upcoming class');
        await HomeWidget.saveWidgetData<String>('faculty_name', '');
        await HomeWidget.saveWidgetData<String>('venue', '');
        await HomeWidget.updateWidget(
          name: 'UpcomingClassWidgetProvider',
          iOSName: 'UpcomingClassWidgetProvider',
        );
      }
    } else {
      await HomeWidget.saveWidgetData<String>(
          'next_class', 'No upcoming class');
      await HomeWidget.saveWidgetData<String>('faculty_name', '');
      await HomeWidget.saveWidgetData<String>('venue', '');
      await HomeWidget.updateWidget(
        name: 'UpcomingClassWidgetProvider',
        iOSName: 'UpcomingClassWidgetProvider',
      );
    }
  }

  String _getDayString(int weekday) {
    return [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ][weekday - 1];
  }

  Map<String, dynamic>? _getNextClass(List? todayClasses, DateTime now) {
    if (todayClasses == null || todayClasses.isEmpty) {
      return null;
    }

    for (final classItem in todayClasses) {
      final timeRange = classItem.keys.first;
      if (isClassUpcoming(timeRange, now)) {
        return classItem[timeRange];
      }
    }

    return null;
  }

  bool isClassUpcoming(String timeRange, DateTime now) {
    final timeFormatter = DateFormat('HH:mm');
    final timeParts = timeRange.split(' - ');
    final startTime = timeFormatter.parse(timeParts[0]);

    final nowTime = TimeOfDay.fromDateTime(now);
    final startTimeOfDay = TimeOfDay.fromDateTime(startTime);

    if (nowTime.hour < startTimeOfDay.hour ||
        (nowTime.hour == startTimeOfDay.hour &&
            nowTime.minute < startTimeOfDay.minute)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: updateWidget,
        child: Text('Update Widget'),
      ),
    );
  }
}
