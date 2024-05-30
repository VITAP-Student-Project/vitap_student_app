import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/pages/features/bottom_navigation_bar.dart';
import 'package:vit_ap_student_app/utils/api/login_api.dart';

import '../models/widgets/my_semester_dropdown.dart';

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
                    ))),
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
                          backgroundImage:
                              AssetImage('assets/images/profile_image.jpg'),
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
                        color: Colors.white,
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
                          width: 320, // Set the width of the container
                          height: 60, // Set the height of the container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                9), // Adjust the radius as needed
                            color: Color.fromRGBO(240, 239, 255,
                                1), // Set the background color of the box
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: usernameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Registration number',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          width: 320, // Set the width of the container
                          height: 60, // Set the height of the container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                9), // Adjust the radius as needed
                            color: Color.fromRGBO(240, 239, 255,
                                1), // Set the background color of the box
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.visibility_off_outlined),
                                  suffixIconColor: Colors.black87,
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
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
                      color: Colors.black87,
                      textColor: Color.fromRGBO(255, 255, 255, 1),
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
