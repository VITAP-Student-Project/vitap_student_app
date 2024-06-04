import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/pages/login_page.dart';

class GettingStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
              ),
              child: Center(
                child: Container(
                  // specify the height
                  width: 450.0, // specify the width
                  child: Image.asset(
                    r"assets/images/getting_started_img.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 110, top: 0, bottom: 0),
                  child: Text(
                    "All-in-One",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 56, top: 30, bottom: 0),
                  child: Text(
                    "Academic",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 152, top: 75, bottom: 0),
                  child: Text(
                    "Awesomeness!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                elevation: 8,
                height: 60,
                minWidth: 180,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Text('Get Started'),
                color: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
