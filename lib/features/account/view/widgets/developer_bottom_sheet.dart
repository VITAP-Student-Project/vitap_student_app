import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/utils/launch_web.dart';

class DeveloperInfo {
  final String name;
  final String githubUsername;
  final String? linkedInUrl;
  final String role;

  const DeveloperInfo({
    required this.name,
    required this.githubUsername,
    this.linkedInUrl,
    this.role = "Mobile Application Developer",
  });
}

class DeveloperBottomSheet extends StatefulWidget {
  final DeveloperInfo developerInfo;

  const DeveloperBottomSheet({
    super.key,
    required this.developerInfo,
  });

  @override
  State<DeveloperBottomSheet> createState() => _DeveloperBottomSheetState();
}

class _DeveloperBottomSheetState extends State<DeveloperBottomSheet> {
  String? _profileImageUrl;
  bool _imageLoadError = false;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  void _loadProfileImage() {
    setState(() {
      _profileImageUrl =
          'https://github.com/${widget.developerInfo.githubUsername}.png?size=200';
    });
  }

  void _onImageError() {
    if (!_imageLoadError) {
      setState(() {
        _imageLoadError = true;
        _profileImageUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 425,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/lottie/smile.json",
                  frameRate: const FrameRate(60),
                  width: 45,
                  repeat: true,
                ),
                Text(
                  "Developer",
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Theme.of(context).colorScheme.surfaceContainerLow,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 140,
                          ),
                          Positioned(
                            bottom: 10,
                            child: _buildProfileImage(),
                          ),
                          Positioned(
                            top: -15,
                            right: 0,
                            child: Lottie.asset(
                              "assets/lottie/wave.json",
                              frameRate: const FrameRate(60),
                              width: 80,
                              repeat: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.developerInfo.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      widget.developerInfo.role,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 1,
                        width: 15,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    _buildSocialButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (_imageLoadError || _profileImageUrl == null) {
      return CircleAvatar(
        radius: 55,
        backgroundImage: AssetImage('assets/images/pfp/masked.png'),
      );
    }

    return CircleAvatar(
      radius: 55,
      backgroundImage: NetworkImage(_profileImageUrl!),
      onBackgroundImageError: (exception, stackTrace) {
        _onImageError();
      },
      child: _profileImageUrl == null ? Loader() : null,
    );
  }

  Widget _buildSocialButtons() {
    List<Widget> buttons = [];

    // Always show GitHub button (required)
    buttons.add(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton.icon(
          onPressed: () async {
            await directToWeb(
                "https://github.com/${widget.developerInfo.githubUsername}");
          },
          icon: Image.asset(
            "assets/images/icons/github.png",
            height: 28,
            color: Colors.white,
          ),
          label: Text(
            'GitHub',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );

    // Show LinkedIn button only if URL is provided
    if (widget.developerInfo.linkedInUrl != null) {
      buttons.add(
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextButton.icon(
            onPressed: () async {
              await directToWeb(widget.developerInfo.linkedInUrl!);
            },
            icon: Image.asset(
              "assets/images/icons/linkedin.png",
              height: 28,
            ),
            label: Text(
              'LinkedIn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}
