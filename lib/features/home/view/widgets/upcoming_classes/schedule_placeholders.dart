import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/core/constants/analytics_constants.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/timetable/viewmodel/timetable_viewmodel.dart';

/// Shown when there is no timetable stored at all.
///
/// This is the one genuinely empty state in the Today section, and the only one
/// that gets an illustration — because it's the only one with something to do
/// about it. A day off or a finished day still has a next class to point at, so
/// those keep the real card instead of dead-ending here.
class NoTimetableCard extends ConsumerWidget {
  const NoTimetableCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final bool isLoading = ref.watch(
      timetableViewModelProvider.select(
        (AsyncValue<Timetable>? v) => v?.isLoading == true,
      ),
    );

    ref.listen(timetableViewModelProvider, (_, AsyncValue<Timetable>? next) {
      next?.whenOrNull(
        error: (Object error, StackTrace _) =>
            showSnackBar(context, error.toString(), SnackBarType.error),
      );
    });

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Lottie.asset('assets/lottie/cat_sleep.json', width: 132),
          const SizedBox(height: 4),
          Text(
            'No timetable yet',
            style: tt.titleMedium?.copyWith(
              color: cs.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Sync it to see your day here',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          FilledButton.tonalIcon(
            onPressed: isLoading
                ? null
                : () {
                    ref.read(analyticsServiceProvider).logEvent(
                      AnalyticsEvents.refreshInitiated,
                      <String, Object>{AnalyticsParams.dataType: 'timetable'},
                    );
                    ref
                        .read(timetableViewModelProvider.notifier)
                        .refreshTimetable();
                  },
            icon: isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.sync_rounded, size: 18),
            label: Text(isLoading ? 'Syncing…' : 'Sync timetable'),
          ),
        ],
      ),
    );
  }
}

/// Takes the open card's slot when there is nothing left to count down to —
/// either the day's classes are all finished, or none were scheduled at all.
///
/// Deliberately stops at today rather than reaching forward to the next day's
/// timetable: a card counting down to a class that isn't today reads as if it
/// were, and being told your day is over is the clearer answer.
class NoMoreClassesCard extends StatelessWidget {
  const NoMoreClassesCard({
    super.key,
    this.primaryText = 'No more classes for the day',
    this.secondaryText = 'Time to rest 😪',
  });

  final String primaryText;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Lottie.asset('assets/lottie/cat_sleep.json', width: 140),
          Text(
            primaryText,
            style: tt.titleMedium?.copyWith(
              color: cs.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            secondaryText,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
