import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/theme_switch.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/launch_web.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/account/view/pages/profile_page.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/footer.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/profile_card.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/settings_category.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/settings_tile.dart';
import 'package:vit_ap_student_app/features/auth/view/pages/login_page.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
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
                    title: "Sync",
                    leadingIcon: const Icon(Iconsax.repeat),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {},
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Settings",
                    leadingIcon: const Icon(Iconsax.setting_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {},
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
                    title: "Report a problem",
                    leadingIcon: const Icon(Iconsax.support_copy),
                    trailingIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {},
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
                          "https://github.com/Udhay-Adithya/vit_ap_student_app");
                    },
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "App Lock",
                    leadingIcon: const Icon(Iconsax.lock_1_copy),
                    trailingWidget: Transform.scale(
                      scale: 0.9,
                      child: Switch.adaptive(
                        value: false,
                        onChanged: (value) {},
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
                  SettingTile(
                    isFirst: true,
                    isLast: false,
                    title: "Check for updates",
                    leadingIcon: const Icon(Iconsax.import_2),
                    leadingIconColor: Colors.green,
                    leadingIconBackgroundColor:
                        Colors.greenAccent.withValues(alpha: 0.5),
                    onTap: () {},
                  ),
                  SettingTile(
                    isFirst: false,
                    isLast: false,
                    title: "Star us on Github",
                    leadingIcon: const Icon(Iconsax.star),
                    leadingIconColor: Colors.amber,
                    leadingIconBackgroundColor:
                        Colors.yellow.shade100.withValues(alpha: 0.5),
                    onTap: () async {
                      await directToWeb(
                          "https://github.com/Udhay-Adithya/vit_ap_student_app");
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
                    onTap: () {
                      // Trigger logout
                      ref.read(currentUserNotifierProvider.notifier).logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          const Footer(
            packageVersion: "2.0.0",
          ),
        ],
      )),
    );
  }
}
