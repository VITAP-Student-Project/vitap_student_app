import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/account/view/pages/account_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/home_page.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex = widget.initialIndex;

  List<Widget> _buildPages() {
    return [
      HomePage(),
      HomePage(),
      HomePage(),

      // TimeTablePage(),
      // CommunityPage(),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPages()[_currentIndex],
      bottomNavigationBar: GNav(
        gap: 3,
        tabBorderRadius: 100,
        tabMargin: EdgeInsets.symmetric(vertical: 12),
        activeColor: Theme.of(context).colorScheme.primary,
        tabBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: Iconsax.home,
            text: "Home",
          ),
          GButton(
            icon: Iconsax.calendar,
            text: "Time Table",
          ),
          GButton(
            icon: Iconsax.note,
            text: "Attendance",
          ),
          GButton(
            icon: Iconsax.user,
            text: "Account",
          ),
        ],
      ),
    );
  }
}
