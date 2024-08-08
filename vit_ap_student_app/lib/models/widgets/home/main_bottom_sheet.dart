import 'package:flutter/material.dart';
import 'my_bottom_sheet_content.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../pages/quick_access/attendance_page.dart';
import '../../../pages/quick_access/biometric_page.dart';
import '../../../pages/quick_access/payments_page.dart';
import '../../../pages/quick_access/mentor_page.dart';
import '../custom/my_icon_button.dart';

class MainBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Theme.of(context).colorScheme.background,
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
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAttendancePage()),
                    );
                  },
                  icon: 'calendar',
                  text: "Attendance",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () async {
                    Uri _url = Uri.parse("https://vitap23-24pyqs.netlify.app/");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  icon: 'checklist',
                  text: "PYQ",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  icon: 'deadline',
                  text: "Marks",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
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
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BiometricPage()),
                    );
                  },
                  icon: 'finger-print',
                  text: "Biometric",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  icon: 'exam',
                  text: "Exams",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  icon: 'rank',
                  text: "NCGPA Rank",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    MyBottomSheetContentState? parentState = context
                        .findAncestorStateOfType<MyBottomSheetContentState>();
                    parentState
                        ?.navigateToPage(0); // Navigate to outing Bottom Sheet
                  },
                  icon: 'bus',
                  text: "Outing",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    MyBottomSheetContentState? parentState = context
                        .findAncestorStateOfType<MyBottomSheetContentState>();
                    parentState
                        ?.navigateToPage(2); // Navigate to Wi-Fi Bottom Sheet
                  },
                  icon: 'wifi',
                  text: "Wifi",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  icon: 'leader',
                  text: "HOD and Dean",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyMentorPage()),
                    );
                  },
                  icon: 'consultant',
                  text: "Mentor Details",
                ),
                IconTextButton(
                  iconBackgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPaymentsPage()),
                    );
                  },
                  icon: 'atm-card',
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
