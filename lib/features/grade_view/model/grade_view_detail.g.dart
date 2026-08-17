// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_view_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeViewDetailModel _$GradeViewDetailModelFromJson(
  Map<String, dynamic> json,
) => GradeViewDetailModel(
  classNumber: json['class_number'] as String,
  courseType: json['course_type'] as String,
  marks: (json['marks'] as List<dynamic>)
      .map((e) => MarkComponentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: json['total'] as String,
  statistics: GradeStatisticsModel.fromJson(
    json['statistics'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$GradeViewDetailModelToJson(
  GradeViewDetailModel instance,
) => <String, dynamic>{
  'class_number': instance.classNumber,
  'course_type': instance.courseType,
  'marks': instance.marks,
  'total': instance.total,
  'statistics': instance.statistics,
};

MarkComponentModel _$MarkComponentModelFromJson(Map<String, dynamic> json) =>
    MarkComponentModel(
      serialNumber: json['serial_number'] as String,
      markTitle: json['mark_title'] as String,
      maxMark: json['max_mark'] as String,
      weightage: json['weightage'] as String,
      status: json['status'] as String,
      scoredMark: json['scored_mark'] as String,
      weightageMark: json['weightage_mark'] as String,
    );

Map<String, dynamic> _$MarkComponentModelToJson(MarkComponentModel instance) =>
    <String, dynamic>{
      'serial_number': instance.serialNumber,
      'mark_title': instance.markTitle,
      'max_mark': instance.maxMark,
      'weightage': instance.weightage,
      'status': instance.status,
      'scored_mark': instance.scoredMark,
      'weightage_mark': instance.weightageMark,
    };

GradeStatisticsModel _$GradeStatisticsModelFromJson(
  Map<String, dynamic> json,
) => GradeStatisticsModel(
  classStrength: json['class_strength'] as String,
  gradingStrength: json['grading_strength'] as String,
  mean: json['mean'] as String,
  sd: json['sd'] as String,
  gradeRanges: (json['grade_ranges'] as List<dynamic>)
      .map((e) => GradeRangeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GradeStatisticsModelToJson(
  GradeStatisticsModel instance,
) => <String, dynamic>{
  'class_strength': instance.classStrength,
  'grading_strength': instance.gradingStrength,
  'mean': instance.mean,
  'sd': instance.sd,
  'grade_ranges': instance.gradeRanges,
};

GradeRangeModel _$GradeRangeModelFromJson(Map<String, dynamic> json) =>
    GradeRangeModel(
      grade: json['grade'] as String,
      range: json['range'] as String,
    );

Map<String, dynamic> _$GradeRangeModelToJson(GradeRangeModel instance) =>
    <String, dynamic>{'grade': instance.grade, 'range': instance.range};
