import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/class_detail_bottom_sheet.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/class_occurrence.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/collapsed_class_strip.dart';

/// Everything already finished today, folded into one row.
///
/// If each finished class kept a strip of its own, then by evening you'd scroll
/// past your own history to reach the class you actually need — which is exactly
/// the failure the old carousel had. Collapsed by default, the past costs one row
/// and the open card stays near the top of the section all day.
///
/// Rows in here open the detail sheet instead of expanding. The group *is* the
/// expansion, and a finished class has no progress left to show.
class CompletedClassesGroup extends StatefulWidget {
  const CompletedClassesGroup({
    super.key,
    required this.completed,
    required this.now,
    this.suffix = 'done earlier',
  });

  final List<ClassOccurrence> completed;
  final DateTime now;

  /// Reads "3 done earlier" mid-day and "3 done today" once the day is over,
  /// where "earlier" would wrongly imply something is still coming.
  final String suffix;

  @override
  State<CompletedClassesGroup> createState() => _CompletedClassesGroupState();
}

class _CompletedClassesGroupState extends State<CompletedClassesGroup> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final int count = widget.completed.length;

    return AnimatedSize(
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOutCubicEmphasized,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 18,
                      color: cs.onSurfaceVariant,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '$count ${widget.suffix}',
                        style: tt.labelLarge?.copyWith(
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutCubic,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 22,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (final ClassOccurrence occurrence in widget.completed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CollapsedClassStrip(
                        key: ValueKey<String>('done-${occurrence.key}'),
                        occurrence: occurrence,
                        now: widget.now,
                        dimmed: true,
                        onTap: () =>
                            showClassDetailBottomSheet(context, occurrence),
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
