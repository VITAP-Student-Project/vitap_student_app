import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The heading above a group of content.
///
/// Shares its type treatment with the settings groups on the account page, so
/// "Today" on home and "Appearance" in settings read as the same level of the
/// hierarchy rather than as two unrelated title styles. Keep new sections on
/// this widget instead of hand-rolling a `Text`.
///
/// [trailing] is for a section-level action such as "View All"; it is aligned
/// to the end of the row and vertically centred against the label.
///
/// [variant] switches between the shared account-page treatment and the larger
/// home-page treatment.
///
/// The default [padding] assumes the caller already separates its sections —
/// which the account page does with explicit gaps between groups. Screens that
/// stack headings directly against the preceding content, like the home page's
/// sliver list, should pass their own padding with room at the top.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    this.trailing,
    this.variant = SectionHeaderVariant.defaultStyle,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 12),
  });

  /// Padding for a heading that follows a section gap.
  static const EdgeInsets standalone = EdgeInsets.fromLTRB(16, 24, 16, 4);

  final String label;
  final Widget? trailing;
  final SectionHeaderVariant variant;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final TextStyle baseStyle = switch (variant) {
      SectionHeaderVariant.home => tt.headlineSmall ?? const TextStyle(),
      SectionHeaderVariant.defaultStyle => tt.labelLarge ?? const TextStyle(),
    };

    final Color textColor = switch (variant) {
      SectionHeaderVariant.home => cs.onSurface,
      SectionHeaderVariant.defaultStyle => cs.primary,
    };

    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.unbounded(
                textStyle: baseStyle,
                fontWeight: switch (variant) {
                  SectionHeaderVariant.home => FontWeight.w700,
                  SectionHeaderVariant.defaultStyle => FontWeight.w600,
                },
                letterSpacing: -0.3,
                height: variant == SectionHeaderVariant.home ? 1.0 : null,
                color: textColor,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

enum SectionHeaderVariant { defaultStyle, home }
