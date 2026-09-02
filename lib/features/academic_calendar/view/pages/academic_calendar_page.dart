import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/constants/analytics_constants.dart';
import 'package:vit_ap_student_app/core/models/academic_calendar.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/academic_calendar/model/calendar_grouping.dart';
import 'package:vit_ap_student_app/features/academic_calendar/view/widgets/calendar_day_tile.dart';
import 'package:vit_ap_student_app/features/academic_calendar/viewmodel/academic_calendar_viewmodel.dart';

class AcademicCalendarPage extends ConsumerStatefulWidget {
  const AcademicCalendarPage({super.key});

  @override
  ConsumerState<AcademicCalendarPage> createState() =>
      _AcademicCalendarPageState();
}

class _AcademicCalendarPageState extends ConsumerState<AcademicCalendarPage> {
  /// The month being viewed, as VTOP's own `calDate`.
  String? _selectedMonth;

  @override
  void initState() {
    super.initState();
    ref.read(analyticsServiceProvider).logScreen('AcademicCalendarPage');
    // Reads the stored calendar. Fetching is an explicit act: a refresh is one
    // request per month, and VTOP can demand an OTP for any of them.
    Future.microtask(
      () => ref.read(academicCalendarViewModelProvider.notifier).loadCached(),
    );
  }

  Future<void> _refresh() async {
    ref.read(analyticsServiceProvider).logEvent(
      AnalyticsEvents.refreshInitiated,
      {AnalyticsParams.dataType: 'academic_calendar'},
    );
    await ref
        .read(academicCalendarViewModelProvider.notifier)
        .refreshCalendar();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(academicCalendarViewModelProvider);
    final calendar = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Academic Calendar',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            if (calendar?.fetchedAt != null)
              Text(
                'Last Synced: ${timeago.format(calendar!.fetchedAt!)} 💾',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.refresh_copy,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: state.isLoading ? null : _refresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: switch (state) {
        AsyncLoading() => const _LoadingCalendar(),
        AsyncError(:final error) => ErrorContentView(error: error.toString()),
        _ when calendar == null || calendar.days.isEmpty =>
          const _NoCalendarYet(),
        _ => _CalendarBody(
          calendar: calendar,
          selectedMonth: _selectedMonth ??= monthToOpen(
            calendar,
            DateTime.now(),
          ),
          onMonthSelected: (calDate) =>
              setState(() => _selectedMonth = calDate),
        ),
      },
    );
  }
}

/// The refresh is a request per month, so it is slow enough to need saying so.
class _LoadingCalendar extends StatelessWidget {
  const _LoadingCalendar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Loader(),
          const SizedBox(height: 16),
          Text(
            'Reading the calendar, a month at a time…',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoCalendarYet extends StatelessWidget {
  const _NoCalendarYet();

  @override
  Widget build(BuildContext context) {
    return const EmptyContentView(
      primaryText: 'No calendar saved yet',
      secondaryText: 'Tap refresh to read it from VTOP',
    );
  }
}

class _CalendarBody extends StatelessWidget {
  final AcademicCalendar calendar;
  final String? selectedMonth;
  final ValueChanged<String> onMonthSelected;

  const _CalendarBody({
    required this.calendar,
    required this.selectedMonth,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<CalendarDay> days = selectedMonth == null
        ? const []
        : daysOfMonth(calendar, selectedMonth!);
    final todayIso = DateTime.now().toIso8601String().substring(0, 10);

    return Column(
      children: [
        _MonthStrip(
          months: calendar.months.toList(),
          selected: selectedMonth,
          onSelected: onMonthSelected,
        ),
        Expanded(
          child: days.isEmpty
              ? const EmptyContentView(
                  primaryText: 'Nothing for this month',
                  secondaryText: 'VTOP listed no days here',
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 24),
                  itemCount: days.length,
                  itemBuilder: (context, index) => CalendarDayTile(
                    day: days[index],
                    isToday: days[index].date == todayIso,
                  ),
                ),
        ),
      ],
    );
  }
}

class _MonthStrip extends StatelessWidget {
  final List<CalendarMonthRef> months;
  final String? selected;
  final ValueChanged<String> onSelected;

  const _MonthStrip({
    required this.months,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: months.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final month = months[index];
          final isSelected = month.calDate == selected;

          return GestureDetector(
            onTap: () => onSelected(month.calDate),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.secondaryContainer
                    : colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                month.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
