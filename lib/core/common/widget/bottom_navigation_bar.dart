import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/providers/bottom_nav_provider.dart';
import 'package:vit_ap_student_app/features/account/view/pages/account_page.dart';
import 'package:vit_ap_student_app/features/attendance/view/pages/attendance_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/home_page.dart';
import 'package:vit_ap_student_app/features/timetable/view/pages/timetable_page.dart';
import 'package:wiredash/wiredash.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Wiredash.of(context).showPromoterSurvey(
        options: const PsOptions(
          frequency: Duration(days: 30),
          initialDelay: Duration(days: 7),
          minimumAppStarts: 12,
        ),
      );
    });
  }

  List<Widget> _buildPages() {
    return const [
      HomePage(),
      TimetablePage(),
      AttendancePage(),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && currentIndex != 0) {
          ref.read(bottomNavIndexProvider.notifier).state = 0;
        }
      },
      child: Scaffold(
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
              icon: _buildNavIcon(Iconsax.home, 0),
              activeIcon: _buildActiveIcon(Iconsax.home, 0),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.calendar, 1),
              activeIcon: _buildActiveIcon(Iconsax.calendar, 1),
              label: "Timetable",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.document, 2),
              activeIcon: _buildActiveIcon(Iconsax.document, 2),
              label: "Attendance",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.user, 3),
              activeIcon: _buildActiveIcon(Iconsax.user, 3),
              label: "Account",
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
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

  Widget _buildActiveIcon(IconData icon, int index) {
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
