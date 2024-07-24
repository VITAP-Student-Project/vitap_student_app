import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/pages/quick_access/mentor_page.dart';

import '../../../pages/quick_access/attendance_page.dart';
import '../../../pages/quick_access/biometric_page.dart';
import '../../../pages/quick_access/payments_page.dart';
import '../custom/my_icon_button.dart';

class MyBottomSheetContent extends StatefulWidget {
  const MyBottomSheetContent({super.key});

  @override
  State<MyBottomSheetContent> createState() => _MyBottomSheetContentState();
}

class _MyBottomSheetContentState extends State<MyBottomSheetContent> {
  Widget _buildIconTextButton({
    required IconData icon,
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
                  icon: Icons.pie_chart_outline_rounded,
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
                  icon: Icons.file_copy_outlined,
                  text: "PYQ",
                  onPressed: () async {
                    Uri _url = Uri.parse("https://vitap23-24pyqs.netlify.app/");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                ),
                _buildIconTextButton(
                  icon: Icons.insert_chart_outlined_rounded,
                  text: "Marks",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: Icons.my_library_books_outlined,
                  text: "Library",
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextButton(
                  icon: Icons.fingerprint_rounded,
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
                  icon: Icons.school_outlined,
                  text: "Exams",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: Icons.fact_check_outlined,
                  text: "NCGPA Rank",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: Icons.home_work_outlined,
                  text: "Outing",
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextButton(
                  icon: Icons.wifi_rounded,
                  text: "Wifi",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: Icons.how_to_reg_outlined,
                  text: "HOD and Dean",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: Icons.boy_rounded,
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
                  icon: Icons.payment_rounded,
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
