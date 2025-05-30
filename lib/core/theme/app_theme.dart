import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    brightness: Brightness.light,
  ),
  fontFamily: 'Poppins',
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    brightness: Brightness.dark,
  ),
  fontFamily: 'Poppins',
);
