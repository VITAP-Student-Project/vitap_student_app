import 'package:flutter/material.dart';
import 'exam_status.dart';
import 'exam_date_utils.dart';
import 'exam_constants.dart';

/// Utility functions for determining and working with exam status

/// Determines the status of an exam based on its date string.
///
/// Returns:
/// - [ExamStatus.today] if the exam is scheduled for today
/// - [ExamStatus.upcoming] if the exam is in the future
/// - [ExamStatus.completed] if the exam date has passed
/// - [ExamStatus.unknown] if the date cannot be parsed
ExamStatus getExamStatus(String dateStr) {
  final examDate = parseExamDate(dateStr);
  if (examDate == null) return ExamStatus.unknown;

  final today = stripTime(DateTime.now());
  final examDay = stripTime(examDate);

  if (examDay.isAtSameMomentAs(today)) return ExamStatus.today;
  if (examDay.isAfter(today)) return ExamStatus.upcoming;
  return ExamStatus.completed;
}

/// Returns the display label for a given exam status.
String getExamStatusLabel(ExamStatus status) {
  switch (status) {
    case ExamStatus.today:
      return ExamStatusLabels.today;
    case ExamStatus.upcoming:
      return ExamStatusLabels.upcoming;
    case ExamStatus.completed:
      return ExamStatusLabels.completed;
    case ExamStatus.unknown:
      return ExamStatusLabels.unknown;
  }
}

/// Returns the appropriate color for a given exam status based on the color scheme.
Color getExamStatusColor(ExamStatus status, ColorScheme colorScheme) {
  switch (status) {
    case ExamStatus.today:
      return colorScheme.primary;
    case ExamStatus.upcoming:
      return colorScheme.tertiary;
    case ExamStatus.completed:
      return colorScheme.secondary;
    case ExamStatus.unknown:
      return colorScheme.primary;
  }
}
