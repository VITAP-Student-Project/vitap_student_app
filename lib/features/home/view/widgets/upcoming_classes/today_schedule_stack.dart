import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/providers/schedule_clock.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/class_occurrence.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/collapsed_class_strip.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/completed_classes_group.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/expanded_class_card.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/schedule_placeholders.dart';

/// The whole day, as one stack of cards.
///
/// Exactly one card is open at a time — by default whichever class is happening
/// now, or the next one up — and every other class collapses to a strip. Tapping
/// a strip opens it and closes the previous one; tapping the already-open card
/// opens its detail sheet, so a tap never does two things.
///
/// This replaces the old swipe carousel, which showed one class at a time behind
/// five indicator dots and, once the day was over, kept a class that ended hours
/// ago as the most prominent thing on the home screen.
class TodayScheduleStack extends ConsumerStatefulWidget {
  const TodayScheduleStack({super.key});

  @override
  ConsumerState<TodayScheduleStack> createState() => _TodayScheduleStackState();
}

class _TodayScheduleStackState extends ConsumerState<TodayScheduleStack> {
  /// The class the user opened by hand, if any.
  String? _manualKey;

  /// The class the stack would open on its own, tracked so that when a class
  /// ends — and the default moves on — any manual choice is dropped and the
  /// stack snaps back to whatever matters now.
  String? _lastDefaultKey;

  @override
  Widget build(BuildContext context) {
    final DateTime now = watchScheduleNow(ref);
    final Timetable? timetable = ref
        .watch(currentUserProvider)
        ?.timetable
        .target;

    if (timetable == null) return const NoTimetableCard();

    final List<ClassOccurrence> today = classesOn(timetable, now);

    if (today.isEmpty) {
      return const NoMoreClassesCard(
        primaryText: 'No classes today',
        secondaryText: 'Seems like a day off 😪',
      );
    }

    final List<ClassOccurrence> completed = today
        .where((ClassOccurrence c) => c.phaseAt(now) == ClassPhase.completed)
        .toList();
    final List<ClassOccurrence> remaining = today
        .where((ClassOccurrence c) => c.phaseAt(now) != ClassPhase.completed)
        .toList();

    if (remaining.isEmpty) return _allDone(now, completed);

    // The open card is the class in progress, or the next one to start.
    final ClassOccurrence defaultOpen = remaining.firstWhere(
      (ClassOccurrence c) => c.phaseAt(now) == ClassPhase.ongoing,
      orElse: () => remaining.first,
    );
    if (_lastDefaultKey != defaultOpen.key) {
      _lastDefaultKey = defaultOpen.key;
      _manualKey = null;
    }

    final bool manualStillScheduled = remaining.any(
      (ClassOccurrence c) => c.key == _manualKey,
    );
    final String openKey = manualStillScheduled ? _manualKey! : defaultOpen.key;

    return _CardStack(
      children: <Widget>[
        if (completed.isNotEmpty)
          CompletedClassesGroup(completed: completed, now: now),
        for (final ClassOccurrence occurrence in remaining)
          _ScheduleSlot(
            key: ValueKey<String>(occurrence.key),
            occurrence: occurrence,
            now: now,
            expanded: occurrence.key == openKey,
            onExpand: () => setState(() => _manualKey = occurrence.key),
          ),
      ],
    );
  }

  /// Every class today is finished.
  ///
  /// The done group keeps the count, and the open card's slot says the day is
  /// over. It stays on today rather than counting down to tomorrow's first class,
  /// which would read as if that class were still coming up today.
  Widget _allDone(DateTime now, List<ClassOccurrence> completed) {
    return _CardStack(
      children: <Widget>[
        CompletedClassesGroup(
          completed: completed,
          now: now,
          suffix: 'done today',
        ),
        const NoMoreClassesCard(),
      ],
    );
  }
}

/// One class in the stack, morphing between its open and collapsed forms.
class _ScheduleSlot extends StatelessWidget {
  const _ScheduleSlot({
    super.key,
    required this.occurrence,
    required this.now,
    required this.expanded,
    required this.onExpand,
  });

  final ClassOccurrence occurrence;
  final DateTime now;
  final bool expanded;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 380),
      alignment: Alignment.topCenter,
      sizeCurve: Curves.easeInOutQuint,
      firstCurve: Curves.easeInOutQuint,
      secondCurve: Curves.easeInOutQuint,
      crossFadeState: expanded
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: ExpandedClassCard(occurrence: occurrence, now: now),
      secondChild: CollapsedClassStrip(
        occurrence: occurrence,
        now: now,
        onTap: onExpand,
      ),
    );
  }
}

/// Even vertical rhythm for the stack. Deliberately spaced rather than
/// overlapping — a schedule is a sequence, and overlapping cards would imply a
/// shuffleable order that doesn't exist here.
class _CardStack extends StatelessWidget {
  const _CardStack({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < children.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == children.length - 1 ? 0 : 8),
            child: children[i],
          ),
      ],
    );
  }
}
