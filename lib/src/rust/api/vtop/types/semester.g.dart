// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SemesterData _$SemesterDataFromJson(Map<String, dynamic> json) =>
    _SemesterData(
      semesters: (json['semesters'] as List<dynamic>)
          .map((e) => SemesterInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      updateTime: BigInt.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$SemesterDataToJson(_SemesterData instance) =>
    <String, dynamic>{
      'semesters': instance.semesters,
      'updateTime': instance.updateTime.toString(),
    };

_SemesterInfo _$SemesterInfoFromJson(Map<String, dynamic> json) =>
    _SemesterInfo(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SemesterInfoToJson(_SemesterInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
