import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/core/common/widget/bottom_navigation_bar.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/auth/viewmodel/auth_viewmodel.dart';

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
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showSnackBar(
        title: 'Oops',
        message: 'Please check your internet connection',
        contentType: ContentType.failure,
      );
      return;
    }

    final validationResult = _validateInput();
    if (validationResult != "true") {
      _showSnackBar(
        title: 'Validation Error',
        message: validationResult,
        contentType: ContentType.warning,
      );
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
            showSnackBar(context, error.toString());
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
              // Rest of your UI components
              Center(
                child: SizedBox(
                  height: 60,
                  width: 320,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _loginUser,
                    child: isLoading
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : const Text('Login'),
                  ),
                ),
              ),
              // Privacy policy text
            ],
          ),
        ),
      ),
    );
  }
}
