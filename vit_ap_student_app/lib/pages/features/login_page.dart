import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/pages/features/bottom_navigation_bar.dart';
import '../../models/widgets/timetable/my_semester_dropdown.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void clearControllers() {
    usernameController.clear();
    passwordController.text = "";
  }

  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImagePath();
  }

  Future<void> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath =
          prefs.getString('pfpPath') ?? 'assets/images/pfp/default.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
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
                image: AssetImage("assets/images/login_bg.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
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
                    padding:
                        const EdgeInsets.only(top: 100, left: 25, right: 10),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(_profileImagePath ??
                              'assets/images/pfp/default.jpg'),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            iconSize: 30,
                            onPressed: () {},
                            icon: Icon(Icons.mode_edit_outline_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 4,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      top: 8,
                    ),
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
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          width: 320,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Theme.of(context)
                                .colorScheme
                                .background, // Set the background color of the box
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 5),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: usernameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_rounded),
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
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 5),
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.visibility_off_outlined),
                                  suffixIconColor:
                                      Theme.of(context).colorScheme.primary,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.key),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      MySemesterDropDownWidget(),
                    ],
                  ),
                ),
                Center(
                  child: Consumer(builder: (context, ref, child) {
                    return MaterialButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyBNB()),
                        );
                      },
                      height: 60,
                      minWidth: 320,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text('Login'),
                      color: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.primary,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
