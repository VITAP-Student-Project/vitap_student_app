import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/pages/quick_access/mentor_page.dart';
import 'package:vit_ap_student_app/pages/quick_access/wifi_page.dart';

import '../../../pages/quick_access/attendance_page.dart';
import '../../../pages/quick_access/biometric_page.dart';
import '../../../pages/quick_access/outing_page.dart';
import '../../../pages/quick_access/payments_page.dart';
import '../custom/my_icon_button.dart';

class MyBottomSheetContent extends StatefulWidget {
  const MyBottomSheetContent({super.key});

  @override
  State<MyBottomSheetContent> createState() => _MyBottomSheetContentState();
}

class _MyBottomSheetContentState extends State<MyBottomSheetContent> {
  Widget _buildIconTextButton({
    required String icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return IconTextButton(
      iconBackgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      icon: icon,
      text: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextButton(
                  icon: 'calendar',
                  text: "Attendance",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: MyAttendancePage(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: 'checklist',
                  text: "PYQ",
                  onPressed: () async {
                    Uri _url = Uri.parse("https://vitap23-24pyqs.netlify.app/");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                ),
                _buildIconTextButton(
                  icon: 'deadline',
                  text: "Marks",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: 'digital-library',
                  text: "Library",
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextButton(
                  icon: 'finger-print',
                  text: "Biometric",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: BiometricPage(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: 'exam',
                  text: "Exams",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: OutingPage(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: 'curriculum',
                  text: "Curriculum",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: 'bus',
                  text: "Outing",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: OutingPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextButton(
                  icon: 'wifi',
                  text: "Wifi",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: WifiPage(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: 'leader',
                  text: "HOD and Dean",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: 'consultant',
                  text: "Mentor Details",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: MyMentorPage(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: 'atm-card',
                  text: "Payments",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: MyPaymentsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
