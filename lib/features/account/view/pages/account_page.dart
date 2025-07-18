import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/theme_switch.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/launch_web.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/account/view/pages/faq_page.dart';
import 'package:vit_ap_student_app/features/account/view/pages/manage_credentials_page.dart';
import 'package:vit_ap_student_app/features/account/view/pages/profile_page.dart';
import 'package:vit_ap_student_app/features/account/view/pages/notification_settings_page.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/footer.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/profile_card.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/settings_category.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/settings_tile.dart';
import 'package:vit_ap_student_app/features/account/viewmodel/account_viewmodel.dart';
import 'package:vit_ap_student_app/features/auth/view/pages/login_page.dart';
import 'package:wiredash/wiredash.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('AccountPage');
  }

  void _showChangeSemDialog() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Semester Changed',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'It looks like you\'ve recently updated your semester. Would you like to sync the app with the new semester?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Later',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                ref.read(accountViewModelProvider.notifier).sync();
                await AnalyticsService.logEvent('semester_sync');
              },
              child: Text(
                'Sync',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final userPreferences = ref.watch(userPreferencesNotifierProvider);
    final userPreferencesNotifier =
        ref.read(userPreferencesNotifierProvider.notifier);

    ref.listen(
      accountViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(
              context,
              "Successfully synced with VTOP",
              SnackBarType.success,
            );
          },
          loading: () {
            showSnackBar(
              context,
              "Syncing with VTOP in the background...",
              SnackBarType.warning,
            );
          },
          error: (error, st) {
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Account",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileCard(
            user: user,
          ),
          const SizedBox(
            height: 24,
          ),
          const SettingsCategory("Account"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SettingTile(
                    isFirst: true,
                    isLast: false,
                    title: "Profile",
                    leadingIcon: const Icon(Iconsax.user_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => ProfilePage(user),
                        ),
                      );
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Manage Credentials",
                    leadingIcon: const Icon(Iconsax.lock_1_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () async {
                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => ManageCredentialsPage(),
                        ),
                      );
                      if (result == true) {
                        await Future.delayed(Duration(seconds: 2));
                        _showChangeSemDialog();
                      }
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Sync",
                    infoText:
                        'When synced, latest data will be fetched from VTOP.',
                    leadingIcon: const Icon(Iconsax.repeat),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () async {
                      ref.read(accountViewModelProvider.notifier).sync();
                      await AnalyticsService.logEvent('user_data_sync');
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Notification",
                    leadingIcon: const Icon(Iconsax.notification_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => NotificationSettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SettingsCategory("App"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SettingTile(
                    isFirst: true,
                    isLast: false,
                    title: "Help & Feedback",
                    leadingIcon: const Icon(Iconsax.support_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {
                      Wiredash.of(context).show();
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Share",
                    leadingIcon: const Icon(Iconsax.share_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () async {
                      final result = await SharePlus.instance.share(ShareParams(
                          text:
                              '🚀🎓 Hey, Your academic life just got easier. Access all your details through the VIT-AP Student App. Download the app now! 📚👩‍🎓 https://vitap.udhay-adithya.me'));
                      if (result.status == ShareResultStatus.success) {
                        showSnackBar(
                          context,
                          'Thanks for sharing ❤️',
                          SnackBarType.success,
                        );
                      }
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Privacy policy",
                    leadingIcon: const Icon(Iconsax.document_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () async {
                      await directToWeb(
                          "https://vitap.udhay-adithya.me/privacy");
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "FAQ's",
                    leadingIcon: const Icon(Iconsax.archive_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => FAQPage(),
                        ),
                      );
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Privacy Mode",
                    infoText:
                        'When enabled, your grades will be hidden in the home page.',
                    leadingIcon: const Icon(Iconsax.security_copy),
                    trailingWidget: Transform.scale(
                      scale: 0.9,
                      child: Switch.adaptive(
                        value: userPreferences.isPrivacyEnabled,
                        onChanged: (value) async {
                          final updatedPreferences = userPreferences.copyWith(
                            isPrivacyEnabled: value,
                          );
                          await userPreferencesNotifier
                              .updatePreferences(updatedPreferences);
                        },
                      ),
                    ),
                    onTap: () {},
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: true,
                    title: "Dark Mode",
                    leadingIcon: const Icon(Iconsax.moon_copy),
                    trailingWidget: Transform.scale(
                      scale: 0.9,
                      child: const ThemeSwitch(),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SettingsCategory("Actions"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SettingTile(
                  //   isFirst: true,
                  //   isLast: false,
                  //   title: "Check for updates",
                  //   leadingIcon: const Icon(Iconsax.import_2),
                  //   leadingIconColor: Colors.green,
                  //   leadingIconBackgroundColor:
                  //       Colors.greenAccent.withValues(alpha: 0.5),
                  //   onTap: () {},
                  // ),
                  SettingTile(
                    isFirst: true,
                    isLast: false,
                    title: "Star us on Github",
                    leadingIcon: const Icon(Iconsax.star),
                    leadingIconColor: Colors.amber,
                    leadingIconBackgroundColor:
                        Colors.yellow.shade100.withValues(alpha: 0.5),
                    onTap: () async {
                      await directToWeb(
                          "https://github.com/VITAP-Student-Project/vitap_student_app");
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: true,
                    title: "Logout",
                    leadingIcon: const Icon(Iconsax.logout),
                    leadingIconColor: Colors.red,
                    leadingIconBackgroundColor: Colors.red.shade100,
                    titleColor: Colors.redAccent,
                    onTap: () async {
                      ref.read(currentUserNotifierProvider.notifier).logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                      await AnalyticsService.logEvent('logout');
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          const Footer(),
        ],
      )),
    );
  }
}
