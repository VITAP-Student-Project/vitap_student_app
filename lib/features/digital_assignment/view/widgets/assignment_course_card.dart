import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/features/digital_assignment/model/digital_assignment_model.dart';
import 'package:vit_ap_student_app/features/digital_assignment/utils/assignment_schedule.dart';
import 'package:vit_ap_student_app/features/digital_assignment/utils/faculty_name.dart';
import 'package:vit_ap_student_app/features/digital_assignment/view/pages/assignment_detail_page.dart';
import 'package:vit_ap_student_app/features/digital_assignment/view/widgets/assignment_status_style.dart';

/// A course, led by the next thing actually due in it.
///
/// The counts alone — `3 Submitted`, `1 Pending` — told you how much was
/// outstanding but never *what* or *when*, so finding a deadline meant opening
/// every course in turn. Now the soonest open assignment is the line that
/// matters and the counts sit underneath it.
///
/// Also a real card rather than five widgets stacked inside `ListTile.title`
/// with `subtitle` left unused, which is what flattened the hierarchy.
class AssignmentCourseCard extends StatelessWidget {
  const AssignmentCourseCard({super.key, required this.assignment});

  final DigitalAssignment assignment;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final SubmissionCounts counts = SubmissionCounts.fromDetails(
      assignment.details,
    );
    final AssignmentDetail? next = nextActionable(assignment.details);

    return Material(
      color: cs.surfaceContainerLow,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => AssignmentDetailPage(assignment: assignment),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                assignment.courseCode,
                style: tt.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                assignment.courseTitle,
                style: tt.titleLarge?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                facultyDisplayName(assignment.faculty),
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              if (next != null)
                _NextDueLine(detail: next)
              else
                Text(
                  counts.missed > 0
                      ? 'Nothing left to submit'
                      : 'All assignments submitted',
                  style: tt.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const SizedBox(height: 10),
              _Counts(counts: counts),
            ],
          ),
        ),
      ),
    );
  }
}

/// The soonest open assignment, in the card's most prominent slot after the
/// course name.
class _NextDueLine extends StatelessWidget {
  const _NextDueLine({required this.detail});

  final AssignmentDetail detail;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final AssignmentStatusStyle status = assignmentStatusStyle(context, detail);

    return Row(
      children: <Widget>[
        Icon(status.icon, size: 16, color: status.color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            '${status.label}  ·  ${detail.assignmentTitle}',
            style: tt.labelLarge?.copyWith(
              color: status.color,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Progress through the course, demoted to a quiet summary line.
class _Counts extends StatelessWidget {
  const _Counts({required this.counts});

  final SubmissionCounts counts;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final List<String> parts = <String>[
      if (counts.submitted > 0) '${counts.submitted} submitted',
      if (counts.pending > 0) '${counts.pending} pending',
      if (counts.missed > 0) '${counts.missed} missed',
    ];
    if (parts.isEmpty) return const SizedBox.shrink();

    return Text(
      '${parts.join('  ·  ')}  of ${counts.total}',
      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
    );
  }
}
