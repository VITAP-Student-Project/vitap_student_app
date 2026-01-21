// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotsResponseModel _$SlotsResponseModelFromJson(Map<String, dynamic> json) =>
    SlotsResponseModel(
      slots: (json['slots'] as List<dynamic>)
          .map((e) => SlotOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      classEntries: (json['class_entries'] as List<dynamic>)
          .map((e) => CourseClassEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SlotsResponseModelToJson(SlotsResponseModel instance) =>
    <String, dynamic>{
      'slots': instance.slots,
      'class_entries': instance.classEntries,
    };

SlotOptionModel _$SlotOptionModelFromJson(Map<String, dynamic> json) =>
    SlotOptionModel(
      value: json['value'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$SlotOptionModelToJson(SlotOptionModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
    };

CourseClassEntryModel _$CourseClassEntryModelFromJson(
        Map<String, dynamic> json) =>
    CourseClassEntryModel(
      slNo: (json['sl_no'] as num).toInt(),
      classGroup: json['class_group'] as String,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      courseType: json['course_type'] as String,
      classId: json['class_id'] as String,
      slot: json['slot'] as String,
      faculty: json['faculty'] as String,
      semesterId: json['semester_id'] as String,
      erpId: json['erp_id'] as String,
    );

Map<String, dynamic> _$CourseClassEntryModelToJson(
        CourseClassEntryModel instance) =>
    <String, dynamic>{
      'sl_no': instance.slNo,
      'class_group': instance.classGroup,
      'course_code': instance.courseCode,
      'course_title': instance.courseTitle,
      'course_type': instance.courseType,
      'class_id': instance.classId,
      'slot': instance.slot,
      'faculty': instance.faculty,
      'semester_id': instance.semesterId,
      'erp_id': instance.erpId,
    };
