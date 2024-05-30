import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/models/widgets/my_icon_button.dart';

import '../../pages/features/biometric_page.dart';

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
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextButton(
                      onPressed: () {},
                      icon: Icons.pie_chart_outline_rounded,
                      text: "Attendence",
                    ),
                    IconTextButton(
                      onPressed: () {},
                      icon: Icons.file_copy_outlined,
                      text: "PYQ",
                    ),
                    IconTextButton(
                      onPressed: () {},
                      icon: Icons.location_city_rounded,
                      text: "Outing",
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
