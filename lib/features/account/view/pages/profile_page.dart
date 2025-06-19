import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/common/widget/user_info_tile.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/profile_card.dart';

class ProfilePage extends StatefulWidget {
  final User? user;
  const ProfilePage(this.user, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('ProfilePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfileCard(
              user: widget.user,
              isProfile: true,
            ),
            const SizedBox(height: 48),
            UserInfoTile(
                "Full Name", widget.user?.profile.target?.studentName ?? "N/A"),
            UserInfoTile("Email", widget.user?.profile.target?.email ?? "N/A"),
            UserInfoTile(
                "Date of Birth", widget.user?.profile.target?.dob ?? "N/A"),
            UserInfoTile("Application Number",
                widget.user?.profile.target?.applicationNumber ?? "N/A"),
            UserInfoTile("Blood Group",
                widget.user?.profile.target?.bloodGroup ?? "N/A"),
            UserInfoTile(
                "Gender", widget.user?.profile.target?.gender ?? "N/A"),
          ],
        ),
      ),
    );
  }
}
