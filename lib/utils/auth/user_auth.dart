import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/pages/features/bottom_navigation_bar.dart';

import '../../pages/onboarding/onboarding_page.dart';
import '../provider/student_provider.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);
    return Scaffold(
      body: studentState.when(data: (student) {
        final bool isLoggedIn = student.isLoggedIn;

        return isLoggedIn ? MyBNB() : GettingStartedPage();
      }, error: (error, _) {
        return Center(child: Text("Error Occured: ${error.toString()}"));
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
