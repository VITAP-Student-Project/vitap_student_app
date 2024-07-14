import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/models/widgets/custom/my_list_tile_widget.dart';
import 'package:vit_ap_student_app/pages/features/login_page.dart';
import 'package:vit_ap_student_app/pages/profile/account_page.dart';
import 'package:vit_ap_student_app/pages/profile/notifications_page.dart';
import 'package:vit_ap_student_app/pages/profile/settings_page.dart';
import 'package:vit_ap_student_app/pages/profile/themes_page.dart';
import 'package:vit_ap_student_app/utils/text_newline.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImagePath;
  String _username = '';
  String _regNo = '';

  @override
  void initState() {
    super.initState();
    _loadProfileImagePath();
  }

  Future<void> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath =
          prefs.getString('pfpPath') ?? 'assets/images/pfp/default.jpg';
      _username = jsonDecode(prefs.getString('profile')!)['student_name'];
      _regNo = prefs.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            expandedHeight: 200,
            title: Text(
              "My Profile",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 25, right: 10),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage(_profileImagePath ??
                                'assets/images/pfp/default.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addNewlines(_username, 12),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Text(
                              "$_regNo",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountPage()),
                              )
                            },
                            icon: Icon(Icons.mode_edit_rounded),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    textAlign: TextAlign.left,
                    "Account",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SettingsListTile(
                  icon: Icons.person_outline,
                  iconBackgroundColor: Colors.blue.shade700,
                  title: "My Account",
                  subtitle: "Check your personal information",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage()),
                    );
                  },
                ),
                SettingsListTile(
                  icon: Icons.notifications_none_rounded,
                  iconBackgroundColor: Colors.yellow.shade700,
                  title: "Notification",
                  subtitle: "Personalize your notifications",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()),
                    );
                  },
                ),
                SettingsListTile(
                  icon: Icons.lock_outline_rounded,
                  iconBackgroundColor: Colors.red.shade800,
                  title: "Settings",
                  subtitle: "Customize your privacy settings",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSettings(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "App",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SettingsListTile(
                icon: Icons.color_lens_outlined,
                iconBackgroundColor: Colors.purple.shade600,
                title: "Themes",
                subtitle: "Customize your app themes",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserThemes(),
                    ),
                  );
                },
              ),
              SettingsListTile(
                icon: Icons.sync_rounded,
                iconBackgroundColor: Colors.teal.shade400,
                title: "Sync",
                subtitle: "Sync latest data with V-Top",
              ),
              SettingsListTile(
                icon: Icons.share_outlined,
                iconBackgroundColor: Colors.green.shade500,
                title: "Tell a friend",
                subtitle: "Show us some love by sharing this app",
                onTap: () async {
                  final result = await Share.share(
                      'check out my website https://example.com');
                  if (result.status == ShareResultStatus.success) {
                    SnackBar snackBar = SnackBar(
                      width: 200,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      content: Text(
                        'Thanks for the love 💚',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              SettingsListTile(
                icon: Icons.my_library_books_outlined,
                iconBackgroundColor: Colors.lightBlue.shade400,
                title: "Terms and Conditions",
                subtitle: "Make sure that you agree to these rules",
              ),
            ],
          )),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Actions",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SettingsListTile(
                  icon: Icons.bug_report_outlined,
                  iconBackgroundColor: Colors.orange.shade700,
                  title: "Report a problem",
                  subtitle: "Bugs? Let us fix them for you ",
                  onTap: () {},
                ),
                SettingsListTile(
                    icon: Icons.star_outline_rounded,
                    iconBackgroundColor: Colors.pink.shade600,
                    title: "Rate us",
                    subtitle: "Show your love by rating us!",
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? timetableString = prefs.getString('timetable');
                      if (timetableString != null) {
                        print('Loaded Timetable: $timetableString');
                      }
                    }),
                SettingsListTile(
                  icon: Icons.logout_rounded,
                  iconBackgroundColor: Colors.red.shade800,
                  title: "Sign out",
                  subtitle: "Logout out of VTOP Student App",
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    prefs.setBool('isLoggedIn', false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
