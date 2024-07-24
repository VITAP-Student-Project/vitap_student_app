import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vit_ap_student_app/pages/features/time_table_page.dart';
import 'package:vit_ap_student_app/pages/features/community_page.dart';
import 'package:vit_ap_student_app/pages/features/profile_page.dart';
import 'package:vit_ap_student_app/pages/features/home_page.dart';

class MyBNB extends StatefulWidget {
  final int initialIndex;

  const MyBNB({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _MyBNBState createState() => _MyBNBState();
}

class _MyBNBState extends State<MyBNB> {
  late int _currentIndex = widget.initialIndex;
  final List<Widget> _pages = [
    HomePage(),
    TimeTablePage(),
    CommunityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _pages[_currentIndex],
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: "Home",
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.calendar_month_outlined,
            text: "Time Table",
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
          ),
          GButton(
            icon: Icons.language_outlined,
            text: "Community",
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          GButton(
            icon: Icons.person_outline,
            text: "Profile",
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
            ),
            gap: 3,
            iconColor: Theme.of(context).colorScheme.primary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
