/// Enum representing the status of an exam based on its date
enum ExamStatus {
  /// Exam is scheduled for today
  today,

  /// Exam is scheduled for a future date
  upcoming,

  /// Exam has already been completed
  completed,

  /// Exam status cannot be determined (invalid or missing date)
  unknown,
}
