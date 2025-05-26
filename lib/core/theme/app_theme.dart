import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/constants/%20color_scheme.dart';

// Dark Mode Theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: darkBG,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: Colors.black,
    secondary: darkSecondary,
    onSecondary: Colors.white,
    tertiary: darkTertiary,
    onTertiary: darkOnTertiary,
    error: darkError,
    onError: darkOnError,
    surface: darkBG,
    onSurface: darkOnSurface,
    outline: darkOutline,
    inverseSurface: darkInverseSurface,
    onInverseSurface: darkBG,
    surfaceTint: darkPrimary,
  ),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: TextStyle(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
    labelLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
    labelSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
  ),
);

// Light Mode Theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: lightBG,
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: lightPrimary,
    onPrimary: Colors.white,
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    tertiary: lightTertiary,
    onTertiary: lightOnTertiary,
    error: lightError,
    onError: lightOnError,
    surface: lightBG,
    onSurface: lightOnSurface,
    outline: lightOutline,
    inverseSurface: lightInverseSurface,
    onInverseSurface: lightOnInverseSurface,
    surfaceTint: lightPrimary,
  ),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    titleSmall: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: TextStyle(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: TextStyle(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
    labelLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    labelSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
  ),
);
