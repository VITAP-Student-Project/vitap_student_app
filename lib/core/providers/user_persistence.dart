import 'package:objectbox/objectbox.dart';
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
import 'package:vit_ap_student_app/features/home/model/general_outing_report.dart';
import 'package:vit_ap_student_app/features/home/model/weekend_outing_report.dart';

/// Keeping the stored user row in step with freshly fetched data.
///
/// ObjectBox has no cascade delete. Unlinking a relation — `clear()` on a
/// [ToMany], or repointing a [ToOne] — leaves the rows themselves in the
/// database, unreferenced and forever. Since every refresh replaces a relation,
/// the database grew by a whole attendance list, marks list or timetable each
/// time the student pulled to refresh.

/// The ids a relation is about to orphan: rows it holds now that its
/// replacement does not.
///
/// The subtlety is that only one page's data is refreshed at a time. Every
/// other relation is passed straight through, still carrying its stored ids,
/// and those rows have to survive: ObjectBox will not re-insert an object that
/// already has an id, so deleting them leaves the user pointing at rows that
/// are gone. Comparing ids rather than object identity is what separates the
/// two cases — freshly parsed rows have no id yet.
List<int> orphanedIds(Iterable<int?> current, Iterable<int?> replacement) {
  final kept = _stored(replacement).toSet();
  return _stored(current).where((id) => !kept.contains(id)).toList();
}

/// Ids of rows that are actually in the database. A null or zero id means the
/// object was parsed from VTOP and has never been stored.
Iterable<int> _stored(Iterable<int?> ids) =>
    ids.whereType<int>().where((id) => id != 0);

/// Copies freshly fetched data onto the [existing] row already in the box.
///
/// Every relation the app refreshes has to be listed here. One left out is not
/// a compile error — it is silently dropped on every save after the first
/// login, so the data lives in memory for the session and is gone on restart.
void applyRefreshedUser(User existing, User updated) {
  // ToMany relations are cleared first so a refresh replaces rather than
  // appends.
  existing.attendance
    ..clear()
    ..addAll(updated.attendance);

  existing.examSchedule
    ..clear()
    ..addAll(updated.examSchedule);

  existing.marks
    ..clear()
    ..addAll(updated.marks);

  existing.profile.target = updated.profile.target;
  existing.timetable.target = updated.timetable.target;
  existing.capstoneAttendance.target = updated.capstoneAttendance.target;
}

/// Deletes the rows [updated] is about to leave behind.
///
/// Call this *before* [applyRefreshedUser], while [existing] still points at
/// what is currently stored.
void removeOrphanedUserData(Store store, User existing, User updated) {
  _removeOrphans<Attendance>(
    store.box<Attendance>(),
    existing.attendance,
    updated.attendance,
    (row) => row.id,
  );

  _removeOrphans<ExamSchedule>(
    store.box<ExamSchedule>(),
    existing.examSchedule,
    updated.examSchedule,
    (row) => row.id,
    alsoRemove: (exam) => _removeAllOf(
      store.box<Subject>(),
      exam.subjects.map((subject) => subject.id),
    ),
  );

  _removeOrphans<Mark>(
    store.box<Mark>(),
    existing.marks,
    updated.marks,
    (row) => row.id,
    alsoRemove: (mark) => _removeAllOf(
      store.box<Detail>(),
      mark.details.map((detail) => detail.id),
    ),
  );

  _removeOrphans<Profile>(
    store.box<Profile>(),
    _target(existing.profile),
    _target(updated.profile),
    (row) => row.id,
    alsoRemove: (profile) {
      final gradeHistory = profile.gradeHistory.target;
      if (gradeHistory != null) {
        _removeAllOf(
          store.box<Course>(),
          gradeHistory.courses.map((course) => course.id),
        );
        _removeAllOf(store.box<GradeHistory>(), [gradeHistory.id]);
      }
      _removeAllOf(
        store.box<MentorDetails>(),
        [profile.mentorDetails.target?.id],
      );
    },
  );

  _removeOrphans<Timetable>(
    store.box<Timetable>(),
    _target(existing.timetable),
    _target(updated.timetable),
    (row) => row.id,
    alsoRemove: (timetable) => _removeAllOf(
      store.box<Day>(),
      _everyDay(timetable).map((day) => day.id),
    ),
  );

  _removeOrphans<CapstoneAttendance>(
    store.box<CapstoneAttendance>(),
    _target(existing.capstoneAttendance),
    _target(updated.capstoneAttendance),
    (row) => row.id,
    alsoRemove: (capstone) => _removeAllOf(
      store.box<CapstonePunch>(),
      capstone.punches.map((punch) => punch.id),
    ),
  );
}

/// Every row belonging to the signed-in student.
///
/// Used on logout and when a different account logs in: without it the previous
/// student's attendance, marks, timetable and profile stay on the device, and
/// the next account's data is written alongside them.
void removeAllUserData(Store store) {
  store.box<User>().removeAll();

  store.box<Profile>().removeAll();
  store.box<GradeHistory>().removeAll();
  store.box<Course>().removeAll();
  store.box<MentorDetails>().removeAll();

  store.box<Timetable>().removeAll();
  store.box<Day>().removeAll();

  store.box<Attendance>().removeAll();
  store.box<CapstoneAttendance>().removeAll();
  store.box<CapstonePunch>().removeAll();

  store.box<ExamSchedule>().removeAll();
  store.box<Subject>().removeAll();

  store.box<Mark>().removeAll();
  store.box<Detail>().removeAll();

  store.box<GeneralOutingReport>().removeAll();
  store.box<WeekendOutingReport>().removeAll();

  store.box<SemesterCache>().removeAll();
}

/// A [ToOne] read as a list, so it can go through the same rule as a [ToMany].
List<T> _target<T>(ToOne<T> relation) {
  final target = relation.target;
  return target == null ? const [] : [target];
}

List<Day> _everyDay(Timetable timetable) => [
  ...timetable.monday,
  ...timetable.tuesday,
  ...timetable.wednesday,
  ...timetable.thursday,
  ...timetable.friday,
  ...timetable.saturday,
  ...timetable.sunday,
];

void _removeOrphans<T>(
  Box<T> box,
  Iterable<T> current,
  Iterable<T> replacement,
  int? Function(T row) idOf, {
  void Function(T orphan)? alsoRemove,
}) {
  final orphans = orphanedIds(
    current.map(idOf),
    replacement.map(idOf),
  ).toSet();
  if (orphans.isEmpty) return;

  // Children first: once the parent row is gone there is nothing left to read
  // the child ids from.
  if (alsoRemove != null) {
    for (final row in current) {
      if (orphans.contains(idOf(row))) alsoRemove(row);
    }
  }

  box.removeMany(orphans.toList());
}

void _removeAllOf<T>(Box<T> box, Iterable<int?> ids) {
  final stored = _stored(ids).toList();
  if (stored.isNotEmpty) box.removeMany(stored);
}
