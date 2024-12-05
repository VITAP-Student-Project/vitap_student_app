import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Map<String, Attendance> attendance;
  ExamSchedule examSchedule;
  List<Mark> marks;
  Profile profile;
  Timetable timetable;

  Student({
    required this.attendance,
    required this.examSchedule,
    required this.marks,
    required this.profile,
    required this.timetable,
  });

  Student copyWith({
    Map<String, Attendance>? attendance,
    ExamSchedule? examSchedule,
    List<Mark>? marks,
    Profile? profile,
    Timetable? timetable,
  }) =>
      Student(
        attendance: attendance ?? this.attendance,
        examSchedule: examSchedule ?? this.examSchedule,
        marks: marks ?? this.marks,
        profile: profile ?? this.profile,
        timetable: timetable ?? this.timetable,
      );

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        attendance: Map.from(json["attendance"]).map(
            (k, v) => MapEntry<String, Attendance>(k, Attendance.fromJson(v))),
        examSchedule: ExamSchedule.fromJson(json["exam_schedule"]),
        marks: List<Mark>.from(json["marks"].map((x) => Mark.fromJson(x))),
        profile: Profile.fromJson(json["profile"]),
        timetable: Timetable.fromJson(json["timetable"]),
      );

  Map<String, dynamic> toJson() => {
        "attendance": Map.from(attendance)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "exam_schedule": examSchedule.toJson(),
        "marks": List<dynamic>.from(marks.map((x) => x.toJson())),
        "profile": profile.toJson(),
        "timetable": timetable.toJson(),
      };
}

class Attendance {
  String attendancePercentage;
  String attendedClasses;
  String courseCode;
  String courseName;
  String courseType;
  String totalClasses;

  Attendance({
    required this.attendancePercentage,
    required this.attendedClasses,
    required this.courseCode,
    required this.courseName,
    required this.courseType,
    required this.totalClasses,
  });

  Attendance copyWith({
    String? attendancePercentage,
    String? attendedClasses,
    String? courseCode,
    String? courseName,
    String? courseType,
    String? totalClasses,
  }) =>
      Attendance(
        attendancePercentage: attendancePercentage ?? this.attendancePercentage,
        attendedClasses: attendedClasses ?? this.attendedClasses,
        courseCode: courseCode ?? this.courseCode,
        courseName: courseName ?? this.courseName,
        courseType: courseType ?? this.courseType,
        totalClasses: totalClasses ?? this.totalClasses,
      );

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        attendancePercentage: json["attendance_percentage"],
        attendedClasses: json["attended_classes"],
        courseCode: json["course_code"],
        courseName: json["course_name"],
        courseType: json["course_type"],
        totalClasses: json["total_classes"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_percentage": attendancePercentage,
        "attended_classes": attendedClasses,
        "course_code": courseCode,
        "course_name": courseName,
        "course_type": courseType,
        "total_classes": totalClasses,
      };
}

class ExamSchedule {
  Map<String, Cat1> cat1;
  Map<String, Cat1> cat2;
  Map<String, Cat1> fat;

  ExamSchedule({
    required this.cat1,
    required this.cat2,
    required this.fat,
  });

  ExamSchedule copyWith({
    Map<String, Cat1>? cat1,
    Map<String, Cat1>? cat2,
    Map<String, Cat1>? fat,
  }) =>
      ExamSchedule(
        cat1: cat1 ?? this.cat1,
        cat2: cat2 ?? this.cat2,
        fat: fat ?? this.fat,
      );

