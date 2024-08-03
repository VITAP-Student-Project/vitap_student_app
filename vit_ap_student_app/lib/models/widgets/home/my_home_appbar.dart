import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../pages/profile/account_page.dart';

class MyHomeSliverAppBar extends StatefulWidget {
  const MyHomeSliverAppBar({super.key});

  @override
  _MyHomeSliverAppBarState createState() => _MyHomeSliverAppBarState();
}

class _MyHomeSliverAppBarState extends State<MyHomeSliverAppBar> {
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
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 75,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.2,
        titlePadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: GestureDetector(
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                      _profileImagePath ?? 'assets/images/pfp/default.png'),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello 👋,",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      _username ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Optionally, you can add other details here, such as the number of classes.
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
