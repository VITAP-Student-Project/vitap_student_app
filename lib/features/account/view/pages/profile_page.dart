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

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    AnalyticsService.logScreen('ProfilePage');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(
    BuildContext context,
    String label,
  ) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .secondaryContainer
            .withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Tab(
        child: Text(label),
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
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
          UserInfoTile(
              "Blood Group", widget.user?.profile.target?.bloodGroup ?? "N/A"),
          UserInfoTile("Gender", widget.user?.profile.target?.gender ?? "N/A"),
        ],
      ),
    );
  }

  Widget _buildMentorTab() {
    return SingleChildScrollView(
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
                    widget.user?.profile.target?.mentorDetails.target
                            ?.facultyName ??
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
                      widget.user?.profile.target?.mentorDetails.target
                              ?.facultyId ??
                          "N/A",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
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
              widget.user?.profile.target?.mentorDetails.target?.facultyName ??
                  "N/A"),
          UserInfoTile(
              "Department",
              widget.user?.profile.target?.mentorDetails.target
                      ?.facultyDepartment ??
                  "N/A"),
          UserInfoTile(
              "Designation",
              widget.user?.profile.target?.mentorDetails.target
                      ?.facultyDesignation ??
                  "N/A"),
          UserInfoTile(
            "Email",
            widget.user?.profile.target?.mentorDetails.target?.facultyEmail ??
                "N/A",
          ),
          UserInfoTile(
              "Cabin",
              widget.user?.profile.target?.mentorDetails.target?.cabin ??
                  "N/A"),
          UserInfoTile(
              "Mobile Number",
              widget.user?.profile.target?.mentorDetails.target
                      ?.facultyMobileNumber ??
                  "N/A"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              dividerColor: Theme.of(context).colorScheme.surface,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              splashBorderRadius: BorderRadius.circular(30),
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              unselectedLabelColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              labelColor: Theme.of(context).colorScheme.onSecondaryContainer,
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              splashFactory: InkRipple.splashFactory,
              overlayColor: WidgetStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.secondaryContainer,
              ),
              tabs: [
                _buildTab(context, "Profile"),
                _buildTab(context, "Mentor"),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),
          _buildMentorTab(),
        ],
      ),
    );
  }
}
