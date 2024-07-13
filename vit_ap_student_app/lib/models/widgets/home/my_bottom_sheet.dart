import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../pages/quick_access/attendence_page.dart';
import '../../../pages/quick_access/biometric_page.dart';
import '../custom/my_icon_button.dart';

class MyBottomSheetContent extends StatefulWidget {
  const MyBottomSheetContent({super.key});

  @override
  State<MyBottomSheetContent> createState() => _MyBottomSheetContentState();
}

class _MyBottomSheetContentState extends State<MyBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyAttendancePage(),
                        ));
                  },
                  icon: Icons.pie_chart_outline_rounded,
                  text: "Attendence",
                ),
                IconTextButton(
                  onPressed: () async {
                    Uri _url = Uri.parse("https://vitap23-24pyqs.netlify.app/");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  icon: Icons.file_copy_outlined,
                  text: "PYQ",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.location_city_rounded,
                  text: "Outing",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.my_library_books_outlined,
                  text: "Library",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BiometricPage(),
                      ),
                    );
                  },
                  icon: Icons.fingerprint_rounded,
                  text: "Biometric",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.school_outlined,
                  text: "Exams",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.bar_chart,
                  text: "NCGPA Rank",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.bar_chart,
                  text: "Marks",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BiometricPage(),
                      ),
                    );
                  },
                  icon: Icons.how_to_reg_sharp,
                  text: "HOD",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.wifi_rounded,
                  text: "Wifi",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.bar_chart,
                  text: "Mentor Details",
                ),
                IconTextButton(
                  onPressed: () {},
                  icon: Icons.payment_rounded,
                  text: "Payments",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
