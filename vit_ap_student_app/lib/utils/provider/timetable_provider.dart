import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final timetableProvider =
    StateNotifierProvider<TimetableNotifier, Map<String, dynamic>>((ref) {
  return TimetableNotifier();
});

class TimetableNotifier extends StateNotifier<Map<String, dynamic>> {
  TimetableNotifier() : super({}) {
    loadTimetable();
  }

  Future<void> loadTimetable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? timetableString = prefs.getString('timetable');
    if (timetableString != null) {
      Map<String, dynamic> timetableMap = json.decode(timetableString);
      state = timetableMap;
    } else {
      state = {"timetable": {}};
    }
  }

  Future<void> updateTimetable(Map<String, dynamic> newTimetable) async {
    state = newTimetable;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String timetableString = json.encode(newTimetable);
    await prefs.setString('timetable', timetableString);
  }
}
