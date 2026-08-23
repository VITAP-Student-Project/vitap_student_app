import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';

/// Presentation for the metadata a [ForYouItem] carries — its type and any
/// prerequisite. Shared by the card, the add-page preview and the detail page
/// so the three can't drift apart.
///
/// Types are colour-neutral on purpose. The feed is hand-curated and can grow a
/// new type at any time, so a colour-per-type switch either runs out of
/// `ColorScheme` roles or quietly renders unknown types as some other type's
/// colour — which is exactly the bug the old `'event'` / `'events'` mismatch
/// caused. The icon carries the distinction; the one saturated element on these
/// surfaces stays the primary-coloured call to action.

IconData forYouTypeIcon(String type) {
  switch (type.toLowerCase()) {
    case 'tools':
    case 'tool':
      return Iconsax.setting_4_copy;
    case 'resource':
    case 'resources':
      return Iconsax.book_copy;
    case 'academics':
    case 'academic':
      return Iconsax.teacher_copy;
    case 'events':
    case 'event':
      return Iconsax.calendar_copy;
    case 'placement':
    case 'placements':
      return Iconsax.briefcase_copy;
    default:
      return Iconsax.element_3_copy;
  }
}

/// "resource" -> "Resource". Server values are lowercase slugs; anything
/// unrecognised is still shown rather than dropped.
String forYouTypeLabel(String type) {
  if (type.isEmpty) return 'Other';
  return type[0].toUpperCase() + type.substring(1).toLowerCase();
}

IconData forYouRequirementIcon(ForYouRequirement requirement) {
  switch (requirement) {
    case ForYouRequirement.campusWifi:
      return Iconsax.wifi;
    case ForYouRequirement.studentEmail:
      return Iconsax.message_programming;
    case ForYouRequirement.vtopLogin:
      return Iconsax.lock_copy;
  }
}

/// Badge-length wording.
String forYouRequirementLabel(ForYouRequirement requirement) {
  switch (requirement) {
    case ForYouRequirement.campusWifi:
      return 'Campus Wi-Fi';
    case ForYouRequirement.studentEmail:
      return 'Student Email';
    case ForYouRequirement.vtopLogin:
      return 'VTOP login';
  }
}

/// Sentence-length wording, for the detail page callout.
String forYouRequirementDescription(ForYouRequirement requirement) {
  switch (requirement) {
    case ForYouRequirement.campusWifi:
      return 'This only works while you are connected to the university Wi-Fi.';
    case ForYouRequirement.studentEmail:
      return 'This requires a VIT-AP Stuedent Email.';
    case ForYouRequirement.vtopLogin:
      return 'You will need to sign in with your own VTOP credentials.';
  }
}

/// The type pill used on cards and in the submit preview.
class ForYouTypeChip extends StatelessWidget {
  const ForYouTypeChip({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(forYouTypeIcon(type), size: 12, color: colors.onSurfaceVariant),
          const SizedBox(width: 4),
          // Ellipsis rather than a hard clip: if a future type really is too
          // long for the card, it should read as truncated instead of looking
          // like a rendering fault.
          Flexible(
            child: Text(
              forYouTypeLabel(type),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact prerequisite marker for the card. Icon only — the card has no room
/// for the wording, and the detail page spells it out.
class ForYouRequirementBadge extends StatelessWidget {
  const ForYouRequirementBadge({super.key, required this.requirement});

  final ForYouRequirement requirement;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Tooltip(
      message: forYouRequirementLabel(requirement),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.tertiaryContainer,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Icon(
          forYouRequirementIcon(requirement),
          size: 12,
          color: colors.onTertiaryContainer,
        ),
      ),
    );
  }
}

/// Full-width prerequisite callout for the detail page.
class ForYouRequirementCallout extends StatelessWidget {
  const ForYouRequirementCallout({super.key, required this.requirement});

  final ForYouRequirement requirement;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            forYouRequirementIcon(requirement),
            size: 18,
            color: colors.onTertiaryContainer,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Needs ${forYouRequirementLabel(requirement)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colors.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  forYouRequirementDescription(requirement),
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Free-text caveat from the feed, for the detail page.
class ForYouNoteCallout extends StatelessWidget {
  const ForYouNoteCallout({super.key, required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Iconsax.info_circle_copy,
            size: 18,
            color: colors.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              note,
              style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
