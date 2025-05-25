// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mark _$MarkFromJson(Map<String, dynamic> json) => Mark(
      serialNumber: json['serialNumber'] as String,
      classId: json['classId'] as String,
      courseCode: json['courseCode'] as String,
      courseTitle: json['courseTitle'] as String,
      courseType: json['courseType'] as String,
      courseSystem: json['courseSystem'] as String,
      faculty: json['faculty'] as String,
      slot: json['slot'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$MarkToJson(Mark instance) => <String, dynamic>{
      'id': instance.id,
      'serialNumber': instance.serialNumber,
      'classId': instance.classId,
      'courseCode': instance.courseCode,
      'courseTitle': instance.courseTitle,
      'courseType': instance.courseType,
      'courseSystem': instance.courseSystem,
      'faculty': instance.faculty,
      'slot': instance.slot,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      serialNumber: json['serialNumber'] as String,
      markTitle: json['markTitle'] as String,
      maxMark: json['maxMark'] as String,
      weightage: json['weightage'] as String,
      status: json['status'] as String,
      scoredMark: json['scoredMark'] as String,
      weightageMark: json['weightageMark'] as String,
      remark: json['remark'] as String,
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'id': instance.id,
      'serialNumber': instance.serialNumber,
      'markTitle': instance.markTitle,
      'maxMark': instance.maxMark,
      'weightage': instance.weightage,
      'status': instance.status,
      'scoredMark': instance.scoredMark,
      'weightageMark': instance.weightageMark,
      'remark': instance.remark,
    };
