import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/provider/student_provider.dart';
import '../../widgets/custom/my_snackbar.dart';
import '../../widgets/timetable/my_semester_dropdown.dart';
import '../../utils/provider/theme_provider.dart';
import '../onboarding/pfp_page.dart';
import 'bottom_navigation_bar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedSemSubID;
  bool _isObscure = true;
  late TapGestureRecognizer _tapRecognizer;

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

    if (username.isEmpty) {
      return "Make sure that you fill the username field";
    } else if (password.isEmpty) {
      return "Make sure that you fill the password field";
    } else if (selectedSemSubID == null ||
        selectedSemSubID == 'Select Semester') {
      return "Make sure that you select a valid semester";
    }

    final validUsernamePattern = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validUsernamePattern.hasMatch(username)) {
      return "Make sure that username does not contain any special character";
    }

    return "true";
  }

  Future<void> _loginUser() async {
    // Input validation
    final validationResult = _validateInput();
    if (validationResult != "true") {
      _showSnackBar(
        title: 'Oops!',
        message: validationResult,
        contentType: ContentType.warning,
      );
      return;
    }

    // Attempt login
    await ref.read(studentProvider.notifier).studentLogin(
          usernameController.text.toUpperCase(),
          passwordController.text,
          selectedSemSubID!,
          ref,
        );
  }

  void _showSnackBar({
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = MySnackBar(
      title: title,
      message: message,
      contentType: contentType,
    ).build(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar as SnackBar);
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 0.25,
              opacity: 0.15,
              image: const AssetImage("assets/images/login/login_bg.png"),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black12,
                BlendMode.darken,
              ),
            ),
          ),
          child: studentState.when(data: (student) {
            if (student.isLoggedIn) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBNB()),
                  (route) => false,
                );
              });
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              type: PageTransitionType.fade,
                              child: MyProfilePicScreen(
                                instructionText:
                                    "Choose a profile picture that best represents you. You can change it anytime from your profile settings.",
                                nextPage: const LoginPage(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: Colors.blue),
                        label: const Text(
                          "Back",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        icon: Icon(
                          ref.watch(themeModeProvider) == AppThemeMode.dark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                        ),
                        onPressed: () {
                          final currentTheme = ref.read(themeModeProvider);
                          final newTheme = currentTheme == AppThemeMode.dark
                              ? AppThemeMode.light
                              : AppThemeMode.dark;
                          ref
                              .read(themeModeProvider.notifier)
                              .setThemeMode(newTheme);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 8,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(student.pfpPath),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width / 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 8),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
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
                                prefixIcon:
                                    const Icon(Icons.person_outline_rounded),
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
                    ],
                  ),
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
                      onPressed: studentState.isLoading ? null : _loginUser,
                      child: studentState.isLoading
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
                          text:
                              "Upon login you agree to VIT-AP Student App's "),
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
            );
          }, error: (error, _) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Error: $error $_"),
                      backgroundColor: Colors.redAccent.shade200,
                    ),
                  );
              },
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}
