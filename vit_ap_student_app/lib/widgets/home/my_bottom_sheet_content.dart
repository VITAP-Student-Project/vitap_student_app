import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/pages/quick_access/faculties_page.dart';
import '../../pages/quick_access/marks_page.dart';
import '../../pages/quick_access/mentor_page.dart';
import '../../pages/quick_access/attendance_page.dart';
import '../../pages/quick_access/biometric_page.dart';
import '../../pages/quick_access/exam_schedule_page.dart';
import '../../pages/quick_access/outing_page.dart';
import '../../pages/quick_access/payments_page.dart';
import '../../pages/quick_access/wifi_page.dart';
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
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  icon: Icons.fact_check_outlined,
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
                  icon: Icons.grading_outlined,
                  text: "Marks",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: MarksPage(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: Icons.supervisor_account_outlined,
                  text: "Mentor",
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextButton(
                  icon: Icons.calendar_month_outlined,
                  text: "Exams",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: MyExamSchedule(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: Icons.home_work_outlined,
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
                _buildIconTextButton(
                  icon: Icons.my_library_books_outlined,
                  text: "Library",
                  onPressed: () async {
                    Uri _url = Uri.parse("http://172.18.8.72:8080/jspui/");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                ),
                _buildIconTextButton(
                  icon: Icons.wifi_outlined,
                  text: "Wi-Fi",
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconTextButton(
                  icon: Icons.badge_outlined,
                  text: "Faculty",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: FacultiesPage(),
                      ),
                    );
                  },
                ),
                _buildIconTextButton(
                  icon: Icons.assessment_outlined,
                  text: "Grades",
                  onPressed: () {},
                ),
                _buildIconTextButton(
                  icon: Icons.content_paste_search_rounded,
                  text: "PYQ",
                  onPressed: () async {
                    Uri _url = Uri.parse("https://vitap23-24pyqs.netlify.app/");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
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
