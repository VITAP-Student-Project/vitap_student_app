import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/theme/app_theme_enum.dart';

ThemeData getThemeData({
  required AppTheme appTheme,
  required bool isDarkMode,
}) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: appTheme.seedColor,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    ),
    fontFamily: 'Poppins',
  );
}

// Legacy support - keeping these for backward compatibility
final ThemeData lightTheme = getThemeData(
  appTheme: AppTheme.blue,
  isDarkMode: false,
);

final ThemeData darkTheme = getThemeData(
  appTheme: AppTheme.blue,
  isDarkMode: true,
);
