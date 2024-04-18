import 'package:flutter/material.dart';

// Define your light mode theme
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: const Color.fromARGB(255, 255, 255, 255),
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
  ),
  // Specify Poppins font family for the entire app
  fontFamily: 'Poppins',
);

// Define your dark mode theme
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
  // Specify Poppins font family for the entire app
  fontFamily: 'Poppins',
);
