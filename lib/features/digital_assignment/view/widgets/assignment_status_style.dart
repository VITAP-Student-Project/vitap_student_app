import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/digital_assignment/model/digital_assignment_model.dart';
import 'package:vit_ap_student_app/features/digital_assignment/utils/assignment_schedule.dart';

/// How one assignment's state should read.
///
/// Every colour comes from [ColorScheme]. Status used to be `Colors.green` and
/// `Colors.orange`, which sit off the seeded palette in light mode and glare in
/// dark — and at the 12% alpha they were drawn with, all but disappeared on a
/// cream surface.
class AssignmentStatusStyle {
  const AssignmentStatusStyle({
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;

  /// The deadline in words, or what happened to it.
  final String label;
}

AssignmentStatusStyle assignmentStatusStyle(
  BuildContext context,
  AssignmentDetail detail, {
  DateTime? now,
}) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  final DueUrgency urgency = assignmentUrgency(detail, now: now);

  return switch (urgency) {
    DueUrgency.done => AssignmentStatusStyle(
      color: cs.primary,
      icon: Iconsax.tick_circle,
      label: detail.submissionStatus.trim().isEmpty
          ? 'Submitted'
          : detail.submissionStatus.trim(),
    ),
    DueUrgency.missed => AssignmentStatusStyle(
      color: cs.error,
      icon: Iconsax.close_circle,
      label: 'Missed · ${dueLabel(detail.dueDate, now: now)}',
    ),
    DueUrgency.overdue => AssignmentStatusStyle(
      color: cs.error,
      icon: Iconsax.clock,
      label: dueLabel(detail.dueDate, now: now),
    ),
    DueUrgency.imminent || DueUrgency.soon => AssignmentStatusStyle(
      color: cs.tertiary,
      icon: Iconsax.clock,
      label: dueLabel(detail.dueDate, now: now),
    ),
    DueUrgency.later => AssignmentStatusStyle(
      color: cs.onSurfaceVariant,
      icon: Iconsax.clock,
      label: dueLabel(detail.dueDate, now: now),
    ),
  };
}
