import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vit_ap_student_app/pages/getting_started_page.dart';
import 'package:vit_ap_student_app/pages/home_page.dart';
import 'package:vit_ap_student_app/pages/login_page.dart';
import 'package:vit_ap_student_app/pages/bottom_navigation_bar.dart';
import 'package:vit_ap_student_app/utils/theme/themes.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      title: 'VIT-AP Student App',
      initialRoute: '/gettingstarted',
      routes: {
        '/login': (context) => LoginPage(),
        '/main': (context) => MainPage(),
        '/home': (context) => HomePage(),
        '/gettingstarted': (context) => GettingStartedPage(),
        // Add routes for other pages here
      },
    );
  }
}
