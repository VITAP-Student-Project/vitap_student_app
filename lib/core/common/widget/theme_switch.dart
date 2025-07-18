import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/providers/theme_mode_notifier.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(userPreferencesNotifierProvider).isDarkModeEnabled;
    final notifier = ref.read(themeModeNotifierProvider.notifier);

    return Switch.adaptive(
        value: isDark,
        onChanged: (value) {
          notifier.toggleTheme();
        });
  }
}
