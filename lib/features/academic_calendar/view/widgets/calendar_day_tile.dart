import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/models/academic_calendar.dart';
import 'package:vit_ap_student_app/features/academic_calendar/model/calendar_day_summary.dart';

/// One day of the academic calendar.
///
/// A working day is deliberately quiet — most of a semester is working days,
/// and if they all carried a chip the exam block would not stand out from them.
class CalendarDayTile extends StatelessWidget {
  final CalendarDay day;
  final bool isToday;

  const CalendarDayTile({super.key, required this.day, this.isToday = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final entries = summariseCalendarDay(day);
    final kind = calendarDayKind(day);
    final accent = _accentFor(kind, colorScheme);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isToday
            ? colorScheme.secondaryContainer
            : colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: isToday
            ? Border.all(color: colorScheme.secondary, width: 1.5)
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: accent ?? colorScheme.onSurface,
                  ),
                ),
                Text(
                  _shortWeekday(day.weekday),
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (entries.isEmpty)
                  Text(
                    'Nothing listed',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  )
                else
                  for (final entry in entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(
                        entry.headline,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: entry.kind == CalendarDayKind.working
                              ? FontWeight.w400
                              : FontWeight.w600,
                          color: entry.kind == CalendarDayKind.working
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onSurface,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          if (accent != null) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
          ],
        ],
      ),
    );
  }

  /// Null for the days that need no marking: a working day is the default state
  /// of the semester, not a status.
  Color? _accentFor(CalendarDayKind kind, ColorScheme colorScheme) =>
      switch (kind) {
        CalendarDayKind.exam => colorScheme.primary,
        CalendarDayKind.holiday => colorScheme.tertiary,
        CalendarDayKind.noInstruction => colorScheme.outline,
        CalendarDayKind.working || CalendarDayKind.other => null,
      };

  /// VTOP shouts the weekday ("SATURDAY"); three letters is all the column has
  /// room for anyway.
  String _shortWeekday(String weekday) {
    if (weekday.length < 3) return weekday;
    final short = weekday.substring(0, 3);
    return short[0].toUpperCase() + short.substring(1).toLowerCase();
  }
}
