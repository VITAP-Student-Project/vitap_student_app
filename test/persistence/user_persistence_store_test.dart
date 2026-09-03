import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vit_ap_student_app/core/models/academic_calendar.dart';
import 'package:vit_ap_student_app/core/models/attendance.dart';
import 'package:vit_ap_student_app/core/models/capstone_attendance.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/core/models/grade_history.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/core/models/mentor_details.dart';
import 'package:vit_ap_student_app/core/models/profile.dart';
import 'package:vit_ap_student_app/core/models/semester_cache.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/user_persistence.dart';

import '../helpers/object_box_test_store.dart';
import 'user_fixtures.dart';

void main() {
  // Without the native library there is no store to test against. Skip rather
  // than fail: `flutter test` should still pass on a fresh checkout.
  if (!objectBoxAvailable) {
    test('persistence', () {}, skip: objectBoxMissingReason);
    return;
  }

  late TestStore t;

  setUp(() => t = TestStore.open());

  /// Saves a user the way the app does, then reads the stored row back.
  User save(User user) {
    final id = saveUser(t.store, user);
    return t.box<User>().get(id)!;
  }

  group('a fresh sign-in', () {
    test('stores the whole graph', () {
      final stored = save(fullUser());

      expect(stored.attendance, hasLength(2));
      expect(stored.marks, hasLength(1));
      expect(stored.marks.first.details, hasLength(2));
      expect(stored.examSchedule, hasLength(1));
      expect(stored.examSchedule.first.subjects, hasLength(1));
      expect(stored.profile.target?.studentName, 'A Student');
      expect(stored.profile.target?.gradeHistory.target?.courses, hasLength(1));
      expect(stored.timetable.target?.monday, hasLength(1));
      expect(stored.capstoneAttendance.target?.punches, hasLength(2));
    });

    /// The bug: the login flow marks the chosen semester in this box *before*
    /// the user row is written, so clearing it here threw away the selection
    /// and the account page fell back to "Select Semester".
    test('keeps the semester the student just chose', () {
      t.box<SemesterCache>().put(
        SemesterCache(
          semesterId: 'AP2026272',
          semesterName: 'Fall Semester 2026-27',
          isSelected: true,
          updatedAt: 0,
        ),
      );

      save(fullUser());

      final semesters = t.box<SemesterCache>().getAll();
      expect(semesters, hasLength(1));
      expect(semesters.single.isSelected, isTrue);
    });

    /// A different student signing in on the same phone must not find the
    /// previous one's data sitting alongside their own.
    test('clears the previous account', () {
      save(fullUser());
      save(fullUser(studentName: 'Someone Else'));

      expect(t.count<User>(), 1);
      expect(t.count<Attendance>(), 2);
      expect(t.count<Profile>(), 1);
      expect(
        t.box<User>().getAll().single.profile.target?.studentName,
        'Someone Else',
      );
    });
  });

  group('refreshing one page', () {
    /// The bug this locks down, which shipped in #62: refreshing marks passed
    /// the capstone through with its stored id, the old row was deleted anyway,
    /// and ObjectBox will not re-insert an object that already has an id — so
    /// the capstone silently vanished.
    test('does not destroy the other pages', () {
      final stored = save(fullUser());

      final refreshed = stored.copyWith(
        marks: ToMany<Mark>(items: [mark(title: 'CAT2')]),
      );
      final after = save(refreshed);

      expect(after.marks.single.details, hasLength(2));
      expect(
        after.capstoneAttendance.target,
        isNotNull,
        reason: 'a marks refresh must not delete the capstone',
      );
      expect(after.capstoneAttendance.target!.punches, hasLength(2));
      expect(after.attendance, hasLength(2));
      expect(after.timetable.target?.monday, hasLength(1));
      expect(after.profile.target?.studentName, 'A Student');
    });

    /// The leak: `clear()` unlinks rows without deleting them, so every refresh
    /// left the whole previous list in the database.
    test('replaces rows rather than piling them up', () {
      final stored = save(fullUser());
      expect(t.count<Attendance>(), 2);

      var user = stored;
      for (var i = 0; i < 5; i++) {
        user = save(
          user.copyWith(
            attendance: ToMany<Attendance>(
              items: [attendance('CSE1008'), attendance('CSE4004')],
            ),
          ),
        );
      }

      expect(
        t.count<Attendance>(),
        2,
        reason: 'five refreshes should leave two rows, not twelve',
      );
      expect(user.attendance, hasLength(2));
    });

    test('deletes the children of the rows it replaces', () {
      final stored = save(fullUser());
      expect(t.count<Detail>(), 2);
      expect(t.count<CapstonePunch>(), 2);

      // A marks refresh brings new details.
      final afterMarks = save(
        stored.copyWith(
          marks: ToMany<Mark>(items: [mark(title: 'FAT')]),
        ),
      );
      expect(t.count<Detail>(), 2, reason: 'the old details should be gone');

      // An attendance refresh brings a new capstone with new punches.
      save(
        afterMarks.copyWith(
          capstoneAttendance: ToOne<CapstoneAttendance>(target: capstone()),
        ),
      );
      expect(
        t.count<CapstonePunch>(),
        2,
        reason: 'the old punch calendar should be gone',
      );
      expect(t.count<CapstoneAttendance>(), 1);
    });

    test('leaves nothing behind across the whole graph', () {
      var user = save(fullUser());
      for (var i = 0; i < 3; i++) {
        user = save(fullUser(id: user.id));
      }

      expect(t.count<Attendance>(), 2);
      expect(t.count<Mark>(), 1);
      expect(t.count<Detail>(), 2);
      expect(t.count<ExamSchedule>(), 1);
      expect(t.count<Subject>(), 1);
      expect(t.count<Profile>(), 1);
      expect(t.count<GradeHistory>(), 1);
      expect(t.count<Course>(), 1);
      expect(t.count<MentorDetails>(), 1);
      expect(t.count<Timetable>(), 1);
      expect(t.count<Day>(), 1);
      expect(t.count<CapstoneAttendance>(), 1);
      expect(t.count<CapstonePunch>(), 2);
    });

    test('a capstone that disappears is cleared, not left stale', () {
      final stored = save(fullUser());

      final after = save(
        stored.copyWith(capstoneAttendance: ToOne<CapstoneAttendance>()),
      );

      expect(after.capstoneAttendance.target, isNull);
      expect(t.count<CapstoneAttendance>(), 0);
      expect(t.count<CapstonePunch>(), 0);
    });
  });

  group('removeAllUserData', () {
    test('leaves no trace of the student', () {
      save(fullUser());
      t.box<SemesterCache>().put(
        SemesterCache(
          semesterId: 'AP2026272',
          semesterName: 'Fall',
          updatedAt: 0,
        ),
      );

      removeAllUserData(t.store);

      for (final count in [
        t.count<User>(),
        t.count<Attendance>(),
        t.count<Mark>(),
        t.count<Detail>(),
        t.count<ExamSchedule>(),
        t.count<Subject>(),
        t.count<Profile>(),
        t.count<GradeHistory>(),
        t.count<Course>(),
        t.count<MentorDetails>(),
        t.count<Timetable>(),
        t.count<Day>(),
        t.count<CapstoneAttendance>(),
        t.count<CapstonePunch>(),
        t.count<SemesterCache>(),
        t.count<AcademicCalendar>(),
      ]) {
        expect(count, 0);
      }
    });

    test('spares the semester cache when asked to', () {
      save(fullUser());
      t.box<SemesterCache>().put(
        SemesterCache(
          semesterId: 'AP2026272',
          semesterName: 'Fall',
          isSelected: true,
          updatedAt: 0,
        ),
      );

      removeAllUserData(t.store, keepSemesters: true);

      expect(t.count<User>(), 0);
      expect(t.count<SemesterCache>(), 1);
    });
  });
}
