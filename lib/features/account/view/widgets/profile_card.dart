import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/features/onboarding/view/pages/profile_picture_page.dart';

class ProfileCard extends ConsumerWidget {
  final User? user;
  final bool isProfile;
  const ProfileCard({super.key, this.isProfile = false, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPrefs = ref.watch(userPreferencesNotifierProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                userPrefs.pfpPath,
              ),
            ),
            if (isProfile)
              TextButton(
                style: const ButtonStyle(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => ProfilePicturePage(
                        instructionText:
                            "Choose a profile picture that best represents you",
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Change avatar",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              user?.profile.target?.studentName ?? "N/A",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
              child: Text(
                user?.profile.target?.dob ?? "N/A",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
