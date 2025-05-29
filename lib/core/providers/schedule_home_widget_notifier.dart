import 'dart:convert';
import 'dart:developer';
import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';

part 'schedule_home_widget_notifier.g.dart';

@Riverpod(keepAlive: true)
class ScheduleHomeWidgetNotifier extends _$ScheduleHomeWidgetNotifier {
  @override
  Timetable? build() {
    final user = ref.read(currentUserNotifierProvider);
    return user?.timetable.target;
  }

  Future<void> saveTimetable(Timetable timetableData) async {
    try {
      await HomeWidget.saveWidgetData<String>(
        'timetable',
        json.encode(timetableData.toJson()),
      );
      state = timetableData;
    } catch (e, stackTrace) {
      log('Error saving timetable: $e');
      log('Stack trace: $stackTrace');
    }
  }

  Future<void> updateWidget() async {
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

  Future<void> initializeTimetable() async {
    final user = ref.read(currentUserNotifierProvider);
    final timetable = user?.timetable.target;

    if (user == null || timetable == null) return;

    await saveTimetable(timetable);
    await updateWidget();
  }

  Future<void> forceRefresh() async {
    await initializeTimetable();
  }

  /// Clears saved timetable data from the widget storage
  Future<void> clearTimetable() async {
    try {
      await HomeWidget.saveWidgetData<String>('timetable', '');
      state = null;
    } catch (e, stackTrace) {
      log('Error clearing timetable: $e');
      log('Stack trace: $stackTrace');
    }
  }

  /// For testing and internal use: reads the saved timetable from widget storage
  Future<Timetable?> readSavedTimetable() async {
    try {
      final jsonString = await HomeWidget.getWidgetData<String>('timetable');
      if (jsonString == null || jsonString.isEmpty) return null;
      return Timetable.fromJson(json.decode(jsonString));
    } catch (e, stackTrace) {
      log('Error reading saved timetable: $e');
      log('Stack trace: $stackTrace');
      return null;
    }
  }
}
