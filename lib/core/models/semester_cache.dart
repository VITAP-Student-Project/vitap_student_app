// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'semester_cache.g.dart';

@Entity()
@JsonSerializable()
class SemesterCache {
  @Id()
  int? id;

  @JsonKey(name: 'semester_id')
  @Unique()
  final String semesterId;

  @JsonKey(name: 'semester_name')
  final String semesterName;

  @JsonKey(name: 'is_selected')
  final bool isSelected;

  @JsonKey(name: 'updated_at')
  final int updatedAt;

  SemesterCache({
    this.id,
    required this.semesterId,
    required this.semesterName,
    this.isSelected = false,
    required this.updatedAt,
  });

  factory SemesterCache.fromJson(Map<String, dynamic> json) =>
      _$SemesterCacheFromJson(json);

  Map<String, dynamic> toJson() => _$SemesterCacheToJson(this);

  SemesterCache copyWith({
    int? id,
    String? semesterId,
    String? semesterName,
    bool? isSelected,
    int? updatedAt,
  }) {
    return SemesterCache(
      id: id ?? this.id,
      semesterId: semesterId ?? this.semesterId,
      semesterName: semesterName ?? this.semesterName,
      isSelected: isSelected ?? this.isSelected,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'SemesterCache(id: $id, semesterId: $semesterId, semesterName: $semesterName, isSelected: $isSelected, updatedAt: $updatedAt)';
  }
}
