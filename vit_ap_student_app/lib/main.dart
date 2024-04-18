import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/pages/getting_started_page.dart';
import 'package:vit_ap_student_app/pages/login_page.dart';
import 'package:vit_ap_student_app/pages/home.dart';
import 'package:vit_ap_student_app/utils/theme/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      title: 'Home Page',
      initialRoute: '/gettingstarted',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/gettingstarted': (context) => GettingStartedPage(),
        // Add routes for other pages here
      },
    );
  }
}
