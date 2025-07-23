// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'mentor_details.g.dart';

@Entity()
@JsonSerializable()
class MentorDetails {
  @Id()
  int? id;

  @JsonKey(name: "faculty_id")
  final String facultyId;
  @JsonKey(name: "faculty_name")
  final String facultyName;
  @JsonKey(name: "faculty_designation")
  final String facultyDesignation;
  @JsonKey(name: "school")
  final String school;
  @JsonKey(name: "cabin")
  final String cabin;
  @JsonKey(name: "faculty_department")
  final String facultyDepartment;
  @JsonKey(name: "faculty_email")
  final String facultyEmail;
  @JsonKey(name: "faculty_intercom")
  final String facultyIntercom;
  @JsonKey(name: "faculty_mobile_number")
  final String facultyMobileNumber;

  MentorDetails({
    this.id,
    required this.facultyId,
    required this.facultyName,
    required this.facultyDesignation,
    required this.school,
    required this.cabin,
    required this.facultyDepartment,
    required this.facultyEmail,
    required this.facultyIntercom,
    required this.facultyMobileNumber,
  });

  factory MentorDetails.fromJson(Map<String, dynamic> json) =>
      _$MentorDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MentorDetailsToJson(this);

  @override
  String toString() {
    return 'MentorDetails(id: $id, facultyId: $facultyId, facultyName: $facultyName, facultyDesignation: $facultyDesignation, school: $school, cabin: $cabin, facultyDepartment: $facultyDepartment, facultyEmail: $facultyEmail, facultyIntercom: $facultyIntercom, facultyMobileNumber: $facultyMobileNumber)';
  }
}
