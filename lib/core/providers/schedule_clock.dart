import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A coarse clock for anything that renders "now" against the timetable.
///
/// The Today stack, its progress bar and the "3 left" badge in the section header
/// all decide what to show by comparing the current time against class slots. If
/// each kept its own timer they could disagree about which class is live, so they
/// share this one instead. Thirty seconds is well under the minute granularity
/// anything displays, and `autoDispose` stops the timer as soon as the home page
/// is gone.
final scheduleClockProvider = StreamProvider.autoDispose<DateTime>(
  (Ref ref) => Stream<DateTime>.periodic(
    const Duration(seconds: 30),
    (_) => DateTime.now(),
  ),
);

/// The current time as the schedule sees it.
///
/// [scheduleClockProvider] only emits on its first tick, so callers need a value
/// for the initial frame — reading the clock directly is correct there.
DateTime watchScheduleNow(WidgetRef ref) =>
    ref.watch(scheduleClockProvider).value ?? DateTime.now();
