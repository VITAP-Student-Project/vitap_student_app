import 'package:vit_ap_student_app/core/models/timetable.dart';

List<Day> getClassesForDay(Timetable timetable, String day) {
  switch (day.toLowerCase()) {
    case 'monday':
      return timetable.monday.toList();
    case 'tuesday':
      return timetable.tuesday.toList();
    case 'wednesday':
      return timetable.wednesday.toList();
    case 'thursday':
      return timetable.thursday.toList();
    case 'friday':
      return timetable.friday.toList();
    case 'saturday':
      return timetable.saturday.toList();
    case 'sunday':
      return timetable.sunday.toList();
    default:
      return [];
  }
}
