import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/utils/package_version.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/developer_bottom_sheet.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  late TapGestureRecognizer _udhayTapRecognizer;
  late TapGestureRecognizer _sanjayTapRecognizer;

  // Developer information
  static const _udhayInfo = DeveloperInfo(
    name: "Udhay Adithya",
    githubUsername: "Udhay-Adithya",
    linkedInUrl: "https://www.linkedin.com/in/udhay-adithya/",
    role: "Mobile Application Developer",
  );

  static const _sanjayInfo = DeveloperInfo(
    name: "Sai Sanjay",
    githubUsername: "sanjay7178",
    role: "Backend/DevOps Engineer",
  );

  @override
  void initState() {
    super.initState();
    _udhayTapRecognizer = TapGestureRecognizer();
    _udhayTapRecognizer.onTap = () => _showDeveloperBottomSheet(_udhayInfo);

    _sanjayTapRecognizer = TapGestureRecognizer();
    _sanjayTapRecognizer.onTap = () => _showDeveloperBottomSheet(_sanjayInfo);
  }

  @override
  void dispose() {
    _udhayTapRecognizer.dispose();
    _sanjayTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: packageVersion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }

          if (snapshot.connectionState == ConnectionState.done) {
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
                            text: "Crafted with ❤️ by\n",
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: "Udhay Adithya",
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
                            text: " and ",
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: "Sai Sanjay",
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "v${snapshot.data}",
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  Future<void> _showDeveloperBottomSheet(DeveloperInfo developerInfo) {
    return showModalBottomSheet(
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      context: context,
      builder: (context) => DeveloperBottomSheet(developerInfo: developerInfo),
    );
  }
}
