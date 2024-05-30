import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vit_ap_student_app/pages/features/time_table_page.dart';
import 'package:vit_ap_student_app/pages/features/community_page.dart';
import 'package:vit_ap_student_app/pages/features/profile_page.dart';
import 'package:vit_ap_student_app/pages/features/home_page.dart';

class MyBNB extends StatefulWidget {
  const MyBNB({Key? key}) : super(key: key);

  @override
  _MyBNBState createState() => _MyBNBState();
}

int _currentIndex = 0; // This will keep track of the current tab

final List<Widget> _pages = [
  HomePage(),
  TimeTablePage(),
  CommunityPage(),
  ProfilePage(),
];

class _MyBNBState extends State<MyBNB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: GNav(
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            print(_currentIndex);
            _currentIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: "Home",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.calendar_month_outlined,
            text: "Time Table",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.language_outlined,
            text: "Community",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.person_outline,
            text: "Profile",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
