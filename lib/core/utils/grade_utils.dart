import 'package:flutter/material.dart';

Color getGradeColor(String grade) {
  switch (grade.toUpperCase()) {
    case 'S':
    case 'A+':
    case 'A':
      return const Color(0xFF4CAF50); // Green for excellent grades
    case 'B+':
    case 'B':
      return const Color(0xFF8BC34A); // Light green for good grades
    case 'C+':
    case 'C':
      return const Color(0xFFFF9800); // Orange for average grades
    case 'D':
      return const Color(0xFFFF5722); // Red-orange for poor grades
    case 'F':
    case 'RA':
      return const Color(0xFFF44336); // Red for failing grades
    case 'W':
    case 'I':
      return const Color(0xFF9E9E9E); // Grey for withdrawn/incomplete
    case 'P':
      return const Color(0xFF2196F3); // Blue for pass
    default:
      return const Color(0xFF607D8B); // Blue-grey for unknown grades
  }
}

String getGradeDescription(String grade) {
  switch (grade.toUpperCase()) {
    case 'S':
      return 'Outstanding';
    case 'A+':
      return 'Excellent+';
    case 'A':
      return 'Excellent';
    case 'B+':
      return 'Very Good+';
    case 'B':
      return 'Very Good';
    case 'C+':
      return 'Good+';
    case 'C':
      return 'Good';
    case 'D':
      return 'Satisfactory';
    case 'F':
      return 'Fail';
    case 'RA':
      return 'Re-appear';
    case 'W':
      return 'Withdrawn';
    case 'I':
      return 'Incomplete';
    case 'P':
      return 'Pass';
    default:
      return grade;
  }
}