  factory ExamSchedule.fromJson(Map<String, dynamic> json) => ExamSchedule(
        cat1: Map.from(json["cat_1"])
            .map((k, v) => MapEntry<String, Cat1>(k, Cat1.fromJson(v))),
        cat2: Map.from(json["cat_2"])
            .map((k, v) => MapEntry<String, Cat1>(k, Cat1.fromJson(v))),
        fat: Map.from(json["fat"])
            .map((k, v) => MapEntry<String, Cat1>(k, Cat1.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "cat_1": Map.from(cat1)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "cat_2": Map.from(cat2)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "fat": Map.from(fat)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Cat1 {
  String courseCode;
  String courseTitle;
  String date;
  String examTime;
  String registrationNumber;
  String reportingTime;
  String seatLocation;
  String seatNumber;
  String session;
  String slot;
  String type;
  String venue;

  Cat1({
    required this.courseCode,
    required this.courseTitle,
    required this.date,
    required this.examTime,
    required this.registrationNumber,
    required this.reportingTime,
    required this.seatLocation,
    required this.seatNumber,
    required this.session,
    required this.slot,
    required this.type,
    required this.venue,
  });

  Cat1 copyWith({
    String? courseCode,
    String? courseTitle,
    String? date,
    String? examTime,
    String? registrationNumber,
    String? reportingTime,
    String? seatLocation,
    String? seatNumber,
    String? session,
    String? slot,
    String? type,
    String? venue,
  }) =>
      Cat1(
        courseCode: courseCode ?? this.courseCode,
        courseTitle: courseTitle ?? this.courseTitle,
        date: date ?? this.date,
        examTime: examTime ?? this.examTime,
        registrationNumber: registrationNumber ?? this.registrationNumber,
        reportingTime: reportingTime ?? this.reportingTime,
        seatLocation: seatLocation ?? this.seatLocation,
        seatNumber: seatNumber ?? this.seatNumber,
        session: session ?? this.session,
        slot: slot ?? this.slot,
        type: type ?? this.type,
        venue: venue ?? this.venue,
      );

  factory Cat1.fromJson(Map<String, dynamic> json) => Cat1(
        courseCode: json["course_code"],
        courseTitle: json["course_title"],
        date: json["date"],
        examTime: json["exam_time"],
        registrationNumber: json["registration_number"],
        reportingTime: json["reporting_time"],
        seatLocation: json["seat_location"],
        seatNumber: json["seat_number"],
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
        "session": session,
        "slot": slot,
        "type": type,
        "venue": venue,
      };
}

class Mark {
  String classId;
  String courseCode;
  String courseSystem;
  String courseTitle;
  String courseType;
  List<Detail> details;
  String faculty;
  String serialNumber;
  String slot;

  Mark({
    required this.classId,
    required this.courseCode,
    required this.courseSystem,
    required this.courseTitle,
    required this.courseType,
    required this.details,
    required this.faculty,
    required this.serialNumber,
    required this.slot,
  });

  Mark copyWith({
    String? classId,
    String? courseCode,
    String? courseSystem,
    String? courseTitle,
    String? courseType,
    List<Detail>? details,
    String? faculty,
    String? serialNumber,
    String? slot,
  }) =>
      Mark(
        classId: classId ?? this.classId,
        courseCode: courseCode ?? this.courseCode,
        courseSystem: courseSystem ?? this.courseSystem,
        courseTitle: courseTitle ?? this.courseTitle,
        courseType: courseType ?? this.courseType,
        details: details ?? this.details,
        faculty: faculty ?? this.faculty,
        serialNumber: serialNumber ?? this.serialNumber,
        slot: slot ?? this.slot,
      );

  factory Mark.fromJson(Map<String, dynamic> json) => Mark(
        classId: json["class_id"],
        courseCode: json["course_code"],
        courseSystem: json["course_system"],
        courseTitle: json["course_title"],
        courseType: json["course_type"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        faculty: json["faculty"],
        serialNumber: json["serial_number"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "class_id": classId,
        "course_code": courseCode,
        "course_system": courseSystem,
        "course_title": courseTitle,
        "course_type": courseType,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "faculty": faculty,
        "serial_number": serialNumber,
        "slot": slot,
      };
}

class Detail {
  String markTitle;
  String maxMark;
  String remark;
  String scoredMark;
  String serialNumber;
  String status;
  String weightage;
  String weightageMark;

  Detail({
    required this.markTitle,
    required this.maxMark,
    required this.remark,
    required this.scoredMark,
    required this.serialNumber,
    required this.status,
    required this.weightage,
    required this.weightageMark,
  });

  Detail copyWith({
    String? markTitle,
    String? maxMark,
    String? remark,
    String? scoredMark,
    String? serialNumber,
    String? status,
    String? weightage,
    String? weightageMark,
  }) =>
      Detail(
        markTitle: markTitle ?? this.markTitle,
        maxMark: maxMark ?? this.maxMark,
        remark: remark ?? this.remark,
        scoredMark: scoredMark ?? this.scoredMark,
        serialNumber: serialNumber ?? this.serialNumber,
        status: status ?? this.status,
        weightage: weightage ?? this.weightage,
        weightageMark: weightageMark ?? this.weightageMark,
      );

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        markTitle: json["mark_title"],
        maxMark: json["max_mark"],
        remark: json["remark"],
        scoredMark: json["scored_mark"],
        serialNumber: json["serial_number"],
        status: json["status"],
        weightage: json["weightage"],
        weightageMark: json["weightage_mark"],
      );

  Map<String, dynamic> toJson() => {
        "mark_title": markTitle,
        "max_mark": maxMark,
        "remark": remark,
        "scored_mark": scoredMark,
        "serial_number": serialNumber,
        "status": status,
        "weightage": weightage,
        "weightage_mark": weightageMark,
      };
}

class Profile {
  String applicationNumber;
  String bloodGroup;
  String dob;
  String email;
  String gender;
  GradeHistory gradeHistory;
  HodAndDeanInfo hodAndDeanInfo;
  MentorDetails mentorDetails;
  String pfp;
  String studentName;

  Profile({
    required this.applicationNumber,
    required this.bloodGroup,
    required this.dob,
    required this.email,
    required this.gender,
    required this.gradeHistory,
    required this.hodAndDeanInfo,
    required this.mentorDetails,
    required this.pfp,
    required this.studentName,
  });

  Profile copyWith({
    String? applicationNumber,
    String? bloodGroup,
    String? dob,
    String? email,
    String? gender,
    GradeHistory? gradeHistory,
    HodAndDeanInfo? hodAndDeanInfo,
    MentorDetails? mentorDetails,
    String? pfp,
    String? studentName,
  }) =>
      Profile(
        applicationNumber: applicationNumber ?? this.applicationNumber,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        gradeHistory: gradeHistory ?? this.gradeHistory,
        hodAndDeanInfo: hodAndDeanInfo ?? this.hodAndDeanInfo,
        mentorDetails: mentorDetails ?? this.mentorDetails,
        pfp: pfp ?? this.pfp,
        studentName: studentName ?? this.studentName,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        applicationNumber: json["application_number"],
        bloodGroup: json["blood_group"],
        dob: json["dob"],
        email: json["email"],
        gender: json["gender"],
        gradeHistory: GradeHistory.fromJson(json["grade_history"]),
        hodAndDeanInfo: HodAndDeanInfo.fromJson(json["hod_and_dean_info"]),
        mentorDetails: MentorDetails.fromJson(json["mentor_details"]),
        pfp: json["pfp"],
        studentName: json["student_name"],
      );

  Map<String, dynamic> toJson() => {
        "application_number": applicationNumber,
        "blood_group": bloodGroup,
        "dob": dob,
        "email": email,
        "gender": gender,
        "grade_history": gradeHistory.toJson(),
        "hod_and_dean_info": hodAndDeanInfo.toJson(),
        "mentor_details": mentorDetails.toJson(),
        "pfp": pfp,
        "student_name": studentName,
      };
}

class GradeHistory {
  String cgpa;
  String creditsEarned;
  String creditsRegistered;

  GradeHistory({
    required this.cgpa,
    required this.creditsEarned,
    required this.creditsRegistered,
  });

  GradeHistory copyWith({
    String? cgpa,
    String? creditsEarned,
    String? creditsRegistered,
  }) =>
      GradeHistory(
        cgpa: cgpa ?? this.cgpa,
        creditsEarned: creditsEarned ?? this.creditsEarned,
        creditsRegistered: creditsRegistered ?? this.creditsRegistered,
      );

  factory GradeHistory.fromJson(Map<String, dynamic> json) => GradeHistory(
        cgpa: json["cgpa"],
        creditsEarned: json["credits_earned"],
        creditsRegistered: json["credits_registered"],
      );

  Map<String, dynamic> toJson() => {
        "cgpa": cgpa,
        "credits_earned": creditsEarned,
        "credits_registered": creditsRegistered,
      };
}

class HodAndDeanInfo {
  String cabinNumber;
  String designation;
  String emailId;
  String imageBase64;
  String title;

  HodAndDeanInfo({
    required this.cabinNumber,
    required this.designation,
    required this.emailId,
    required this.imageBase64,
    required this.title,
  });

  HodAndDeanInfo copyWith({
    String? cabinNumber,
    String? designation,
    String? emailId,
    String? imageBase64,
    String? title,
  }) =>
      HodAndDeanInfo(
        cabinNumber: cabinNumber ?? this.cabinNumber,
        designation: designation ?? this.designation,
        emailId: emailId ?? this.emailId,
        imageBase64: imageBase64 ?? this.imageBase64,
        title: title ?? this.title,
      );

  factory HodAndDeanInfo.fromJson(Map<String, dynamic> json) => HodAndDeanInfo(
        cabinNumber: json["Cabin Number"],
        designation: json["Designation"],
        emailId: json["Email ID"],
        imageBase64: json["image_base64"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "Cabin Number": cabinNumber,
        "Designation": designation,
        "Email ID": emailId,
        "image_base64": imageBase64,
        "title": title,
      };
}

class MentorDetails {
  String cabin;
  String facultyDepartment;
  String facultyDesignation;
  String facultyEmail;
  String facultyId;
  String facultyIntercom;
  String facultyMobileNumber;
  String facultyName;
  String school;

  MentorDetails({
    required this.cabin,
    required this.facultyDepartment,
    required this.facultyDesignation,
    required this.facultyEmail,
    required this.facultyId,
    required this.facultyIntercom,
    required this.facultyMobileNumber,
    required this.facultyName,
    required this.school,
  });

  MentorDetails copyWith({
    String? cabin,
    String? facultyDepartment,
    String? facultyDesignation,
    String? facultyEmail,
    String? facultyId,
    String? facultyIntercom,
    String? facultyMobileNumber,
    String? facultyName,
    String? school,
  }) =>
      MentorDetails(
        cabin: cabin ?? this.cabin,
        facultyDepartment: facultyDepartment ?? this.facultyDepartment,
        facultyDesignation: facultyDesignation ?? this.facultyDesignation,
        facultyEmail: facultyEmail ?? this.facultyEmail,
        facultyId: facultyId ?? this.facultyId,
        facultyIntercom: facultyIntercom ?? this.facultyIntercom,
        facultyMobileNumber: facultyMobileNumber ?? this.facultyMobileNumber,
        facultyName: facultyName ?? this.facultyName,
        school: school ?? this.school,
      );

  factory MentorDetails.fromJson(Map<String, dynamic> json) => MentorDetails(
        cabin: json["cabin"],
        facultyDepartment: json["faculty_department"],
        facultyDesignation: json["faculty_designation"],
        facultyEmail: json["faculty_email"],
        facultyId: json["faculty_id"],
        facultyIntercom: json["faculty_intercom"],
        facultyMobileNumber: json["faculty_mobile_number"],
        facultyName: json["faculty_name"],
        school: json["school"],
      );

  Map<String, dynamic> toJson() => {
        "cabin": cabin,
        "faculty_department": facultyDepartment,
        "faculty_designation": facultyDesignation,
        "faculty_email": facultyEmail,
        "faculty_id": facultyId,
        "faculty_intercom": facultyIntercom,
        "faculty_mobile_number": facultyMobileNumber,
        "faculty_name": facultyName,
        "school": school,
      };
}

class Timetable {
  List<Map<String, Day>> friday;
  List<Map<String, Day>> saturday;
  List<Map<String, Day>> thursday;
  List<Map<String, Day>> tuesday;
  List<Map<String, Day>> wednesday;

  Timetable({
    required this.friday,
    required this.saturday,
    required this.thursday,
    required this.tuesday,
    required this.wednesday,
  });

  Timetable copyWith({
    List<Map<String, Day>>? friday,
    List<Map<String, Day>>? saturday,
    List<Map<String, Day>>? thursday,
    List<Map<String, Day>>? tuesday,
    List<Map<String, Day>>? wednesday,
  }) =>
      Timetable(
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        thursday: thursday ?? this.thursday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
      );

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
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
