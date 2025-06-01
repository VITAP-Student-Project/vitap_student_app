import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/user_info_tile.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

class MentorPage extends ConsumerStatefulWidget {
  const MentorPage({super.key});

  @override
  ConsumerState<MentorPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<MentorPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('MentorPage');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Mentor",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/pfp/default.png',
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      user?.profile.target?.mentorDetails.target?.facultyName ??
                          "N/A",
                      textAlign: TextAlign.center,
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
                        user?.profile.target?.mentorDetails.target?.facultyId ??
                            "N/A",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            UserInfoTile(
                "Full Name",
                user?.profile.target?.mentorDetails.target?.facultyName ??
                    "N/A"),
            UserInfoTile(
                "Department",
                user?.profile.target?.mentorDetails.target?.facultyDepartment ??
                    "N/A"),
            UserInfoTile(
                "Designation",
                user?.profile.target?.mentorDetails.target
                        ?.facultyDesignation ??
                    "N/A"),
            UserInfoTile(
              "Email",
              user?.profile.target?.mentorDetails.target?.facultyEmail ?? "N/A",
            ),
            UserInfoTile("Cabin",
                user?.profile.target?.mentorDetails.target?.cabin ?? "N/A"),
            UserInfoTile(
                "Mobile Number",
                user?.profile.target?.mentorDetails.target
                        ?.facultyMobileNumber ??
                    "N/A"),
          ],
        ),
      ),
    );
  }
}
