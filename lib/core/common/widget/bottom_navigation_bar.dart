import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/account/view/pages/account_page.dart';
import 'package:vit_ap_student_app/features/attendance/view/pages/attendance_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/home_page.dart';
import 'package:wiredash/wiredash.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex = widget.initialIndex;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Wiredash.of(context).showPromoterSurvey(
        options: const PsOptions(
          frequency: Duration(days: 30),
          initialDelay: Duration(days: 5),
          minimumAppStarts: 12,
        ),
      );
    });
  }

  List<Widget> _buildPages() {
    return [
      const HomePage(),
      const AttendancePage(),
      const AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: _buildPages()[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            log("Home page selected");
          } else if (index == 1) {
            log("Attendance page selected");
          } else if (index == 2) {
            log("Profile page selected");
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: const Icon(Iconsax.home),
            ),
            activeIcon: Container(
              height: 40,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: const Icon(Iconsax.home),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: const Icon(Iconsax.document),
            ),
            activeIcon: Container(
              height: 40,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: const Icon(Iconsax.document),
            ),
            label: "Attendance",
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: const Icon(Iconsax.user),
            ),
            label: "Profile",
            activeIcon: Container(
              height: 40,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: const Icon(Iconsax.user),
            ),
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
