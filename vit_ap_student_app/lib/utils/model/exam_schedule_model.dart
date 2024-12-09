class ExamSchedule {
  String examType;
  List<Subject> subjects;

  ExamSchedule({
    required this.examType,
    required this.subjects,
  });

  ExamSchedule copyWith({
    String? examType,
    List<Subject>? subjects,
  }) =>
      ExamSchedule(
        examType: examType ?? this.examType,
        subjects: subjects ?? this.subjects,
      );

  factory ExamSchedule.fromJson(Map<String, dynamic> json) => ExamSchedule(
        examType: json["exam_type"],
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exam_type": examType,
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
      };

  List<Subject> getSubjectsByType(String type) {
    return subjects.where((subject) => subject.type == type).toList();
  }
}

class Subject {
  String courseCode;
  String courseTitle;
  String date;
  String examTime;
  String registrationNumber;
  String reportingTime;
  String seatLocation;
  String seatNumber;
  String serialNumber;
  String session;
  String slot;
  String type;
  String venue;

  Subject({
    required this.courseCode,
    required this.courseTitle,
    required this.date,
    required this.examTime,
    required this.registrationNumber,
    required this.reportingTime,
    required this.seatLocation,
    required this.seatNumber,
    required this.serialNumber,
    required this.session,
    required this.slot,
    required this.type,
    required this.venue,
  });

  Subject copyWith({
    String? courseCode,
    String? courseTitle,
    String? date,
    String? examTime,
    String? registrationNumber,
    String? reportingTime,
    String? seatLocation,
    String? seatNumber,
    String? serialNumber,
    String? session,
    String? slot,
    String? type,
    String? venue,
  }) =>
      Subject(
        courseCode: courseCode ?? this.courseCode,
        courseTitle: courseTitle ?? this.courseTitle,
        date: date ?? this.date,
        examTime: examTime ?? this.examTime,
        registrationNumber: registrationNumber ?? this.registrationNumber,
        reportingTime: reportingTime ?? this.reportingTime,
        seatLocation: seatLocation ?? this.seatLocation,
        seatNumber: seatNumber ?? this.seatNumber,
        serialNumber: serialNumber ?? this.serialNumber,
        session: session ?? this.session,
        slot: slot ?? this.slot,
        type: type ?? this.type,
        venue: venue ?? this.venue,
      );

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        courseCode: json["course_code"],
        courseTitle: json["course_title"],
        date: json["date"],
        examTime: json["exam_time"],
        registrationNumber: json["registration_number"],
        reportingTime: json["reporting_time"],
        seatLocation: json["seat_location"],
        seatNumber: json["seat_number"],
        serialNumber: json["serial_number"],
        session: json["session"],
        slot: json["slot"],
        type: json["type"],
        venue: json["venue"],
      );

  Map<String, dynamic> toJson() => {
        "course_code": courseCode,
        "course_title": courseTitle,
        "date": date,
        "exam_time": examTime,
        "registration_number": registrationNumber,
        "reporting_time": reportingTime,
        "seat_location": seatLocation,
        "seat_number": seatNumber,
        "serial_number": serialNumber,
        "session": session,
        "slot": slot,
        "type": type,
        "venue": venue,
      };
}
