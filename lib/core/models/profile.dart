import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'grade_history.dart';
import 'mentor_details.dart';

part 'profile.g.dart';

@Entity()
@JsonSerializable()
class Profile {
  @Id()
  int id = 0;

  String applicationNumber;
  String studentName;
  String dob;
  String gender;
  String bloodGroup;
  String email;
  String base64Pfp;

  @_GradeHistoryRelToOneConverter()
  final ToOne<GradeHistory> gradeHistory = ToOne<GradeHistory>();

  @_MentorDetailsRelToOneConverter()
  final ToOne<MentorDetails> mentorDetails = ToOne<MentorDetails>();

  Profile({
    required this.applicationNumber,
    required this.studentName,
    required this.dob,
    required this.gender,
    required this.bloodGroup,
    required this.email,
    required this.base64Pfp,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

// Converters for Profile relations
class _GradeHistoryRelToOneConverter
    implements JsonConverter<ToOne<GradeHistory>, Map<String, dynamic>?> {
  const _GradeHistoryRelToOneConverter();

  @override
  ToOne<GradeHistory> fromJson(Map<String, dynamic>? json) =>
      ToOne<GradeHistory>(
          target: json != null ? GradeHistory.fromJson(json) : null);

  @override
  Map<String, dynamic>? toJson(ToOne<GradeHistory> rel) => rel.target?.toJson();
}

class _MentorDetailsRelToOneConverter
    implements JsonConverter<ToOne<MentorDetails>, Map<String, dynamic>?> {
  const _MentorDetailsRelToOneConverter();

  @override
  ToOne<MentorDetails> fromJson(Map<String, dynamic>? json) =>
      ToOne<MentorDetails>(
          target: json != null ? MentorDetails.fromJson(json) : null);

  @override
  Map<String, dynamic>? toJson(ToOne<MentorDetails> rel) =>
      rel.target?.toJson();
}
