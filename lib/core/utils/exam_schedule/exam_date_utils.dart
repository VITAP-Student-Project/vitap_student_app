import 'exam_constants.dart';

/// Utility functions for parsing and manipulating exam dates

/// Parses exam date string into DateTime.
///
/// Expected format: DD-MMM-YYYY (e.g., "18-Aug-2025")
/// - DD: Two-digit day (01-31)
/// - MMM: Three-letter month abbreviation (Jan, Feb, Mar, etc.)
/// - YYYY: Four-digit year
///
/// Returns null if the date string is invalid or cannot be parsed.
DateTime? parseExamDate(String dateStr) {
  try {
    final dateParts = dateStr.split('-');
    if (dateParts.length != 3) return null;

    final day = int.tryParse(dateParts[0]);
    final month = monthAbbreviations[dateParts[1]];
    final year = int.tryParse(dateParts[2]);

    if (day == null || month == null || year == null) return null;
    return DateTime(year, month, day);
  } catch (_) {
    return null;
  }
}

/// Strips time from a DateTime, returning only the date component.
///
/// This is useful for date comparisons where time should be ignored.
DateTime stripTime(DateTime date) => DateTime(date.year, date.month, date.day);
