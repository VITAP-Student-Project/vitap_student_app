import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/themes.dart';

enum AppThemeMode { light, dark, system }

final themeModeProvider = StateProvider<AppThemeMode>((ref) => AppThemeMode.system);

final themeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  switch (themeMode) {
    case AppThemeMode.light:
      return lightTheme;
    case AppThemeMode.dark:
      return darkTheme;
    case AppThemeMode.system:
    default:
      final brightness = PlatformDispatcher.instance.platformBrightness;
      return brightness == Brightness.dark ? darkTheme : lightTheme;
  }
});
