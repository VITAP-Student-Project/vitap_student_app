import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/models/widgets/custom/my_icon_button.dart';
import '../../../pages/quick_access/attendence_page.dart';
import '../../../pages/quick_access/biometric_page.dart';
import 'my_bottom_sheet.dart';

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
                        Uri _url =
                            Uri.parse("https://vitap23-24pyqs.netlify.app/");
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
                      text: "Marks",
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            showBottomSheet(
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
