import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vit_ap_student_app/pages/features/time_table_page.dart';
import 'package:vit_ap_student_app/pages/features/community_page.dart';
import 'package:vit_ap_student_app/pages/features/profile_page.dart';
import 'package:vit_ap_student_app/pages/features/home_page.dart';
import 'package:wiredash/wiredash.dart';

class MyBNB extends StatefulWidget {
  final int initialIndex;

  const MyBNB({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _MyBNBState createState() => _MyBNBState();
}

class _MyBNBState extends State<MyBNB> {
  String _packageVersion = "Loading...";
  late int _currentIndex = widget.initialIndex;

  @override
  void initState() {
    super.initState();
    _loadPackageVersion();
    Future.delayed(Duration(seconds: 5), () {
      if (!mounted) return;
      Wiredash.of(context).showPromoterSurvey(
        options: PsOptions(
          frequency: Duration(days: 450),
          initialDelay: Duration(days: 5),
          minimumAppStarts: 5,
        ),
      );
    });
  }

  Future<void> _loadPackageVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _packageVersion = packageInfo.version;
      });
    } catch (e) {
      setState(() {
        _packageVersion = "Version info unavailable";
      });
    }
  }

  List<Widget> _buildPages() {
    return [
      HomePage(),
      TimeTablePage(),
      CommunityPage(),
      ProfilePage(packageVersion: _packageVersion), // Use updated version here
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _buildPages()[_currentIndex],
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            print("Home tab selected");
          } else if (index == 1) {
            print("Time Table tab selected");
          } else if (index == 2) {
            print("Community tab selected");
          } else if (index == 3) {
            print("Profile tab selected");
          }
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
