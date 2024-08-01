import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../pages/profile/account_page.dart';

class MyHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyHomeAppBar({super.key});

  @override
  _MyHomeAppBarState createState() => _MyHomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyHomeAppBarState extends State<MyHomeAppBar> {
  String? _profileImagePath;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadProfileImagePath();
  }

  Future<void> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath =
          prefs.getString('pfpPath') ?? 'assets/images/pfp/default.png';
      _username = jsonDecode(prefs.getString('profile')!)['student_name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: const AccountPage(),
                      ),
                    );
      },
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  _profileImagePath ?? 'assets/images/pfp/default.png'),
            ),
            SizedBox(width: 10), // Add space between the avatar and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello 👋,',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  '$_username',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
