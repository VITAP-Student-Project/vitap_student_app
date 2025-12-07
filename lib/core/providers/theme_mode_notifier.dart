import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/theme/app_theme.dart';
import 'package:vit_ap_student_app/core/theme/app_theme_enum.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

part 'theme_mode_notifier.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeData build() {
    // Get user preferences to determine initial theme
    final userPreferences = ref.read(userPreferencesNotifierProvider);

    // Parse theme from string, default to blue if invalid or null
    AppTheme selectedTheme;
    try {
      selectedTheme = AppTheme.values.firstWhere(
        (t) => t.name == (userPreferences.appTheme ?? 'blue'),
        orElse: () => AppTheme.blue,
      );
    } catch (e) {
      selectedTheme = AppTheme.blue;
    }

    // Return theme based on user preference
    return getThemeData(
      appTheme: selectedTheme,
      isDarkMode: userPreferences.isDarkModeEnabled,
    );
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

    // Rebuild theme with new mode
    ref.invalidateSelf();
  }

  Future<void> setAppTheme(AppTheme theme) async {
    final currentPreferences = ref.read(userPreferencesNotifierProvider);

    AnalyticsService.logEvent('app_theme_changed', {
      'from_theme': currentPreferences.appTheme ?? 'blue',
      'to_theme': theme.name,
      'timestamp': DateTime.now().toIso8601String(),
    });

    final updatedPreferences = currentPreferences.copyWith(
      appTheme: theme.name,
    );
    await ref
        .read(userPreferencesNotifierProvider.notifier)
        .updatePreferences(updatedPreferences);

    // Rebuild theme with new color
    ref.invalidateSelf();
  }
}
