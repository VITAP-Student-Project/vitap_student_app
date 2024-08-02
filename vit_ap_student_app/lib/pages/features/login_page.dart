import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/widgets/custom/my_snackbar.dart';
import '../../models/widgets/timetable/my_semester_dropdown.dart';
import '../../utils/provider/providers.dart';
import '../../utils/state/login_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<String?> selectedSemSubID = ValueNotifier<String?>(null);
  String? _profileImagePath;
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);
  final ImageProvider _backgroundImage =
      const AssetImage("assets/images/login_bg.jpg");

  @override
  void initState() {
    super.initState();
    _loadProfileImagePath();
  }

  Future<void> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath =
          prefs.getString('pfpPath') ?? 'assets/images/pfp/default.png';
    });
  }

  Future<void> _precacheBackgroundImage() async {
    await precacheImage(_backgroundImage, context);
  }

  void clearControllers() {
    usernameController.clear();
    passwordController.clear();
  }

  String validateInput() {
    final username = usernameController.text;
    final password = passwordController.text;
    final semSubID = selectedSemSubID.value;

    if (username.isEmpty || username == "") {
      return "Make sure that you fill the username field";
    } else if (password.isEmpty || password == "") {
      return "Make sure that you fill the password field";
    } else if (semSubID == null || semSubID == 'Select Semester') {
      return "Make sure that you select a valid semester";
    }

    final validUsernamePattern = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validUsernamePattern.hasMatch(username)) {
      return "Make sure that username does not contain any special character";
    }

    return "true";
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      body: FutureBuilder(
        future: _precacheBackgroundImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Colors.black26,
                    Colors.black12,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ).createShader(bounds),
                blendMode: BlendMode.darken,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _backgroundImage,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.black12,
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 100, left: 25, right: 10),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(_profileImagePath ??
                                'assets/images/pfp/default.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width / 4),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 8),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                width: 320,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 5),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                          Icons.person_outline_rounded),
                                      border: InputBorder.none,
                                      hintText: 'Registration number',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                width: 320,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 5),
                                  child: ValueListenableBuilder(
                                    valueListenable: _isObscure,
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        controller: passwordController,
                                        obscureText: value,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              value
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                            ),
                                            onPressed: () {
                                              _isObscure.value =
                                                  !_isObscure.value;
                                            },
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(Icons.key),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            ValueListenableBuilder<String?>(
                              valueListenable: selectedSemSubID,
                              builder: (context, value, child) {
                                return MySemesterDropDownWidget(
                                  onSelected: (value) {
                                    selectedSemSubID.value = value;
                                    log('${selectedSemSubID.value}');
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: loginState.status == LoginStatus.loading
                            ? const CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () {
                                  String validationResult = validateInput();
                                  log('Input validation done');
                                  if (validationResult == "true") {
                                    ref.read(loginProvider.notifier).login(
                                        usernameController.text,
                                        passwordController.text,
                                        selectedSemSubID.value!,
                                        context);
                                    log('${selectedSemSubID.value}');
                                  } else {
                                    final snackBar = MySnackBar(
                                      title: 'Oops!',
                                      message: validationResult,
                                      contentType: ContentType.warning,
                                    ).build(context);

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar as SnackBar);
                                  }
                                },
                                height: 60,
                                minWidth: 320,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                color: Theme.of(context).colorScheme.secondary,
                                textColor:
                                    Theme.of(context).colorScheme.primary,
                                child: const Text('Login'),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
