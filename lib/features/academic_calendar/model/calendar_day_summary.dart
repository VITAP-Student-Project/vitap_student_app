import 'package:vit_ap_student_app/core/models/academic_calendar.dart';

/// What a calendar day is, as far as the app cares.
///
/// VTOP has no such field — this is read off the description and label it does
/// send, so that the list can colour a day without every screen re-deriving it.
enum CalendarDayKind { working, exam, holiday, noInstruction, other }

/// The qualifiers VTOP reuses on every entry. Anything else in that position is
/// the name of a specific day, which is the more useful thing to show.
const _genericLabels = {
  'WorkingDay',
  'Holiday',
  'Exam Days',
  'No Instructional Day',
};

/// One calendar entry, reduced to what a list row needs.
typedef CalendarEntrySummary = ({CalendarDayKind kind, String headline});

/// Strips VTOP's class-group suffix from a description.
///
/// Every description ends with the class group it belongs to —
/// "CAT - I - General (Semester)". Dropping it leaves the part that identifies
/// the day. The suffix is taken from the *last* " - " so that a description
/// with its own dash, like "CAT - I", survives intact.
String _withoutClassGroup(String description) {
  if (!description.endsWith(')')) return description;

  final separator = description.lastIndexOf(' - ');
  if (separator < 0) return description;

  return description.substring(0, separator).trim();
}

/// Reduces one calendar entry to a kind and the single line worth showing.
///
/// Which field carries the headline depends on the day, which is why this is
/// not just a field read. An exam names itself in the description ("CAT - I")
/// under a generic "Exam Days" label; a named holiday does the opposite,
/// keeping a generic "Holiday - General (Semester)" description and putting
/// "Independence Day" in the label.
CalendarEntrySummary summariseCalendarEvent(CalendarEvent event) {
  final description = _withoutClassGroup(event.description);
  final label = event.label.trim();

  // The kind comes from the description: it is the field that stays consistent
  // when a holiday is a named one.
  final kind = label == 'Exam Days'
      ? CalendarDayKind.exam
      : description.startsWith('No Instructional')
      ? CalendarDayKind.noInstruction
      : description.startsWith('Holiday')
      ? CalendarDayKind.holiday
      : description.startsWith('Instructional Day')
      ? CalendarDayKind.working
      : CalendarDayKind.other;

  // A label that is not one of the stock qualifiers is the name of the day.
  final headline = label.isNotEmpty && !_genericLabels.contains(label)
      ? label
      : description;

  return (kind: kind, headline: headline);
}

/// Every entry on a day, summarised. Empty when VTOP listed nothing.
List<CalendarEntrySummary> summariseCalendarDay(CalendarDay day) =>
    day.events.map(summariseCalendarEvent).toList();

/// The kind a whole day reads as, used to colour its row.
///
/// A day with several entries takes the most notable one: an exam or a holiday
/// is the thing worth seeing at a glance, not the working day it shares a cell
/// with.
CalendarDayKind calendarDayKind(CalendarDay day) {
  const priority = [
    CalendarDayKind.exam,
    CalendarDayKind.holiday,
    CalendarDayKind.noInstruction,
    CalendarDayKind.other,
    CalendarDayKind.working,
  ];

  final kinds = summariseCalendarDay(day).map((entry) => entry.kind).toSet();
  if (kinds.isEmpty) return CalendarDayKind.other;

  return priority.firstWhere(
    kinds.contains,
    orElse: () => CalendarDayKind.other,
  );
}
