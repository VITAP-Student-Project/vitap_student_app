import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/utils/format_to_12_hour.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/class_detail_bottom_sheet.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/class_occurrence.dart';

/// The one open card in the Today stack.
///
/// Exactly one class is expanded at a time — the one happening now, or the one
/// coming next. Status is carried by the card's own fill rather than a coloured
/// chip, so the card that matters is the only saturated thing on the screen.
///
/// Three text tiers, never two emphasised lines touching: a muted course-code
/// overline, the course name as the single large element, and a quiet venue/time
/// line. Faculty and slot are deliberately absent — they live in the detail sheet.
class ExpandedClassCard extends StatelessWidget {
  const ExpandedClassCard({
    super.key,
    required this.occurrence,
    required this.now,
  });

  final ClassOccurrence occurrence;

  /// The moment the whole stack is rendering against, so the card, the strips and
  /// the header badge can never disagree about which class is live.
  final DateTime now;

  static const double _radius = 28;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final ClassPhase phase = occurrence.phaseAt(now);
    final bool isOngoing = phase == ClassPhase.ongoing;

    final Color background = isOngoing
        ? cs.primaryContainer
        : cs.surfaceContainerHigh;
    final Color foreground = isOngoing ? cs.onPrimaryContainer : cs.onSurface;
    final Color muted = isOngoing
        ? cs.onPrimaryContainer.withValues(alpha: 0.72)
        : cs.onSurfaceVariant;

    final String overline = <String?>[
      occurrence.info.courseCode,
      occurrence.info.courseType,
    ].where((String? s) => (s ?? '').trim().isNotEmpty).join(' · ');

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(_radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showClassDetailBottomSheet(context, occurrence),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      overline.isEmpty ? 'CLASS' : overline.toUpperCase(),
                      style: tt.labelSmall?.copyWith(
                        color: muted,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _StatusPill(occurrence: occurrence, now: now),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                occurrence.info.courseName ?? 'Class',
                style: tt.headlineSmall?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                  height: 1.12,
                  letterSpacing: -0.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              _MetaLine(occurrence: occurrence, color: muted),
              if (isOngoing) ...<Widget>[
                const SizedBox(height: 20),
                _OngoingProgress(
                  occurrence: occurrence,
                  now: now,
                  foreground: foreground,
                  muted: muted,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The card's state, in words: `NOW`, `IN 45M`, `TOMORROW`, `DONE`.
class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.occurrence, required this.now});

  final ClassOccurrence occurrence;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final (
      String label,
      Color background,
      Color foreground,
    ) = switch (occurrence.phaseAt(now)) {
      ClassPhase.ongoing => ('NOW', cs.primary, cs.onPrimary),
      ClassPhase.completed => (
        'DONE',
        cs.surfaceContainerHighest,
        cs.onSurfaceVariant,
      ),
      ClassPhase.upcoming => (
        _startsInLabel(),
        cs.secondaryContainer,
        cs.onSecondaryContainer,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  String _startsInLabel() {
    final Duration? until = occurrence.startsInAt(now);
    if (until == null) return 'SCHEDULED';
    return 'IN ${formatShortDuration(until).toUpperCase()}';
  }
}

/// Venue and time — the two things you act on once you know which class it is.
class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.occurrence, required this.color});

  final ClassOccurrence occurrence;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w500);

    final String venue = (occurrence.info.venue ?? '').trim();
    final String time = formatTimeRange(
      occurrence.info.startTime,
      occurrence.info.endTime,
    );

    final List<String> parts = <String>[
      if (venue.isNotEmpty) venue,
      if (time.isNotEmpty) time,
    ];
    if (parts.isEmpty) return const SizedBox.shrink();

    return Row(
      children: <Widget>[
        Icon(Icons.place_outlined, size: 16, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            parts.join('  ·  '),
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// How much of the class is behind you — the readout the whole redesign is built
/// around, and the only place a number gets emphasis on the card.
class _OngoingProgress extends StatelessWidget {
  const _OngoingProgress({
    required this.occurrence,
    required this.now,
    required this.foreground,
    required this.muted,
  });

  final ClassOccurrence occurrence;
  final DateTime now;
  final Color foreground;
  final Color muted;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final double? progress = occurrence.progressAt(now);
    final Duration? remaining = occurrence.remainingAt(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0, end: progress ?? 0),
            builder: (BuildContext context, double value, _) =>
                LinearProgressIndicator(
                  value: progress == null ? null : value,
                  minHeight: 6,
                  backgroundColor: foreground.withValues(alpha: 0.18),
                  valueColor: AlwaysStoppedAnimation<Color>(foreground),
                ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                remaining == null
                    ? 'In progress'
                    : '${formatShortDuration(remaining)} left',
                style: tt.labelLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'ends ${formatTo12Hour(occurrence.info.endTime)}',
              style: tt.labelMedium?.copyWith(color: muted),
            ),
          ],
        ),
      ],
    );
  }
}
