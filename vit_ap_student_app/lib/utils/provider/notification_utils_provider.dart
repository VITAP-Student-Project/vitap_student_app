// Class Slider Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassSliderNotifier extends StateNotifier<double> {
  ClassSliderNotifier() : super(5.0) {
    _loadUpdateSlider();
  } // Initial value for the slider

  Future<void> _loadUpdateSlider() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getDouble('classNotificationDelay') ?? 5; // Default to true
  }

  Future<void> updateSliderDelay(double newValue) async {
    state = newValue;
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('classNotificationDelay', newValue);
  }
}

final classNotificationSliderProvider =
    StateNotifierProvider<ClassSliderNotifier, double>(
        (ref) => ClassSliderNotifier());

// Class Notification Provider
class ClassNotificationNotifier extends StateNotifier<bool> {
  ClassNotificationNotifier() : super(true) {
    _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    state =
        prefs.getBool('classNotificationEnabled') ?? true; // Default to true
  }

  Future<void> toggleNotification(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('classNotificationEnabled', value);
  }
}

final classNotificationProvider =
    StateNotifierProvider<ClassNotificationNotifier, bool>(
        (ref) => ClassNotificationNotifier());

class ExamSliderNotifier extends StateNotifier<double> {
  ExamSliderNotifier() : super(5.0) {
    _loadUpdateSlider();
  } // Initial value for the slider

  Future<void> _loadUpdateSlider() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getDouble('examNotificationDelay') ?? 5; // Default to true
  }

  Future<void> updateSliderDelay(double newValue) async {
    state = newValue;
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('examNotificationDelay', newValue);
  }
}

final examNotificationSliderProvider =
    StateNotifierProvider<ExamSliderNotifier, double>(
        (ref) => ExamSliderNotifier());

// Exam Notification Provider
class ExamNotificationNotifier extends StateNotifier<bool> {
  ExamNotificationNotifier() : super(true) {
    _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('examNotificationEnabled') ?? true; // Default to true
  }

  Future<void> toggleNotification(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('examNotificationEnabled', value);
  }
}

final examNotificationProvider =
    StateNotifierProvider<ExamNotificationNotifier, bool>(
        (ref) => ExamNotificationNotifier());
