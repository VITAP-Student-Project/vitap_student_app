import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vit_ap_student_app/pages/time_table_page.dart';
import 'package:vit_ap_student_app/pages/community_page.dart';
import 'package:vit_ap_student_app/pages/profile_page.dart';
import 'package:vit_ap_student_app/pages/home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

int _currentIndex = 0; // This will keep track of the current tab

final List<Widget> _pages = [
  TimeTablePage(),
  MainPage(),
  CommunityPage(),
  ProfilePage(),
];

class _HomePageState extends State<HomePage> {
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
            icon: Icons.calendar_month_outlined,
            text: "Time Table",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.home_outlined,
            text: "Home",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.polyline_outlined,
            text: "Community",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.person_outline,
            text: "Profile",
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
