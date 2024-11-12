import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/student_provider.dart';

class UpcomingClassWidget extends ConsumerStatefulWidget {
  const UpcomingClassWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UpcomingClassWidget> createState() =>
      _UpcomingClassWidgetState();
}

class _UpcomingClassWidgetState extends ConsumerState<UpcomingClassWidget> {
  Future<void> verifyWidgetData() async {
    final prefs = await SharedPreferences.getInstance();
    log('All SharedPreferences: ${prefs.getKeys()}');

    // Print the specific values we're interested in
    final nextClass = await HomeWidget.getWidgetData<String>('next_class');
    final facultyName = await HomeWidget.getWidgetData<String>('faculty_name');
    final venue = await HomeWidget.getWidgetData<String>('venue');
    final timing = await HomeWidget.getWidgetData<String>('class_timing');

    log('Direct SharedPreferences check:'
        '\nClass: $nextClass'
        '\nFaculty: $facultyName'
        '\nVenue: $venue'
        '\nTiming: $timing');
  }

  void updateWidget(AsyncValue<Map<String, dynamic>> timetableState) async {
    try {
      final now = DateTime.now();
      final day = _getDayString(now.weekday);

      if (timetableState.hasValue) {
        final todayClasses = timetableState.value![day] as List?;

        final nextClassData = _getNextClassWithTiming(todayClasses, now);
        log("Today's classes: $todayClasses");

        if (nextClassData != null) {
          final nextClass = nextClassData['classInfo'];
          final timing = nextClassData['timing'];

          // Use SharedPreferences directly
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('widget_next_class', nextClass['course_name']);
          await prefs.setString('widget_faculty_name', nextClass['faculty']);
          await prefs.setString('widget_venue', nextClass['venue']);
          await prefs.setString('widget_class_timing', timing);

          // Also save with HomeWidget for consistency
          await Future.wait([
            HomeWidget.saveWidgetData<String>(
                'next_class', nextClass['course_name']),
            HomeWidget.saveWidgetData<String>(
                'faculty_name', nextClass['faculty']),
            HomeWidget.saveWidgetData<String>('venue', nextClass['venue']),
            HomeWidget.saveWidgetData<String>('class_timing', timing)
          ]);

          log('Data saved to SharedPreferences and HomeWidget');

          await verifyWidgetData();

          final result = await HomeWidget.updateWidget(
            name: 'UpcomingClassWidget',
            iOSName: 'UpcomingClassWidget',
            androidName: 'UpcomingClassWidget',
          );

          log('Widget update result: $result');
        } else {
          // Handle no upcoming class case
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('widget_next_class', 'No upcoming class');
          await prefs.setString('widget_faculty_name', '');
          await prefs.setString('widget_venue', '');
          await prefs.setString('widget_class_timing', '');

          // Update widget
          await HomeWidget.updateWidget(
            name: 'UpcomingClassWidget',
            iOSName: 'UpcomingClassWidget',
            androidName: 'UpcomingClassWidget',
          );
        }
      }
    } catch (e, stackTrace) {
      log('Error updating widget: $e');
      log('Stack trace: $stackTrace');
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

  Map<String, dynamic>? _getNextClassWithTiming(
      List? todayClasses, DateTime now) {
    if (todayClasses == null || todayClasses.isEmpty) {
      return null;
    }

    for (final classItem in todayClasses) {
      final timeRange = classItem.keys.first;
      if (isClassUpcoming(timeRange, now)) {
        return {
          'classInfo': classItem[timeRange],
          'timing': timeRange,
        };
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
    final timetableState = ref.watch(studentProvider.notifier).timetableState;
    return Container(
      child: ElevatedButton(
        onPressed: () => updateWidget(timetableState),
        child: Text('Update Widget'),
      ),
    );
  }
}
