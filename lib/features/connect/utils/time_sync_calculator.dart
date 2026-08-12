import 'package:vit_ap_student_app/core/models/timetable.dart';

class FreeTimeBlock {
  final int startMinute;
  final int endMinute;

  FreeTimeBlock(this.startMinute, this.endMinute);

  String get formattedTime {
    return '${_formatMinute(startMinute)} - ${_formatMinute(endMinute)}';
  }

  String _formatMinute(int minutes) {
    final hh = minutes ~/ 60;
    final mm = minutes % 60;
    final amPm = hh >= 12 ? 'PM' : 'AM';
    final displayHour = hh > 12 ? hh - 12 : (hh == 0 ? 12 : hh);
    final mmStr = mm.toString().padLeft(2, '0');
    return '$displayHour:$mmStr $amPm';
  }
}

class TimeSyncCalculator {
  static const int dayStartMinute = 8 * 60; // 08:00 AM
  static const int dayEndMinute = 19 * 60 + 30; // 07:30 PM

  static List<FreeTimeBlock> getCommonFreeTime(Timetable myTimetable, Timetable friendTimetable, String dayOfWeek) {
    List<Day> myClasses = _getClassesForDay(myTimetable, dayOfWeek);
    List<Day> friendClasses = _getClassesForDay(friendTimetable, dayOfWeek);

    List<_Interval> busyIntervals = [];

    for (var c in myClasses) {
      final interval = _parseInterval(c.startTime, c.endTime);
      if (interval != null) busyIntervals.add(interval);
    }
    for (var c in friendClasses) {
      final interval = _parseInterval(c.startTime, c.endTime);
      if (interval != null) busyIntervals.add(interval);
    }

    if (busyIntervals.isEmpty) {
      return [FreeTimeBlock(dayStartMinute, dayEndMinute)];
    }

    // Sort intervals by start time
    busyIntervals.sort((a, b) => a.start.compareTo(b.start));

    // Merge overlapping intervals
    List<_Interval> merged = [];
    _Interval current = busyIntervals.first;

    for (int i = 1; i < busyIntervals.length; i++) {
      if (busyIntervals[i].start <= current.end) {
        // Overlap or contiguous, extend the current interval
        if (busyIntervals[i].end > current.end) {
          current = _Interval(current.start, busyIntervals[i].end);
        }
      } else {
        // No overlap, push current and start new
        merged.add(current);
        current = busyIntervals[i];
      }
    }
    merged.add(current);

    // Find gaps
    List<FreeTimeBlock> freeBlocks = [];
    int currentMinute = dayStartMinute;

    for (var busy in merged) {
      if (busy.start > currentMinute && (busy.start - currentMinute) > 10) {
        freeBlocks.add(FreeTimeBlock(currentMinute, busy.start));
      }
      if (busy.end > currentMinute) {
        currentMinute = busy.end;
      }
    }

    if (currentMinute < dayEndMinute && (dayEndMinute - currentMinute) > 10) {
      freeBlocks.add(FreeTimeBlock(currentMinute, dayEndMinute));
    }

    return freeBlocks;
  }

  static String getCurrentStatus(Timetable timetable) {
    final now = DateTime.now();
    final dayOfWeek = _getDayOfWeekString(now.weekday);
    final currentMinute = now.hour * 60 + now.minute;

    final classesToday = _getClassesForDay(timetable, dayOfWeek);
    
    if (classesToday.isEmpty) {
      return 'Free today';
    }

    // Parse all classes with intervals
    final List<Map<String, dynamic>> parsedClasses = [];
    for (var c in classesToday) {
      final interval = _parseInterval(c.startTime, c.endTime);
      if (interval != null) {
        parsedClasses.add({'class': c, 'interval': interval});
      }
    }

    // Sort by start time
    parsedClasses.sort((a, b) => (a['interval'] as _Interval).start.compareTo((b['interval'] as _Interval).start));

    for (var pc in parsedClasses) {
      final interval = pc['interval'] as _Interval;
      final c = pc['class'] as Day;

      if (currentMinute >= interval.start && currentMinute <= interval.end) {
        return 'In Class (${c.venue ?? "Unknown"})';
      }
    }

    // If not in class, find the next class
    for (var pc in parsedClasses) {
      final interval = pc['interval'] as _Interval;
      if (interval.start > currentMinute) {
        final c = pc['class'] as Day;
        return 'Free until ${c.startTime}';
      }
    }

    return 'Free for the rest of the day';
  }

  static String _getDayOfWeekString(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return 'Monday';
    }
  }

  static List<Day> _getClassesForDay(Timetable timetable, String dayOfWeek) {
    switch (dayOfWeek.toLowerCase()) {
      case 'monday': return timetable.monday.toList();
      case 'tuesday': return timetable.tuesday.toList();
      case 'wednesday': return timetable.wednesday.toList();
      case 'thursday': return timetable.thursday.toList();
      case 'friday': return timetable.friday.toList();
      case 'saturday': return timetable.saturday.toList();
      case 'sunday': return timetable.sunday.toList();
      default: return [];
    }
  }

  static _Interval? _parseInterval(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) return null;
    try {
      final start = _parseTime(startTime);
      final end = _parseTime(endTime);
      return _Interval(start, end);
    } catch (e) {
      return null;
    }
  }

  static int _parseTime(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}

class _Interval {
  final int start;
  final int end;
  _Interval(this.start, this.end);
}
