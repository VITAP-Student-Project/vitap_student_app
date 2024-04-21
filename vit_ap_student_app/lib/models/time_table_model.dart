class Class {
  final String courseCode;
  final String courseName;
  final String courseType;
  final String venue;

  Class({required this.courseCode, required this.courseName, required this.courseType, required this.venue});
}

class Timetable {
  final Map<String, Map<String, Class>> days;

  Timetable({required this.days});
}
