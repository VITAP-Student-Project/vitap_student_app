import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/analytics_consent_sheet.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';

/// The analytics opt-out, offered at the moment of signing in.
///
/// Bound straight to the stored preference, which already defaults to on
/// (`isAnalyticsEnabled` is null until chosen and reads as `true`), so the box
/// starts checked and toggling it here is the same act as toggling it later in
/// Settings — including switching Firebase collection off on the spot.
///
/// The label opens [showAnalyticsConsentSheet] rather than toggling the box.
/// That runs against the usual checkbox convention, so it is styled as a link —
/// underlined, in the primary colour, with an info icon — to look like something
/// that opens rather than something that ticks.
class AnalyticsConsentCheckbox extends ConsumerWidget {
  const AnalyticsConsentCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final bool enabled = ref.watch(
      userPreferencesProvider.select((prefs) => prefs.analyticsEnabled),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: enabled,
          onChanged: (bool? value) => ref
              .read(userPreferencesProvider.notifier)
              .toggleAnalytics(value ?? false),
          visualDensity: VisualDensity.compact,
        ),

        const SizedBox(width: 4),
        Flexible(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => showAnalyticsConsentSheet(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Share anonymous usage data',
                      style: tt.bodyMedium?.copyWith(
                        color: cs.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: cs.primary,
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),
                  Icon(Icons.info_outline_rounded, size: 16, color: cs.primary),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
