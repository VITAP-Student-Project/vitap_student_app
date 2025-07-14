// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarksRecord _$MarksRecordFromJson(Map<String, dynamic> json) => _MarksRecord(
      serial: json['serial'] as String,
      coursecode: json['coursecode'] as String,
      coursetitle: json['coursetitle'] as String,
      coursetype: json['coursetype'] as String,
      faculity: json['faculity'] as String,
      slot: json['slot'] as String,
      marks: (json['marks'] as List<dynamic>)
          .map((e) => MarksRecordEach.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarksRecordToJson(_MarksRecord instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'coursecode': instance.coursecode,
      'coursetitle': instance.coursetitle,
      'coursetype': instance.coursetype,
      'faculity': instance.faculity,
      'slot': instance.slot,
      'marks': instance.marks,
    };

_MarksRecordEach _$MarksRecordEachFromJson(Map<String, dynamic> json) =>
    _MarksRecordEach(
      serial: json['serial'] as String,
      markstitle: json['markstitle'] as String,
      maxmarks: json['maxmarks'] as String,
      weightage: json['weightage'] as String,
      status: json['status'] as String,
      scoredmark: json['scoredmark'] as String,
      weightagemark: json['weightagemark'] as String,
      remark: json['remark'] as String,
    );

Map<String, dynamic> _$MarksRecordEachToJson(_MarksRecordEach instance) =>
    <String, dynamic>{
      'serial': instance.serial,
      'markstitle': instance.markstitle,
      'maxmarks': instance.maxmarks,
      'weightage': instance.weightage,
      'status': instance.status,
      'scoredmark': instance.scoredmark,
      'weightagemark': instance.weightagemark,
      'remark': instance.remark,
    };
