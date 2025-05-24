class Timetable {
  final List<Map<String, Day>> monday;
  final List<Map<String, Day>> tuesday;
  final List<Map<String, Day>> wednesday;
  final List<Map<String, Day>> thursday;
  final List<Map<String, Day>> friday;
  final List<Map<String, Day>> saturday;
  final List<Map<String, Day>> sunday;
  final String? errorMessage;

  Timetable({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    this.errorMessage,
  });

  // Factory constructor for creating an error timetable
  factory Timetable.error(String message) => Timetable(
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: [],
        sunday: [],
        errorMessage: message,
      );

  // Getter to check if this timetable represents an error
  bool get isError => errorMessage != null;

  Timetable copyWith({
    List<Map<String, Day>>? monday,
    List<Map<String, Day>>? tuesday,
    List<Map<String, Day>>? wednesday,
    List<Map<String, Day>>? thursday,
    List<Map<String, Day>>? friday,
    List<Map<String, Day>>? saturday,
    List<Map<String, Day>>? sunday,
    String? errorMessage,
  }) =>
      Timetable(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        monday: List<Map<String, Day>>.from(json["Monday"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Day>(k, Day.fromJson(v))))),
        sunday: List<Map<String, Day>>.from(json["Sunday"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Day>(k, Day.fromJson(v))))),
        friday: List<Map<String, Day>>.from(json["Friday"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Day>(k, Day.fromJson(v))))),
        saturday: List<Map<String, Day>>.from(json["Saturday"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Day>(k, Day.fromJson(v))))),
        thursday: List<Map<String, Day>>.from(json["Thursday"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Day>(k, Day.fromJson(v))))),
        tuesday: List<Map<String, Day>>.from(json["Tuesday"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Day>(k, Day.fromJson(v))))),
        wednesday: List<Map<String, Day>>.from(json["Wednesday"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Day>(k, Day.fromJson(v))))),
      );

  Map<String, dynamic> toJson() => {
        "Monday": List<dynamic>.from(monday.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "Sunday": List<dynamic>.from(sunday.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "Friday": List<dynamic>.from(friday.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "Saturday": List<dynamic>.from(saturday.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "Thursday": List<dynamic>.from(thursday.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "Tuesday": List<dynamic>.from(tuesday.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "Wednesday": List<dynamic>.from(wednesday.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
      };

  factory Timetable.empty() => Timetable(
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: [],
        sunday: [],
      );

  List<Day> getUniqueClasses() {
    final allClasses = [
      ...monday.expand((x) => x.values),
      ...tuesday.expand((x) => x.values),
      ...wednesday.expand((x) => x.values),
      ...thursday.expand((x) => x.values),
      ...friday.expand((x) => x.values),
      ...saturday.expand((x) => x.values),
      ...sunday.expand((x) => x.values),
    ];

    final uniqueClasses =
        <String, Day>{}; // Map to store unique classes by a key

    for (var day in allClasses) {
      final key =
          '${day.courseCode}-${day.courseType}'; // Define uniqueness key
      if (!uniqueClasses.containsKey(key)) {
        uniqueClasses[key] = day;
      }
    }

    return uniqueClasses.values.toList();
  }
}

class Day {
  String courseCode;
  String courseName;
  String courseType;
  String faculty;
  String venue;

  Day({
    required this.courseCode,
    required this.courseName,
    required this.courseType,
    required this.faculty,
    required this.venue,
  });

  Day copyWith({
    String? courseCode,
    String? courseName,
    String? courseType,
    String? faculty,
    String? venue,
  }) =>
      Day(
        courseCode: courseCode ?? this.courseCode,
        courseName: courseName ?? this.courseName,
        courseType: courseType ?? this.courseType,
        faculty: faculty ?? this.faculty,
        venue: venue ?? this.venue,
      );

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        courseCode: json["course_code"],
        courseName: json["course_name"],
        courseType: json["course_type"],
        faculty: json["faculty"],
        venue: json["venue"],
      );

  Map<String, dynamic> toJson() => {
        "course_code": courseCode,
        "course_name": courseName,
        "course_type": courseType,
        "faculty": faculty,
        "venue": venue,
      };
}
