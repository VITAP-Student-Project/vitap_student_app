import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final timetableProvider =
    StateNotifierProvider<TimetableNotifier, Map<String, dynamic>>((ref) {
  return TimetableNotifier();
});

class TimetableNotifier extends StateNotifier<Map<String, dynamic>> {
  TimetableNotifier() : super({}) {
    _loadTimetable();
  }

  Future<void> _loadTimetable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? timetableString = prefs.getString('timetable');
  }

  void updateTimetable(Map<String, dynamic> newTimetable) {
    state = newTimetable;
  }
}
