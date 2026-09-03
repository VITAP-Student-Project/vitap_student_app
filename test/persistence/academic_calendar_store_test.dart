import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vit_ap_student_app/core/models/academic_calendar.dart';
import 'package:vit_ap_student_app/features/academic_calendar/repository/academic_calendar_repository.dart';

import '../helpers/object_box_test_store.dart';

AcademicCalendar calendar({
  String semesterId = 'AP2026272',
  int dayCount = 31,
  String description = 'Instructional Day - General (Semester)',
}) => AcademicCalendar(
  semesterId: semesterId,
  classGroupId: defaultClassGroup,
  months: ToMany<CalendarMonthRef>(
    items: [
      CalendarMonthRef(label: 'AUG-2026', calDate: '01-AUG-2026'),
      CalendarMonthRef(label: 'SEP-2026', calDate: '01-SEP-2026'),
    ],
  ),
  days: ToMany<CalendarDay>(
    items: [
      for (var i = 1; i <= dayCount; i++)
        CalendarDay(
          date: '2026-08-${i.toString().padLeft(2, '0')}',
          day: i,
          weekday: 'Monday',
          events: ToMany<CalendarEvent>(
            items: [
              CalendarEvent(description: description, label: 'WorkingDay'),
            ],
          ),
        ),
    ],
  ),
);

void main() {
  // Without the native library there is no store to test against. Skip rather
  // than fail: `flutter test` should still pass on a fresh checkout.
  if (!objectBoxAvailable) {
    test('persistence', () {}, skip: objectBoxMissingReason);
    return;
  }

  late TestStore t;

  setUp(() => t = TestStore.open());

  test('stores the whole calendar', () {
    saveCalendar(t.store, calendar());

    final stored = t.box<AcademicCalendar>().getAll().single;
    expect(stored.days, hasLength(31));
    expect(stored.months, hasLength(2));
    expect(stored.days.first.events, hasLength(1));
    expect(t.count<CalendarDay>(), 31);
    expect(t.count<CalendarEvent>(), 31);
    expect(t.count<CalendarMonthRef>(), 2);
  });

  /// A calendar is ~180 days and as many events. ObjectBox does not cascade a
  /// delete, so a refresh that only replaced the parent row would leave every
  /// one of them behind, every time.
  test('a refresh replaces the calendar rather than piling it up', () {
    for (var i = 0; i < 4; i++) {
      saveCalendar(t.store, calendar());
    }

    expect(t.count<AcademicCalendar>(), 1);
    expect(t.count<CalendarDay>(), 31);
    expect(t.count<CalendarEvent>(), 31);
    expect(t.count<CalendarMonthRef>(), 2);
  });

  test('the replacement is what is read back', () {
    saveCalendar(
      t.store,
      calendar(description: 'Holiday - General (Semester)'),
    );
    saveCalendar(
      t.store,
      calendar(description: 'CAT - I - General (Semester)'),
    );

    final stored = t.box<AcademicCalendar>().getAll().single;
    expect(
      stored.days.first.events.first.description,
      'CAT - I - General (Semester)',
    );
  });

  /// Different semesters are separate calendars, not replacements of one
  /// another — switching semester should not wipe the one already stored.
  test('a different semester is stored alongside', () {
    saveCalendar(t.store, calendar(semesterId: 'AP2026272'));
    saveCalendar(t.store, calendar(semesterId: 'AP2025264', dayCount: 10));

    expect(t.count<AcademicCalendar>(), 2);
    expect(t.count<CalendarDay>(), 41);
  });
}
