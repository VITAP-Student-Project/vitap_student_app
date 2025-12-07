// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemesterCache _$SemesterCacheFromJson(Map<String, dynamic> json) =>
    SemesterCache(
      id: (json['id'] as num?)?.toInt(),
      semesterId: json['semester_id'] as String,
      semesterName: json['semester_name'] as String,
      isSelected: json['is_selected'] as bool? ?? false,
      updatedAt: (json['updated_at'] as num).toInt(),
    );

Map<String, dynamic> _$SemesterCacheToJson(SemesterCache instance) =>
    <String, dynamic>{
      'id': instance.id,
      'semester_id': instance.semesterId,
      'semester_name': instance.semesterName,
      'is_selected': instance.isSelected,
      'updated_at': instance.updatedAt,
    };
