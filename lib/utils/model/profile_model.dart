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

  factory Profile.empty() => Profile(
        applicationNumber: '',
        bloodGroup: '',
        dob: '',
        email: '',
        gender: '',
        gradeHistory: GradeHistory(
          cgpa: '',
          creditsEarned: '',
          creditsRegistered: '',
        ),
        hodAndDeanInfo: HodAndDeanInfo(
          cabinNumber: '',
          designation: '',
          emailId: '',
          imageBase64: '',
          title: '',
        ),
        mentorDetails: MentorDetails(
          cabin: '',
          facultyDepartment: '',
          facultyDesignation: '',
          facultyEmail: '',
          facultyId: '',
          facultyIntercom: '',
          facultyMobileNumber: '',
          facultyName: '',
          school: '',
        ),
        pfp: '',
        studentName: '',
      );
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
