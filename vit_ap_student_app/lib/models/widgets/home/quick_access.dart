import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/models/widgets/custom/my_icon_button.dart';
import 'package:vit_ap_student_app/pages/quick_access/exam_page.dart';
import '../../../pages/quick_access/attendance_page.dart';
import '../../../pages/quick_access/biometric_page.dart';
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
                            child: MyAttendancePage(),
                          ),
                        );
                      },
                      icon: 'calendar',
                      text: "Attendance",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () async {
                        Uri _url =
                            Uri.parse("https://vitap23-24pyqs.netlify.app/");
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      icon: 'checklist',
                      text: "PYQ",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                      icon: 'exam',
                      text: "Marks",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                      icon: 'digital-library',
                      text: "Library",
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
                            child: BiometricPage(),
                          ),
                        );
                      },
                      icon: 'finger-print',
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
                            child: MyExamSchedule(),
                          ),
                        );
                      },
                      icon: 'deadline',
                      text: "Exams",
                    ),
                    IconTextButton(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                      icon: 'bus',
                      text: "Outing",
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
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
