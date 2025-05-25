import 'package:flutter/material.dart';
import 'palette.dart';

// Define your light mode theme
ThemeData darkTheme = ThemeData(
  splashColor: darksplashColor,
  dialogBackgroundColor: darkdialogBackgroundColor,
  unselectedWidgetColor: darkunselectedWidgetColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: darkBG,
    primary: darkPrimary,
    secondary: darkSecondary,
    tertiary: darkTertiary,
  ),
  fontFamily: 'Poppins',
);

// Define your dark mode theme
ThemeData lightTheme = ThemeData(
  splashColor: lightsplashColor,
  dialogBackgroundColor: lightdialogBackgroundColor,
  unselectedWidgetColor: lightunselectedWidgetColor,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: lightBG,
    primary: lightPrimary,
    secondary: lightSecondary,
    tertiary: lightTertiary,
  ),
  fontFamily: 'Poppins',
);

ThemeData forestTheme = ThemeData(
  splashColor: forestsplashColor,
  dialogBackgroundColor: forestdialogBackgroundColor,
  unselectedWidgetColor: forestunselectedWidgetColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: forestBG,
    primary: forestPrimary,
    secondary: forestSecondary,
  ),
  fontFamily: 'Poppins',
);
ThemeData vaporWaveTheme = ThemeData(
  splashColor: vaporWavesplashColor,
  dialogBackgroundColor: vaporWavedialogBackgroundColor,
  unselectedWidgetColor: vaporWaveunselectedWidgetColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: vaporWaveBG,
    primary: vaporWavePrimary,
    secondary: vaporWaveSecondary,
  ),
  fontFamily: 'Poppins',
);
ThemeData lunarTheme = ThemeData(
  splashColor: lunarsplashColor,
  dialogBackgroundColor: lunardialogBackgroundColor,
  unselectedWidgetColor: lunarunselectedWidgetColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: lunarBG,
    primary: lunarPrimary,
    secondary: lunarSecondary,
  ),
  fontFamily: 'Poppins',
);
ThemeData sakuraTheme = ThemeData(
  splashColor: sakurasplashColor,
  dialogBackgroundColor: sakuradialogBackgroundColor,
  unselectedWidgetColor: sakuraunselectedWidgetColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: sakuraBG,
    primary: sakuraPrimary,
    secondary: sakuraSecondary,
  ),
  fontFamily: 'Poppins',
);
ThemeData monoTheme = ThemeData(
  splashColor: monosplashColor,
  dialogBackgroundColor: monodialogBackgroundColor,
  unselectedWidgetColor: monounselectedWidgetColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: monoBG,
    primary: monoPrimary,
    secondary: monoSecondary,
  ),
  fontFamily: 'Poppins',
);
