import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/pages/login_page.dart';

class GettingStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(18, 18, 20, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  height: 300.0, // specify the height
                  width: 400.0, // specify the width
                  child: Image.asset(
                    r"assets\images\getting_started_img.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Text(
                "All-in-One Academic Awesomeness!",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 75,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                height: 60,
                minWidth: 250,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text('Get Started'),
                color: Color.fromRGBO(228, 228, 228, 1),
                textColor: Color.fromRGBO(18, 18, 20, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
