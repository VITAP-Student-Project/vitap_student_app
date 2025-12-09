import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'exam_date_utils.dart';
import 'exam_type_utils.dart';

/// Utility functions for working with exam schedules

/// Finds the tab index of the next upcoming exam from the schedule list
///
/// This function searches through all exam schedules and their subjects to find
/// the earliest upcoming exam date. It returns the corresponding tab index based
/// on the exam type (CAT1, CAT2, or FAT).
///
/// Returns:
/// - Tab index (0, 1, or 2) if an upcoming exam is found
/// - null if no upcoming exams exist or if exam type is unrecognized
int? findUpcomingExamTabIndex(List<ExamSchedule> schedule) {
  final today = stripTime(DateTime.now());
  DateTime? earliestDate;
  String? earliestExamType;

  for (final examBlock in schedule) {
    for (final subject in examBlock.subjects) {
      final date = parseExamDate(subject.date);
      if (date == null) continue;

      final examDay = stripTime(date);
      if (examDay.isBefore(today)) continue;

      final currentEarliest = earliestDate;

      if (currentEarliest == null || examDay.isBefore(currentEarliest)) {
        earliestDate = examDay;
        earliestExamType = examBlock.examType;
      }
    }
  }

  if (earliestExamType == null) return null;
  return examTypeToTabIndex(earliestExamType);
}

/// Checks if there are any upcoming exams in the schedule
bool hasUpcomingExams(List<ExamSchedule> schedule) {
  final today = stripTime(DateTime.now());

  for (final examBlock in schedule) {
    for (final subject in examBlock.subjects) {
      final date = parseExamDate(subject.date);
      if (date == null) continue;

      final examDay = stripTime(date);
      if (examDay.isAfter(today) || examDay.isAtSameMomentAs(today)) {
        return true;
      }
    }
  }

  return false;
}

/// Gets the count of exams in a specific exam type (CAT1, CAT2, or FAT)
int getExamCountByType(List<ExamSchedule> schedule, String examType) {
  final targetExamType = examType.toUpperCase().trim();

  for (final examBlock in schedule) {
    if (examBlock.examType.toUpperCase().trim() == targetExamType) {
      return examBlock.subjects.length;
    }
  }

  return 0;
}

/// Gets all exam dates from the schedule, sorted chronologically
List<DateTime> getAllExamDates(List<ExamSchedule> schedule) {
  final dates = <DateTime>[];

  for (final examBlock in schedule) {
    for (final subject in examBlock.subjects) {
      final date = parseExamDate(subject.date);
      if (date != null) {
        dates.add(date);
      }
    }
  }

  dates.sort((a, b) => a.compareTo(b));
  return dates;
}
