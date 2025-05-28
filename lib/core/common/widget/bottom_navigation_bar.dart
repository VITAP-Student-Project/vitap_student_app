import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/providers/bottom_nav_provider.dart';
import 'package:vit_ap_student_app/features/account/view/pages/account_page.dart';
import 'package:vit_ap_student_app/features/attendance/view/pages/attendance_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/home_page.dart';
import 'package:vit_ap_student_app/features/timetable/view/pages/timetable_page.dart';
import 'package:wiredash/wiredash.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  List<Widget> _buildPages() {
    return const [
      HomePage(),
      TimetablePage(),
      AttendancePage(),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: _buildPages()[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon(context, Iconsax.home, 0),
            activeIcon: _buildActiveIcon(context, Iconsax.home, 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(context, Iconsax.calendar, 1),
            activeIcon: _buildActiveIcon(context, Iconsax.calendar, 1),
            label: "Timetable",
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(context, Iconsax.document, 2),
            activeIcon: _buildActiveIcon(context, Iconsax.document, 2),
            label: "Attendance",
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(context, Iconsax.user, 3),
            activeIcon: _buildActiveIcon(context, Iconsax.user, 3),
            label: "Profile",
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _buildNavIcon(BuildContext context, IconData icon, int index) {
    return Container(
      height: 40,
      width: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Icon(icon),
    );
  }

  Widget _buildActiveIcon(BuildContext context, IconData icon, int index) {
    return Container(
      height: 40,
      width: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Icon(icon),
    );
  }
}
