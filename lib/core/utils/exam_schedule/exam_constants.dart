/// Constants used for exam schedule functionality

/// Month abbreviations mapping for date parsing
const Map<String, int> monthAbbreviations = {
  'Jan': 1,
  'Feb': 2,
  'Mar': 3,
  'Apr': 4,
  'May': 5,
  'Jun': 6,
  'Jul': 7,
  'Aug': 8,
  'Sep': 9,
  'Oct': 10,
  'Nov': 11,
  'Dec': 12,
};

/// Status label mappings
class ExamStatusLabels {
  static const String today = 'Today';
  static const String upcoming = 'Upcoming';
  static const String completed = 'Completed';
  static const String unknown = 'Scheduled';
}

/// Expected exam date format: DD-MMM-YYYY (e.g., "18-Aug-2025")
/// - DD: Two-digit day (01-31)
/// - MMM: Three-letter month abbreviation (Jan, Feb, Mar, etc.)
/// - YYYY: Four-digit year
const String examDateFormat = 'DD-MMM-YYYY';
