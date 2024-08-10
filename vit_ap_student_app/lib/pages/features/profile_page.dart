import '../../pages/onboarding/pfp_page.dart';
import '../../pages/profile/account_page.dart';
import '../../pages/profile/notifications_page.dart';
import '../../pages/profile/settings_page.dart';
import '../../pages/profile/themes_page.dart';
import '../../utils/text_newline.dart';
import '../../models/widgets/custom/developer_sheet.dart';
import '../../models/widgets/custom/my_list_tile_widget.dart';
import '../../utils/provider/providers.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:wiredash/wiredash.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  String? _profileImagePath;
  String _username = '';
  String _regNo = '';
  String _sec = '';
  String _semSubID = '';

  @override
  void initState() {
    super.initState();
    _loadProfileImagePath();
  }

  Future<void> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () {
        _profileImagePath =
            prefs.getString('pfpPath') ?? 'assets/images/pfp/default.png';
        _username = jsonDecode(prefs.getString('profile')!)['student_name'];
        _regNo = prefs.getString('username')!;
        _sec = prefs.getString('password')!;
        _semSubID = prefs.getString('semSubID')!;
      },
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeInOut,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              height: 230,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 75,
                    child: Lottie.asset(
                      "assets/images/lottie/loading_paper_plane.json",
                      height: 175,
                      frameRate: FrameRate(60),
                    ),
                  ),
                  Positioned(
                    bottom: 75,
                    child: Text(
                      "Hold Tight",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Positioned(
                    bottom: 30,
                    child: Text(
                      "Even servers need a coffee\nbreak! ☕",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 25, right: 10),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage(_profileImagePath ??
                                'assets/images/pfp/default.png'),
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
                                    builder: (context) => const AccountPage()),
                              )
                            },
                            icon: const Icon(Icons.mode_edit_rounded),
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
                      PageTransition(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: const AccountPage(),
                      ),
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
                      PageTransition(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: const NotificationPage(),
                      ),
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
                      PageTransition(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: const SettingsPage(),
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
                      PageTransition(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: const UserThemes(),
                      ),
                    );
                  },
                ),
                SettingsListTile(
                  icon: Icons.sync_rounded,
                  iconBackgroundColor: Colors.teal.shade400,
                  title: "Sync",
                  subtitle: "Sync latest data with V-Top",
                  onTap: () {
                    _showLoadingDialog(context);
                    ref
                        .read(loginProvider.notifier)
                        .login(_regNo, _sec, _semSubID, context)
                        .then((_) {
                      //Navigator.of(context).pop(); // Close dialog
                    });
                  },
                ),
                SettingsListTile(
                  icon: Icons.share_outlined,
                  iconBackgroundColor: Colors.green.shade500,
                  title: "Tell a friend",
                  subtitle: "Show us some love by sharing this app",
                  onTap: () async {
                    final result = await Share.share(
                        '🚀🎓 Hey VIT-AP students! Your academic life just got easier. Access all details & connect with peers. Download the app now! 📚👩‍🎓 https://example.com');
                    if (result.status == ShareResultStatus.success) {
                      SnackBar snackBar = SnackBar(
                        width: 200,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        behavior: SnackBarBehavior.floating,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
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
                  title: "Privacy Policy",
                  subtitle: "Make sure that you agree to these rules",
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
                  onTap: () {
                    Wiredash.of(context).show(inheritMaterialTheme: true);
                  },
                ),
                SettingsListTile(
                    icon: Icons.star_outline_rounded,
                    iconBackgroundColor: Colors.pink.shade600,
                    title: "Rate us",
                    subtitle: "Show your love by rating us!",
                    onTap: () {
                      const _backgroundColor = Color(0xFFF15BB5);

                      const _colors = [
                        Color(0xFFFEE440),
                        Color(0xFF00BBF9),
                      ];

                      const _durations = [
                        5000,
                        4000,
                      ];

                      const _heightPercentages = [
                        0.65,
                        0.66,
                      ];

                      WaveWidget(
                        config: CustomConfig(
                          colors: _colors,
                          durations: _durations,
                          heightPercentages: _heightPercentages,
                        ),
                        backgroundColor: _backgroundColor,
                        size: Size(double.infinity, double.infinity),
                        waveAmplitude: 0,
                      );
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          type: PageTransitionType.fade,
                          child: const MyProfilePicScreen(
                            instructionText:
                                "Choose a profile picture that best represents you.",
                            nextPage: LoginPage(),
                          )),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                const DeveloperBottomSheet(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
