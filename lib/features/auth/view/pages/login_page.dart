import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:vit_ap_student_app/core/common/widget/bottom_navigation_bar.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/network/connection_checker.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/launch_web.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/core/utils/theme_switch_button.dart';
import 'package:vit_ap_student_app/core/common/widget/auth_field.dart';
import 'package:vit_ap_student_app/features/auth/view/pages/semester_selection_page.dart';
import 'package:vit_ap_student_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:vit_ap_student_app/features/auth/viewmodel/semester_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () => directToWeb("https://vitap.udhay-adithya.me");

    // Log login page view
    AnalyticsService.logScreen('LoginPage');
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  Future<void> _fetchSemestersAndNavigate() async {
    final connectivityResult =
        await ConnectionCheckerImpl(InternetConnection()).isConnected;
    if (!connectivityResult) {
      showSnackBar(
        context,
        'Please check your internet connection',
        SnackBarType.error,
      );
      AnalyticsService.logError(
          'connectivity_error', 'No internet connection during login');
      return;
    }

    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      AnalyticsService.logError(
          'validation_error', 'Login form validation failed');
      return;
    }

    // Log semester fetch attempt
    AnalyticsService.logEvent('semester_fetch_attempt', {
      'username': usernameController.text.toUpperCase(),
    });

    await ref.read(semesterViewModelProvider.notifier).fetchSemesters(
          registrationNumber: usernameController.text.toUpperCase(),
          password: passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        semesterViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      semesterViewModelProvider,
      (_, next) {
        next?.when(
          data: (semesters) {
            AnalyticsService.logEvent('semester_fetch_success', {
              'semester_count': semesters.length,
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SemesterSelectionPage(
                  semesters: semesters,
                  registrationNumber: usernameController.text.toUpperCase(),
                  password: passwordController.text,
                ),
              ),
            );
          },
          error: (error, st) {
            AnalyticsService.logEvent('semester_fetch_failed', {
              'error_message': error.toString(),
            });
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
          loading: () {},
        );
      },
    );

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            AnalyticsService.logEvent('login_complete', {
              'user_id': data.profile.target?.applicationNumber ?? 'unknown',
            });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
              (_) => false,
            );
          },
          error: (error, st) {
            AnalyticsService.logEvent('login_error', {
              'error_message': error.toString(),
            });
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        actions: [ThemeSwitchButton()],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Welcome",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Sign in with your VTOP credentials to continue",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            Flexible(child: SizedBox.expand()),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthField(
                    title: "Username",
                    hintText: "VTOP Username",
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  AuthField(
                    title: "Password",
                    hintText: "VTOP Password",
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      minimumSize:
                          Size(MediaQuery.sizeOf(context).width - 100, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            AnalyticsService.logButtonTap(
                                'continue_login', 'login_page');
                            _fetchSemestersAndNavigate();
                          },
                    child: isLoading
                        ? const SizedBox(width: 24, height: 24, child: Loader())
                        : const Text('Continue'),
                  ),
                ],
              ),
            ),
            Flexible(child: SizedBox.expand()),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 36.0, horizontal: 18.0),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                      text: "Upon login you agree to VITAP Student App's ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: "Privacy Policy ",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer: _tapRecognizer,
                      mouseCursor: SystemMouseCursors.precise,
                    ),
                    TextSpan(
                      text: "and ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer: _tapRecognizer,
                      mouseCursor: SystemMouseCursors.precise,
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
