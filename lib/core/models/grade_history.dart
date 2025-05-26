import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'grade_history.g.dart';

@Entity()
@JsonSerializable()
class GradeHistory {
  @Id()
  int? id;

  @JsonKey(name: "credits_registered")
  final String creditsRegistered;
  @JsonKey(name: "credits_earned")
  final String creditsEarned;
  @JsonKey(name: "cgpa")
  final String cgpa;

  GradeHistory({
    required this.creditsRegistered,
    required this.creditsEarned,
    required this.cgpa,
  });

  factory GradeHistory.fromJson(Map<String, dynamic> json) =>
      _$GradeHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$GradeHistoryToJson(this);
}
