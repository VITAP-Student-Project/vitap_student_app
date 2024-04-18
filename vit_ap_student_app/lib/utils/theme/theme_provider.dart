import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/utils/theme/themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
