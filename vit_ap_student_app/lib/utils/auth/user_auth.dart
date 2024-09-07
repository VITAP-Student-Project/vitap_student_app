import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/pages/features/bottom_navigation_bar.dart';

import '../../pages/onboarding/onboarding_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred!'));
        } else if (snapshot.hasData && snapshot.data == true) {
          return MyBNB();
        } else {
          return GettingStartedPage();
        }
      },
    );
  }
}
