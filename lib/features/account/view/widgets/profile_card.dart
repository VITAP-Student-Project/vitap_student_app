import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/auth/view/pages/semester_selection_page.dart';
import 'package:vit_ap_student_app/features/auth/viewmodel/semester_viewmodel.dart';
import 'package:vit_ap_student_app/features/onboarding/view/pages/profile_picture_page.dart';

class ProfileCard extends ConsumerStatefulWidget {
  final User? user;
  final bool isProfile;
  const ProfileCard({super.key, this.isProfile = false, required this.user});

  @override
  ConsumerState<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends ConsumerState<ProfileCard> {
  String? _selectedSemesterName;

  @override
  void initState() {
    super.initState();
    _loadSelectedSemester();
  }

  Future<void> _loadSelectedSemester() async {
    final semester = await ref
        .read(semesterViewModelProvider.notifier)
        .getSelectedSemester();
    if (mounted && semester != null) {
      setState(() {
        _selectedSemesterName = semester.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = ref.watch(userPreferencesNotifierProvider);
    final isLoading = ref.watch(
        semesterViewModelProvider.select((val) => val?.isLoading == true));
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
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
            if (widget.isProfile)
              TextButton(
                style: const ButtonStyle(),
                onPressed: () {
                  AnalyticsService.logEvent(
                      'profile_picture_change_initiated', {
                    'current_pfp_path': userPrefs.pfpPath,
                    'timestamp': DateTime.now().toIso8601String(),
                  });
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
              widget.user?.profile.target?.studentName ?? "N/A",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            if (!widget.isProfile) ...[
              if (isLoading) ...[
                Loader(),
              ] else ...[
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                  child: Text(
                    _selectedSemesterName ?? "Select Semester",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                TextButton(
                  style: const ButtonStyle(),
                  onPressed: () async {
                    final credentials = await ref
                        .read(currentUserNotifierProvider.notifier)
                        .getSavedCredentials();
                    if (credentials != null && mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SemesterSelectionPage(
                            registrationNumber: credentials.registrationNumber,
                            password: credentials.password,
                          ),
                        ),
                      ).then((_) => _loadSelectedSemester());
                    }
                  },
                  child: const Text(
                    "Change semster",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ]
            ],
          ],
        ),
      ),
    );
  }
}
