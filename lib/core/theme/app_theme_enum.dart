import 'package:flutter/material.dart';

enum AppTheme {
  blue('Blue', Colors.blue),
  sakura('Sakura', Color.fromARGB(255, 252, 180, 241)),
  forest('Forest', Color(0xFFB2C5B3)),
  vapourWave('Vapour Wave', Color(0xFF1fc3ff)),
  nightfall('Nightfall', Color(0xFF0262A5)),
  cocoa('Cocoa', Color(0xFF6D4C41));

  final String displayName;
  final Color seedColor;

  const AppTheme(this.displayName, this.seedColor);
}
