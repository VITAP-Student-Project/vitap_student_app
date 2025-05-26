import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/common/widget/user_info_tile.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  final User? user;
  const ProfilePage(this.user, {super.key});

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
            ProfileCard(user: user),
            const SizedBox(height: 48),
            UserInfoTile(
                "Full Name", user?.profile.target?.studentName ?? "N/A"),
            UserInfoTile("Email", user?.profile.target?.email ?? "N/A"),
            UserInfoTile("Date of Birth", user?.profile.target?.dob ?? "N/A"),
            UserInfoTile("Application Number",
                user?.profile.target?.applicationNumber ?? "N/A"),
            UserInfoTile(
                "Blood Group", user?.profile.target?.bloodGroup ?? "N/A"),
            UserInfoTile("Gender", user?.profile.target?.gender ?? "N/A"),
          ],
        ),
      ),
    );
  }
}
