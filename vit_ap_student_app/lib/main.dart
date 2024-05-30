import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/getting_started_page.dart';
import 'pages/features/home_page.dart';
import 'pages/login_page.dart';
import 'pages/features/bottom_navigation_bar.dart';
import 'pages/features/profile_page.dart';
import 'utils/theme/themes.dart';
import 'pages/features/biometric_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // Initialize SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? isLoggedIn = prefs.getBool('isLoggedIn');

  // Determine initial route based on isLoggedIn value
  String initialRoute = isLoggedIn == true ? '/main' : '/gettingstarted';

  runApp(
    ProviderScope(
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      title: 'VIT-AP Student App',
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/main': (context) => const MyBNB(),
        '/home': (context) => HomePage(),
        '/gettingstarted': (context) => GettingStartedPage(),
        '/profile': (context) => ProfilePage(),
        '/biometric': (context) => BiometricPage(),
      },
    );
  }
}
