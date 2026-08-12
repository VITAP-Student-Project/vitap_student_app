import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/constants/analytics_constants.dart';
import 'package:vit_ap_student_app/core/providers/bottom_nav_provider.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/account/view/pages/account_page.dart';
import 'package:vit_ap_student_app/features/attendance/view/pages/attendance_page.dart';
import 'package:vit_ap_student_app/features/connect/viewmodel/pending_requests_badge_provider.dart';
import 'package:vit_ap_student_app/features/home/view/pages/home_page.dart';
import 'package:vit_ap_student_app/features/timetable/view/pages/timetable_page.dart';
import 'package:vit_ap_student_app/features/connect/view/pages/connect_page.dart';
import 'package:wiredash/wiredash.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends ConsumerState<BottomNavBar> {
  final List<String> _tabNames = ['Home', 'Timetable', 'Attendance', 'Connect', 'Account'];

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Wiredash.of(context).showPromoterSurvey(
        options: const PsOptions(
          frequency: Duration(days: 60),
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
      ConnectPage(),
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
          // Log navigation to home via back button
          ref.read(analyticsServiceProvider).logEvent(
            AnalyticsEvents.navigationTapped,
            {
              AnalyticsParams.source: _tabNames[currentIndex],
              AnalyticsParams.target: _tabNames[0],
              AnalyticsParams.method: 'back_button',
            },
          );
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: _buildPages(),
        ),
        bottomNavigationBar: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            currentIndex: currentIndex,
            onTap: (index) {
              if (index != currentIndex) {
                final fromTab = _tabNames[currentIndex];
                final toTab = _tabNames[index];

                // Log tab switch
                ref.read(analyticsServiceProvider).logEvent(
                  AnalyticsEvents.navigationTapped,
                  {
                    AnalyticsParams.source: fromTab,
                    AnalyticsParams.target: toTab,
                    AnalyticsParams.method: 'tab_bar',
                  },
                );

                ref.read(bottomNavIndexProvider.notifier).state = index;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: _buildNavIcon(Iconsax.home, 0),
                activeIcon: _buildActiveIcon(Iconsax.home, 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(Iconsax.calendar, 1),
                activeIcon: _buildActiveIcon(Iconsax.calendar, 1),
                label: 'Timetable',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(Iconsax.document, 2),
                activeIcon: _buildActiveIcon(Iconsax.document, 2),
                label: 'Attendance',
              ),
              BottomNavigationBarItem(
                icon: Consumer(
                  builder: (context, ref, child) {
                    final pendingCount = ref.watch(pendingRequestsBadgeProvider);
                    return Badge(
                      isLabelVisible: pendingCount > 0,
                      label: Text(pendingCount > 9 ? '9+' : pendingCount.toString()),
                      child: _buildNavIcon(Icons.people_alt_rounded, 3),
                    );
                  },
                ),
                activeIcon: Consumer(
                  builder: (context, ref, child) {
                    final pendingCount = ref.watch(pendingRequestsBadgeProvider);
                    return Badge(
                      isLabelVisible: pendingCount > 0,
                      label: Text(pendingCount > 9 ? '9+' : pendingCount.toString()),
                      child: _buildActiveIcon(Icons.people_alt_rounded, 3),
                    );
                  },
                ),
                label: 'Connect',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(Iconsax.user, 4),
                activeIcon: _buildActiveIcon(Iconsax.user, 4),
                label: 'Account',
              ),
            ],
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
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
