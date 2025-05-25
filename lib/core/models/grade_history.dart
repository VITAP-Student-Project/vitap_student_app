import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'grade_history.g.dart';

@Entity()
@JsonSerializable()
class GradeHistory {
  @Id()
  int id = 0;

  final String creditsRegistered;
  final String creditsEarned;
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
