import 'package:intl/intl.dart';

String formatTo12Hour(String? timeString) {
  if (timeString == null || timeString.trim().isEmpty) {
    return '';
  }

  try {
    final timeParts = timeString.trim().split(':').map(int.parse).toList();
    if (timeParts.length != 2) return timeString;

    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, timeParts[0], timeParts[1]);

    return DateFormat('h:mm a').format(dateTime);
  } catch (e) {
    return timeString; // Return original if parsing fails
  }
}
