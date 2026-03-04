import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/utils/package_version.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/contributors_bottom_sheet.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/developer_bottom_sheet.dart';

class Footer extends StatefulWidget {
  final VoidCallback? onVersionTap;
  final bool hideVersion;

  const Footer({super.key, this.onVersionTap, this.hideVersion = false});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  late TapGestureRecognizer _udhayTapRecognizer;
  late TapGestureRecognizer _sanjayTapRecognizer;
  late TapGestureRecognizer _contributorsTapRecognizer;
  String? _cachedVersion;

  // Developer information
  static const _udhayInfo = DeveloperInfo(
    name: 'Udhay Adithya',
    githubUsername: 'Udhay-Adithya',
    linkedInUrl: 'https://www.linkedin.com/in/udhay-adithya/',
    role: 'Mobile Application Developer',
  );

  static const _sanjayInfo = DeveloperInfo(
    name: 'Sai Sanjay',
    githubUsername: 'sanjay7178',
    role: 'Backend/DevOps Engineer',
  );

  @override
  void initState() {
    super.initState();
    _udhayTapRecognizer = TapGestureRecognizer();
    _udhayTapRecognizer.onTap = () => _showDeveloperBottomSheet(_udhayInfo);

    _sanjayTapRecognizer = TapGestureRecognizer();
    _sanjayTapRecognizer.onTap = () => _showDeveloperBottomSheet(_sanjayInfo);

    _contributorsTapRecognizer = TapGestureRecognizer();
    _contributorsTapRecognizer.onTap = _showContributorsBottomSheet;

    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final version = await packageVersion();
    if (mounted) {
      setState(() {
        _cachedVersion = version;
      });
    }
  }

  @override
  void dispose() {
    _udhayTapRecognizer.dispose();
    _sanjayTapRecognizer.dispose();
    _contributorsTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cachedVersion == null) {
      return const SizedBox(height: 80, child: Center(child: Loader()));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Crafted with ❤️ by\n',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'Udhay Adithya',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: _udhayTapRecognizer,
                  ),
                  TextSpan(
                    text: ' , ',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'Sai Sanjay',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: _sanjayTapRecognizer,
                  ),
                  TextSpan(
                    text: '\n& our amazing\n',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'Contributors',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: _contributorsTapRecognizer,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (!widget.hideVersion) ...[
              TextButton(
                onPressed: widget.onVersionTap,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'v$_cachedVersion',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showDeveloperBottomSheet(DeveloperInfo developerInfo) {
    return showModalBottomSheet<void>(
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      ),
      context: context,
      builder: (context) => DeveloperBottomSheet(developerInfo: developerInfo),
    );
  }

  Future<void> _showContributorsBottomSheet() {
    return showModalBottomSheet<void>(
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      ),
      context: context,
      builder: (context) => const ContributorsBottomSheet(),
    );
  }
}
