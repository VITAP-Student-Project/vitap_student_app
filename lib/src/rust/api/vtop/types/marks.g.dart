// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Marks _$MarksFromJson(Map<String, dynamic> json) => _Marks(
      serialNumber: json['serialNumber'] as String,
      courseCode: json['courseCode'] as String,
      courseTitle: json['courseTitle'] as String,
      courseType: json['courseType'] as String,
      faculity: json['faculity'] as String,
      slot: json['slot'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) => MarksRecordEach.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarksToJson(_Marks instance) => <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'courseCode': instance.courseCode,
      'courseTitle': instance.courseTitle,
      'courseType': instance.courseType,
      'faculity': instance.faculity,
      'slot': instance.slot,
      'details': instance.details,
    };

_MarksRecordEach _$MarksRecordEachFromJson(Map<String, dynamic> json) =>
    _MarksRecordEach(
      serialNumber: json['serialNumber'] as String,
      markTitle: json['markTitle'] as String,
      maxMark: json['maxMark'] as String,
      weightage: json['weightage'] as String,
      status: json['status'] as String,
      scoredMark: json['scoredMark'] as String,
      weightageMark: json['weightageMark'] as String,
      remark: json['remark'] as String,
    );

Map<String, dynamic> _$MarksRecordEachToJson(_MarksRecordEach instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'markTitle': instance.markTitle,
      'maxMark': instance.maxMark,
      'weightage': instance.weightage,
      'status': instance.status,
      'scoredMark': instance.scoredMark,
      'weightageMark': instance.weightageMark,
      'remark': instance.remark,
    };
