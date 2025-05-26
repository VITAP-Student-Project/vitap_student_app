// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mark _$MarkFromJson(Map<String, dynamic> json) => Mark(
      serialNumber: json['serial_number'] as String,
      classId: json['class_id'] as String,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      courseType: json['course_type'] as String,
      courseSystem: json['course_system'] as String,
      faculty: json['faculty'] as String,
      slot: json['slot'] as String,
      details:
          const _DetailRelToManyConverter().fromJson(json['details'] as List?),
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$MarkToJson(Mark instance) => <String, dynamic>{
      'id': instance.id,
      'serial_number': instance.serialNumber,
      'class_id': instance.classId,
      'course_code': instance.courseCode,
      'course_title': instance.courseTitle,
      'course_type': instance.courseType,
      'course_system': instance.courseSystem,
      'faculty': instance.faculty,
      'slot': instance.slot,
      'details': const _DetailRelToManyConverter().toJson(instance.details),
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      serialNumber: json['serial_number'] as String,
      markTitle: json['mark_title'] as String,
      maxMark: json['max_mark'] as String,
      weightage: json['weightage'] as String,
      status: json['status'] as String,
      scoredMark: json['scored_mark'] as String,
      weightageMark: json['weightage_mark'] as String,
      remark: json['remark'] as String,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'id': instance.id,
      'serial_number': instance.serialNumber,
      'mark_title': instance.markTitle,
      'max_mark': instance.maxMark,
      'weightage': instance.weightage,
      'status': instance.status,
      'scored_mark': instance.scoredMark,
      'weightage_mark': instance.weightageMark,
      'remark': instance.remark,
    };
