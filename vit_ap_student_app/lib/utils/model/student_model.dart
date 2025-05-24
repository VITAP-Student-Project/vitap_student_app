import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'attendance_model.dart';
import 'exam_schedule_model.dart';
import 'marks_model.dart';
import 'profile_model.dart';
import 'timetable_model.dart';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  static const _passwordKey = 'student_password';

  String registrationNumber;
  String semSubId;
  String pfpPath;
  bool isLoggedIn;
  Map<String, Attendance> attendance;
  List<ExamSchedule> examSchedule;
  List<Mark> marks;
  Profile profile;
  Timetable timetable;

  Student({
    required this.registrationNumber,
    required this.semSubId,
    required this.pfpPath,
    required this.isLoggedIn,
    required this.attendance,
    required this.examSchedule,
    required this.marks,
    required this.profile,
    required this.timetable,
  });

  Student copyWith({
    String? registrationNumber,
    String? semSubId,
    String? pfpPath,
    bool? isLoggedIn,
    Map<String, Attendance>? attendance,
    List<ExamSchedule>? examSchedule,
    List<Mark>? marks,
    Profile? profile,
    Timetable? timetable,
  }) =>
      Student(
        registrationNumber: registrationNumber ?? this.registrationNumber,
        semSubId: semSubId ?? this.semSubId,
        pfpPath: pfpPath ?? this.pfpPath,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        attendance: attendance ?? this.attendance,
        examSchedule: examSchedule ?? this.examSchedule,
        marks: marks ?? this.marks,
        profile: profile ?? this.profile,
        timetable: timetable ?? this.timetable,
      );

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        registrationNumber: json["registration_number"],
        semSubId: json["sem_sub_id"],
        pfpPath: json["pfp_path"],
        isLoggedIn: json["is_logged_in"],
        attendance: Map.from(json["attendance"]).map(
            (k, v) => MapEntry<String, Attendance>(k, Attendance.fromJson(v))),
        examSchedule: List<ExamSchedule>.from(
            json["exam_schedule"].map((x) => ExamSchedule.fromJson(x))),
        marks: List<Mark>.from(json["marks"].map((x) => Mark.fromJson(x))),
        profile: Profile.fromJson(json["profile"]),
        timetable: Timetable.fromJson(json["timetable"]),
      );

  Map<String, dynamic> toJson() => {
        "registration_number": registrationNumber,
        "sem_sub_id": semSubId,
        "pfp_path": pfpPath,
        "is_logged_in": isLoggedIn,
        "attendance": Map.from(attendance)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "exam_schedule":
            List<dynamic>.from(examSchedule.map((x) => x.toJson())),
        "marks": List<dynamic>.from(marks.map((x) => x.toJson())),
        "profile": profile.toJson(),
        "timetable": timetable.toJson(),
      };

  // Getter for password
  Future<String?> get password async {
    return await _storage.read(key: _passwordKey);
  }

  // Setter for password
  Future<void> setPassword(String password) async {
    await _storage.write(key: _passwordKey, value: password);
  }

  factory Student.empty() => Student(
        registrationNumber: '',
        semSubId: '',
        pfpPath: '',
        isLoggedIn: false,
        attendance: {},
        examSchedule: [],
        marks: [],
        profile: Profile.empty(),
        timetable: Timetable.empty(),
      );
}
