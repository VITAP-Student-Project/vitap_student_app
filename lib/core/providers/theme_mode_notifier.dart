import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/theme/app_theme.dart';

class ThemeModeNotifier extends StateNotifier<ThemeData> {
  ThemeModeNotifier() : super(darkTheme);

  void toggleTheme() {
    state = state == lightTheme ? darkTheme : lightTheme;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeData>(
  (ref) => ThemeModeNotifier(),
);
