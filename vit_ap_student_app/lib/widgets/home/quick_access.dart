import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/pages/quick_access/marks_page.dart';
import 'package:vit_ap_student_app/widgets/custom/my_icon_button.dart';
import 'package:vit_ap_student_app/pages/quick_access/exam_schedule_page.dart';
import '../../pages/quick_access/attendance_page.dart';
import '../../pages/quick_access/biometric_page.dart';
import '../../pages/quick_access/mentor_page.dart';
import '../../pages/quick_access/outing_page.dart';
import 'my_bottom_sheet_content.dart';

class MyQuickAccess extends StatefulWidget {
  const MyQuickAccess({super.key});

  @override
  State<MyQuickAccess> createState() => _MyQuickAccessState();
}

class _MyQuickAccessState extends State<MyQuickAccess> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
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
                      icon: Icons.fingerprint_rounded,
                      text: "Biometric",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
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
                      icon: Icons.fact_check_outlined,
                      text: "Attendance",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
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
                      icon: Icons.assessment_outlined,
                      text: "Marks",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
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
                      icon: Icons.supervisor_account_outlined,
                      text: "Mentor",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
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
                      icon: Icons.calendar_month_outlined,
                      text: "Exams",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
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
                      icon: Icons.home_work_outlined,
                      text: "Outing",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () async {
                        Uri _url = Uri.parse("http://172.18.8.72:8080/jspui/");
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      icon: Icons.my_library_books_outlined,
                      text: "Library",
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                context: context,
                                builder: (context) {
                                  return MyBottomSheetContent();
                                });
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          iconSize: 32,
                        ),
                        Text(
                          "More",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
