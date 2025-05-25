import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'mentor_details.g.dart';

@Entity()
@JsonSerializable()
class MentorDetails {
  @Id()
  int id = 0;

  final String facultyId;
  final String facultyName;
  final String facultyDesignation;
  final String school;
  final String cabin;
  final String facultyDepartment;
  final String facultyEmail;
  final String facultyIntercom;
  final String facultyMobileNumber;

  MentorDetails({
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
}
