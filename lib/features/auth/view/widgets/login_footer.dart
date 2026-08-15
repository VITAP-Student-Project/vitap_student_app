import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/common/widget/analytics_consent_checkbox.dart';
import 'package:wiredash/wiredash.dart';

/// Consent text and the escape hatch, kept together at the bottom.
///
/// "Report an Issue" used to sit directly under the Continue button, where it
/// competed with the primary action. It stays on this screen — a student who
/// cannot log in has no other route to you — just out of the way.
class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
    required this.privacyRecognizer,
    required this.termsRecognizer,
  });

  final TapGestureRecognizer privacyRecognizer;
  final TapGestureRecognizer termsRecognizer;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final TextStyle? linkStyle = tt.bodySmall?.copyWith(
      color: cs.primary,
      decoration: TextDecoration.underline,
      decorationColor: cs.primary,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
          onPressed: () => Wiredash.of(context).show(),
          child: const Text('Report an issue'),
        ),
        const SizedBox(height: 4),
        // Above Continue, so the reading order is
        // password → consent → act, rather than asking
        // after the fact.
        const AnalyticsConsentCheckbox(),
        const SizedBox(height: 8),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            children: <InlineSpan>[
              const TextSpan(
                text: "Upon login you agree to VITAP Student App's ",
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: linkStyle,
                recognizer: privacyRecognizer,
                mouseCursor: SystemMouseCursors.click,
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Terms of Service',
                style: linkStyle,
                recognizer: termsRecognizer,
                mouseCursor: SystemMouseCursors.click,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
