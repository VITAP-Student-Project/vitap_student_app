import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/theme/app_theme.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

part 'theme_mode_notifier.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeData build() {
    // Get user preferences to determine initial theme
    final userPreferences = ref.read(userPreferencesNotifierProvider);

    // Return theme based on user preference, default to light if not
    return userPreferences.isDarkModeEnabled ? darkTheme : lightTheme;
  }

  Future<void> toggleTheme() async {
    final currentPreferences = ref.read(userPreferencesNotifierProvider);
    final newThemeMode = !currentPreferences.isDarkModeEnabled;

    AnalyticsService.logEvent('theme_toggled', {
      'from_theme': currentPreferences.isDarkModeEnabled ? 'dark' : 'light',
      'to_theme': newThemeMode ? 'dark' : 'light',
      'timestamp': DateTime.now().toIso8601String(),
    });

    final updatedPreferences = currentPreferences.copyWith(
      isDarkModeEnabled: newThemeMode,
    );
    await ref
        .read(userPreferencesNotifierProvider.notifier)
        .updatePreferences(updatedPreferences);

    state = newThemeMode ? darkTheme : lightTheme;
  }
}
