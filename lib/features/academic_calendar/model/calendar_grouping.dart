import 'package:vit_ap_student_app/core/models/academic_calendar.dart';

/// VTOP writes months as the three letter English abbreviation.
const _monthNumbers = {
  'JAN': 1,
  'FEB': 2,
  'MAR': 3,
  'APR': 4,
  'MAY': 5,
  'JUN': 6,
  'JUL': 7,
  'AUG': 8,
  'SEP': 9,
  'OCT': 10,
  'NOV': 11,
  'DEC': 12,
};

/// The `YYYY-MM` a month button refers to, or null if it cannot be read.
///
/// The button carries VTOP's own format ("01-AUG-2026") while the days carry
/// ISO dates, so one has to be translated into the other to match them up.
String? calendarMonthKey(String calDate) {
  final parts = calDate.split('-');
  if (parts.length != 3) return null;

  final month = _monthNumbers[parts[1].toUpperCase()];
  final year = int.tryParse(parts[2]);
  if (month == null || year == null) return null;

  return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}';
}

/// The days of one month, in date order.
List<CalendarDay> daysOfMonth(AcademicCalendar calendar, String calDate) {
  final key = calendarMonthKey(calDate);
  if (key == null) return const [];

  final days = calendar.days
      .where((day) => day.date.startsWith('$key-'))
      .toList();
  days.sort((a, b) => a.date.compareTo(b.date));
  return days;
}

/// The month to open on: the one containing [today], falling back to the first.
///
/// A calendar is nearly always opened to check something about now, so landing
/// on July when it is October means scrolling before the page is any use.
/// Returns null when there are no months at all.
String? monthToOpen(AcademicCalendar calendar, DateTime today) {
  if (calendar.months.isEmpty) return null;

  final key =
      '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}';

  for (final month in calendar.months) {
    if (calendarMonthKey(month.calDate) == key) return month.calDate;
  }

  return calendar.months.first.calDate;
}
