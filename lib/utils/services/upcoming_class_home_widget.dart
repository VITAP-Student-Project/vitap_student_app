import 'dart:convert';
import 'dart:developer';
import 'package:home_widget/home_widget.dart';

import '../model/timetable_model.dart';

class UpcomingClassHomeWidgetManager {
  static Future<void> saveTimetable(Timetable timetableData) async {
    try {
      // Store the entire timetable as a JSON string in HomeWidget
      await HomeWidget.saveWidgetData<String>(
          'timetable', json.encode(timetableData.toJson()));
    } catch (e, stackTrace) {
      log('Error saving timetable: $e');
      log('Stack trace: $stackTrace');
    }
  }

  static Future<void> updateWidget() async {
    try {
      await HomeWidget.updateWidget(
        name: 'UpcomingClassWidget',
        iOSName: 'UpcomingClassWidget',
        androidName: 'UpcomingClassWidget',
      );
    } catch (e, stackTrace) {
      log('Error updating widget: $e');
      log('Stack trace: $stackTrace');
    }
  }

  static Future<void> initializeTimetable(Timetable timetableData) async {
    await saveTimetable(timetableData);
    await updateWidget();
  }

  static Future<void> forceRefresh(Timetable timetableData) async {
    await initializeTimetable(timetableData);
  }
}
