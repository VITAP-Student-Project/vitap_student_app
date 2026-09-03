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

/// A row deletion held back until the relations pointing at it are rewritten.
typedef DeferredDelete = void Function();

/// Plans the deletion of every row [updated] is about to leave behind.
///
/// The deletions are *returned* rather than performed. ObjectBox tracks the
/// links a relation holds, and a `clear()` queues the removal of each one; if
/// the row itself is already gone by the time the queue is applied, the `put`
/// fails with "404 — unknown native error" as it tries to unlink something that
/// no longer exists.
///
/// So the ids are read here, while [existing] still points at them and the
/// relations still resolve, and the rows are deleted once the user has been
/// written. See [saveUser] for the order.
List<DeferredDelete> planOrphanRemoval(
  Store store,
  User existing,
  User updated,
) {
  final deletes = <DeferredDelete>[];

  _planOrphans<Attendance>(
    deletes,
    store.box<Attendance>(),
    existing.attendance,
    updated.attendance,
    (row) => row.id,
  );

  _planOrphans<ExamSchedule>(
    deletes,
    store.box<ExamSchedule>(),
    existing.examSchedule,
    updated.examSchedule,
    (row) => row.id,
    alsoRemove: (deletes, exam) => _planRemoval(
      deletes,
      store.box<Subject>(),
      exam.subjects.map((subject) => subject.id),
    ),
  );

  _planOrphans<Mark>(
    deletes,
    store.box<Mark>(),
    existing.marks,
    updated.marks,
    (row) => row.id,
    alsoRemove: (deletes, mark) => _planRemoval(
      deletes,
      store.box<Detail>(),
      mark.details.map((detail) => detail.id),
    ),
  );

  _planOrphans<Profile>(
    deletes,
    store.box<Profile>(),
    _target(existing.profile),
    _target(updated.profile),
    (row) => row.id,
    alsoRemove: (deletes, profile) {
      final gradeHistory = profile.gradeHistory.target;
      if (gradeHistory != null) {
        _planRemoval(
          deletes,
          store.box<Course>(),
          gradeHistory.courses.map((course) => course.id),
        );
        _planRemoval(deletes, store.box<GradeHistory>(), [gradeHistory.id]);
      }
      _planRemoval(deletes, store.box<MentorDetails>(), [
        profile.mentorDetails.target?.id,
      ]);
    },
  );

  _planOrphans<Timetable>(
    deletes,
    store.box<Timetable>(),
    _target(existing.timetable),
    _target(updated.timetable),
    (row) => row.id,
    alsoRemove: (deletes, timetable) => _planRemoval(
      deletes,
      store.box<Day>(),
      _everyDay(timetable).map((day) => day.id),
    ),
  );

  _planOrphans<CapstoneAttendance>(
    deletes,
    store.box<CapstoneAttendance>(),
    _target(existing.capstoneAttendance),
    _target(updated.capstoneAttendance),
    (row) => row.id,
    alsoRemove: (deletes, capstone) => _planRemoval(
      deletes,
      store.box<CapstonePunch>(),
      capstone.punches.map((punch) => punch.id),
    ),
  );

  return deletes;
}

/// Every row belonging to the signed-in student.
///
/// Used on logout and when a different account logs in: without it the previous
/// student's attendance, marks, timetable and profile stay on the device, and
/// the next account's data is written alongside them.
///
/// [keepSemesters] is set on the login path. The semester cache is the one
/// thing that is filled in *before* the user row is written — the student picks
/// a semester, that choice is marked in the cache, and only then does login
/// run. Clearing it there throws away the selection that was just made, and the
/// account page goes back to reading "Select Semester".
void removeAllUserData(Store store, {bool keepSemesters = false}) {
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

  // The academic calendar hangs off a semester rather than off the user, so
  // removing the user row does not take it with it.
  store.box<AcademicCalendar>().removeAll();
  store.box<CalendarMonthRef>().removeAll();
  store.box<CalendarDay>().removeAll();
  store.box<CalendarEvent>().removeAll();

  if (!keepSemesters) store.box<SemesterCache>().removeAll();
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

void _planOrphans<T>(
  List<DeferredDelete> deletes,
  Box<T> box,
  Iterable<T> current,
  Iterable<T> replacement,
  int? Function(T row) idOf, {
  void Function(List<DeferredDelete> deletes, T orphan)? alsoRemove,
}) {
  final orphans = orphanedIds(current.map(idOf), replacement.map(idOf)).toSet();
  if (orphans.isEmpty) return;

  // Children first: once the parent row is gone there is nothing left to read
  // the child ids from — which is also why the ids are read now rather than
  // when the deletions run.
  if (alsoRemove != null) {
    for (final row in current) {
      if (orphans.contains(idOf(row))) alsoRemove(deletes, row);
    }
  }

  _planRemoval(deletes, box, orphans);
}

void _planRemoval<T>(
  List<DeferredDelete> deletes,
  Box<T> box,
  Iterable<int?> ids,
) {
  final stored = _stored(ids).toList();
  if (stored.isNotEmpty) deletes.add(() => box.removeMany(stored));
}

/// Writes a user to the database, whether it is a refresh or a fresh sign-in.
///
/// Returns the stored row's id.
///
/// Kept out of the notifier so that it can be tested against a real store: the
/// bugs this code has had were never in the object graph, they were in what a
/// `put` does to relations, which nothing but ObjectBox itself can tell you.
int saveUser(Store store, User user) {
  final userBox = store.box<User>();
  final id = user.id;

  if (id != null && id > 0) {
    final existing = userBox.get(id);
    if (existing != null) {
      // Work out what this refresh unlinks while `existing` still points at
      // it, but delete nothing yet: the rows have to outlive the put that
      // removes the links to them.
      final deletes = planOrphanRemoval(store, existing, user);

      applyRefreshedUser(existing, user);
      final savedId = userBox.put(existing);

      // ObjectBox does not cascade a delete, so anything skipped here stays in
      // the database unreferenced and forever.
      for (final delete in deletes) {
        delete();
      }
      return savedId;
    }
    return userBox.put(user);
  }

  // A different account signing in: clear the previous student's rows, not just
  // their user row, or their data stays on the device alongside the new
  // account's. The semester cache is spared — by this point the student has
  // already chosen a semester and that choice lives there.
  removeAllUserData(store, keepSemesters: true);
  return userBox.put(user);
}
