import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/theme/app_theme_enum.dart';

ThemeData getThemeData({
  required AppTheme appTheme,
  required bool isDarkMode,
  bool isAmoled = false,
}) {
  // AMOLED only applies when dark mode is enabled
  final shouldApplyAmoled = isDarkMode && isAmoled;

  final colorScheme = ColorScheme.fromSeed(
    seedColor: appTheme.seedColor,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    surfaceTint: shouldApplyAmoled ? Colors.transparent : null,
  );

  final baseTheme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    // Google Sans is bundled as a multi-weight asset family (see pubspec.yaml).
    // Setting it here applies it to textTheme and primaryTextTheme while
    // preserving each slot's weight, and — unlike GoogleFonts.googleSansTextTheme
    // — every FontWeight (from copyWith or a bare TextStyle) resolves to the real
    // weight file instead of being synthetically bolded.
    fontFamily: 'Google Sans',
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        // Set the predictive back transitions for Android.
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    scaffoldBackgroundColor: shouldApplyAmoled
        ? Colors.black
        : colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: shouldApplyAmoled ? Colors.black : colorScheme.surface,
    ),
  );

  return baseTheme;
}

final ThemeData lightTheme = getThemeData(
  appTheme: AppTheme.blue,
  isDarkMode: false,
);

final ThemeData darkTheme = getThemeData(
  appTheme: AppTheme.blue,
  isDarkMode: true,
);
