import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/pages/bottom_navigation_bar.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatelessWidget {
  // Function to asynchronously load the image from base64
  Future<ImageProvider> loadImage() async {
    // Replace 'your_image_base64_string' with the actual base64 string fetched from the API
    String base64String =
        '''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''';

    // Decode the base64 string to bytes
    List<int> bytes = base64.decode(base64String);

    // Create an ImageProvider from the decoded bytes
    return MemoryImage(Uint8List.fromList(bytes));
  }

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
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Image.asset(
                    r"assets/images/login_img.png",
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
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
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.visibility_off_outlined),
                                suffixIconColor:
                                    Color.fromRGBO(167, 163, 255, 1),
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
              // FutureBuilder to asynchronously load the image
              FutureBuilder<ImageProvider>(
                future: loadImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the image to load, display a shimmer loading animation
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.hasError || snapshot.data == null) {
                    // If there's an error loading the image, display an error message
                    return Text('Error loading image');
                  } else {
                    // If the image is loaded successfully, display it
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
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
