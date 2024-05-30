import 'package:flutter/material.dart';
// Define your light mode theme
ThemeData lightMode = ThemeData(
  splashColor: Color.fromARGB(255, 204, 204, 204),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color.fromARGB(255, 255, 255, 255),
    primary: const Color.fromARGB(255, 255, 255, 255),
    inversePrimary: Color.fromRGBO(18, 18, 20, 1),
    secondary: Colors.grey.shade200,
  ),

  fontFamily: 'Poppins',
);

// Define your dark mode theme
ThemeData darkMode = ThemeData(
  splashColor: Color.fromARGB(255, 41, 41, 41),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    inversePrimary: Color.fromRGBO(255, 255, 255, 1),
    secondary: Colors.grey.shade700,
  ),

  fontFamily: 'Poppins',
);

ThemeData forest = ThemeData();
ThemeData vaporWave = ThemeData();
ThemeData lunar = ThemeData();
ThemeData sakura = ThemeData();
ThemeData mono = ThemeData();