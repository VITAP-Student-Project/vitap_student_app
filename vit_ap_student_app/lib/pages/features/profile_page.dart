import 'package:url_launcher/url_launcher.dart';

import '../../utils/logout.dart';
import '../../utils/provider/student_provider.dart';
import '../../utils/services/app_updates.dart';
import '../../widgets/custom/loading_dialogue_box.dart';
import '../../pages/onboarding/pfp_page.dart';
import '../../pages/profile/account_page.dart';
import '../../pages/profile/settings_page.dart';
import '../../pages/profile/themes_page.dart';
import '../../widgets/custom/developer_sheet.dart';
import '../../widgets/custom/my_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiredash/wiredash.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import '../profile/profile_card.dart';
import 'login_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String packageVersion;

  const ProfilePage({super.key, this.packageVersion = "Loading..."});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
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
              background: ProfileCard(),
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
                  subtitle: "Access your personal information",
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
                  icon: Icons.lock_outline_rounded,
                  iconBackgroundColor: Colors.red.shade800,
                  title: "Settings",
                  subtitle: "Manage privacy and preferences",
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
                  subtitle: "Choose a theme that suits your style",
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
                  subtitle: "Sync your data with V-Top",
                  onTap: () {
                    showLoadingDialog(
                        context, "Fetching latest data from\nVTOP..");
                    ref.read(studentProvider.notifier).syncStudentData(ref);
                  },
                ),
                SettingsListTile(
                  icon: Icons.share_outlined,
                  iconBackgroundColor: Colors.greenAccent.shade400,
                  title: "Tell a friend",
                  subtitle: "Share this app with your peers",
                  onTap: () async {
                    final result = await Share.share(
                        '🚀🎓 Hey VIT-AP students! Your academic life just got easier. Access all details & connect with peers. Download the app now! 📚👩‍🎓 https://udhay-adithya.github.io/vitap_app_website/');
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
                  subtitle: "Know how we protect your data",
                  onTap: () async {
                    Uri _url = Uri.parse(
                        "https://udhay-adithya.github.io/vitap_app_website/#/docs");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
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
                    "Support",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SettingsListTile(
                  icon: Icons.contact_support_outlined,
                  iconBackgroundColor: Colors.indigoAccent,
                  title: "FAQs",
                  subtitle: "Frequently Asked Questions",
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.bug_report_outlined,
                  iconBackgroundColor: Colors.orange.shade700,
                  title: "Report a problem",
                  subtitle: "Help us fix problems",
                  onTap: () {
                    Wiredash.of(context).show(inheritMaterialTheme: true);
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
                    "Actions",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SettingsListTile(
                  icon: Icons.system_update_rounded,
                  iconBackgroundColor: Colors.limeAccent.shade700,
                  title: "Check for updates",
                  subtitle: "Stay up-to-date with new features",
                  onTap: () => checkForUpdate(context, true),
                ),
                SettingsListTile(
                  icon: Icons.star_outline_rounded,
                  iconBackgroundColor: Colors.pink.shade600,
                  title: "Star us on GitHub",
                  subtitle: "Show your love by starring us!",
                  onTap: () async {
                    Uri _url = Uri.parse(
                        "https://github.com/Udhay-Adithya/vit_ap_student_app/");
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                ),
                SettingsListTile(
                  icon: Icons.logout_rounded,
                  iconBackgroundColor: Colors.red.shade800,
                  title: "Sign out",
                  subtitle: "Sign out of your account securely",
                  onTap: () async {
                    clearAllProviders(ref);

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
                const SizedBox(
                  height: 24,
                ),
                DeveloperBottomSheet(
                  packageVersion: widget.packageVersion,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
