import 'package:flutter/material.dart';

// Define your light mode theme
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color.fromARGB(255, 255, 255, 255),
    primary: const Color.fromARGB(255, 255, 255, 255),
    inversePrimary: Color.fromRGBO(18, 18, 20, 1),
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
    inversePrimary: Color.fromRGBO(255, 255, 255, 1),
    secondary: Colors.grey.shade700,
  ),
  // Specify Poppins font family for the entire app
  fontFamily: 'Poppins',
);
