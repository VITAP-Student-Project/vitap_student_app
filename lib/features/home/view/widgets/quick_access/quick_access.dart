import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/home/view/pages/biometric_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/exam_schedule.dart';
import 'package:vit_ap_student_app/features/home/view/pages/faculty_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/grade_history_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/marks_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/outing/outing_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/payments_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/wifi_page.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/quick_access/gradient_icon.dart';

class QuickAccess extends StatefulWidget {
  const QuickAccess({super.key});

  @override
  State<QuickAccess> createState() => _MyQuickAccessState();
}

class _MyQuickAccessState extends State<QuickAccess> {
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
            color: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => BiometricPage(),
                          ),
                        );
                      },
                      icon: Iconsax.finger_scan_copy,
                      text: "Biometric",
                    ),
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => MarksPage(),
                          ),
                        );
                      },
                      icon: Iconsax.chart_square_copy,
                      text: "Marks",
                    ),
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => GradeHistoryPage(),
                          ),
                        );
                      },
                      icon: Iconsax.graph_copy,
                      text: "Grades",
                    ),
                    // TODO: Find a better place for this
                    // GradientIcon(
                    //   iconBackgroundColor:
                    //       Theme.of(context).colorScheme.primary,
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (builder) => MentorPage(),
                    //       ),
                    //     );
                    //   },
                    //   icon: Iconsax.user_square,
                    //   text: "Mentor",
                    // ),
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => ExamSchedulePage(),
                          ),
                        );
                      },
                      icon: Iconsax.calendar_2_copy,
                      text: "Exams",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => OutingPage(),
                          ),
                        );
                      },
                      icon: Iconsax.route_square_copy,
                      text: "Outing",
                    ),
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => PaymentsPage(),
                          ),
                        );
                      },
                      icon: Iconsax.receipt_item_copy,
                      text: "Payments",
                    ),
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => FacultiesPage(),
                          ),
                        );
                      },
                      icon: Iconsax.teacher_copy,
                      text: "Faculty",
                    ),
                    GradientIcon(
                      iconBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => WifiPage(),
                          ),
                        );
                      },
                      icon: Iconsax.wifi_square_copy,
                      text: "Wifi",
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
