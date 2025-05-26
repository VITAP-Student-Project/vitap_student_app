import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/core/network/connection_checker.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/auth/view/widgets/my_semester_dropdown.dart';
import 'package:vit_ap_student_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:vit_ap_student_app/features/home/view/pages/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedSemSubID;
  late TapGestureRecognizer _tapRecognizer;
  bool _isObscure = false;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = _directToWebDocs;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _directToWebDocs() async {
    final Uri url =
        Uri.parse("https://udhay-adithya.github.io/vitap_app_website/#/docs");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  String _validateInput() {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty) return "Please fill in the username field";
    if (password.isEmpty) return "Please fill in the password field";
    if (selectedSemSubID == null || selectedSemSubID == 'Select Semester') {
      return "Please select a valid semester";
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) {
      return "Username cannot contain special characters";
    }

    return "true";
  }

  Future<void> _loginUser() async {
    final connectivityResult =
        await ConnectionCheckerImpl(InternetConnection()).isConnected;
    if (!connectivityResult) {
      showSnackBar(
        context,
        'Please check your internet connection',
        SnackBarType.error,
      );
      return;
    }

    final validationResult = _validateInput();
    if (validationResult != "true") {
      showSnackBar(context, validationResult, SnackBarType.error);
      return;
    }

    await ref.read(authViewModelProvider.notifier).loginUser(
          registrationNumber: usernameController.text.toUpperCase(),
          password: passwordController.text,
          semSubId: selectedSemSubID!,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (_) => false,
            );
          },
          error: (error, st) {
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login/login_bg.png"),
              fit: BoxFit.cover,
              opacity: 0.15,
              colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button and theme toggle
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        border: InputBorder.none,
                        hintText: 'Registration number',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 10),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.key),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              MySemesterDropDownWidget(
                onSelected: (value) {
                  setState(() {
                    selectedSemSubID = value;
                  });
                },
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 320,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                    ),
                    onPressed: isLoading ? null : _loginUser,
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Login'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 18.0),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    const TextSpan(
                        text: "Upon login you agree to VIT-AP Student App's "),
                    TextSpan(
                      text: "Privacy Policy ",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        color: Colors.blue,
                      ),
                      recognizer: _tapRecognizer,
                      mouseCursor: SystemMouseCursors.precise,
                    ),
                    const TextSpan(text: "and "),
                    TextSpan(
                      text: "Terms of Service",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        color: Colors.blue,
                      ),
                      recognizer: _tapRecognizer,
                      mouseCursor: SystemMouseCursors.precise,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
