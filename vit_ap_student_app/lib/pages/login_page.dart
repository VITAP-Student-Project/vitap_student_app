import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your login form elements go here
              Center(
                child: Image.asset(r"assets/images/login_img.png"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, left: 20),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter registration number',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(167, 163, 255, 1))),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter password',
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(167, 163, 255, 1),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter captcha',
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(167, 163, 255, 1),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Center(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                  height: 60,
                  minWidth: 250,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text('Login'),
                  color: Color.fromRGBO(77, 71, 195, 1),
                  textColor: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
