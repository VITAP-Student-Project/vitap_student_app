/// Utility functions for working with exam types (CAT1, CAT2, FAT)

/// Exam type constants
class ExamType {
  static const String cat1 = 'CAT1';
  static const String cat2 = 'CAT2';
  static const String fat = 'FAT';
}

/// Converts exam type string to corresponding tab index
///
/// Returns:
/// - 0 for CAT1
/// - 1 for CAT2
/// - 2 for FAT
/// - null for unrecognized exam types
int? examTypeToTabIndex(String examType) {
  switch (examType.toUpperCase().trim()) {
    case 'CAT1':
      return 0;
    case 'CAT2':
      return 1;
    case 'FAT':
      return 2;
    default:
      return null;
  }
}

/// Converts tab index to exam type string
///
/// Returns:
/// - 'CAT1' for index 0
/// - 'CAT2' for index 1
/// - 'FAT' for index 2
/// - null for invalid indices
String? tabIndexToExamType(int index) {
  switch (index) {
    case 0:
      return ExamType.cat1;
    case 1:
      return ExamType.cat2;
    case 2:
      return ExamType.fat;
    default:
      return null;
  }
}
