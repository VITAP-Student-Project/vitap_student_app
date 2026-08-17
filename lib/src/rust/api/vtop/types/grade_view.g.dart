// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GradeRange _$GradeRangeFromJson(Map<String, dynamic> json) =>
    _GradeRange(grade: json['grade'] as String, range: json['range'] as String);

Map<String, dynamic> _$GradeRangeToJson(_GradeRange instance) =>
    <String, dynamic>{'grade': instance.grade, 'range': instance.range};

_GradeStatistics _$GradeStatisticsFromJson(Map<String, dynamic> json) =>
    _GradeStatistics(
      classStrength: json['classStrength'] as String,
      gradingStrength: json['gradingStrength'] as String,
      mean: json['mean'] as String,
      sd: json['sd'] as String,
      gradeRanges: (json['gradeRanges'] as List<dynamic>)
          .map((e) => GradeRange.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GradeStatisticsToJson(_GradeStatistics instance) =>
    <String, dynamic>{
      'classStrength': instance.classStrength,
      'gradingStrength': instance.gradingStrength,
      'mean': instance.mean,
      'sd': instance.sd,
      'gradeRanges': instance.gradeRanges,
    };

_GradeViewCourse _$GradeViewCourseFromJson(Map<String, dynamic> json) =>
    _GradeViewCourse(
      serialNumber: json['serialNumber'] as String,
      courseCode: json['courseCode'] as String,
      courseTitle: json['courseTitle'] as String,
      courseType: json['courseType'] as String,
      gradingType: json['gradingType'] as String,
      grandTotal: json['grandTotal'] as String,
      grade: json['grade'] as String,
      courseId: json['courseId'] as String,
    );

Map<String, dynamic> _$GradeViewCourseToJson(_GradeViewCourse instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'courseCode': instance.courseCode,
      'courseTitle': instance.courseTitle,
      'courseType': instance.courseType,
      'gradingType': instance.gradingType,
      'grandTotal': instance.grandTotal,
      'grade': instance.grade,
      'courseId': instance.courseId,
    };

_GradeViewDetail _$GradeViewDetailFromJson(Map<String, dynamic> json) =>
    _GradeViewDetail(
      classNumber: json['classNumber'] as String,
      courseType: json['courseType'] as String,
      marks: (json['marks'] as List<dynamic>)
          .map((e) => MarkComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as String,
      statistics: GradeStatistics.fromJson(
        json['statistics'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$GradeViewDetailToJson(_GradeViewDetail instance) =>
    <String, dynamic>{
      'classNumber': instance.classNumber,
      'courseType': instance.courseType,
      'marks': instance.marks,
      'total': instance.total,
      'statistics': instance.statistics,
    };

_MarkComponent _$MarkComponentFromJson(Map<String, dynamic> json) =>
    _MarkComponent(
      serialNumber: json['serialNumber'] as String,
      markTitle: json['markTitle'] as String,
      maxMark: json['maxMark'] as String,
      weightage: json['weightage'] as String,
      status: json['status'] as String,
      scoredMark: json['scoredMark'] as String,
      weightageMark: json['weightageMark'] as String,
    );

Map<String, dynamic> _$MarkComponentToJson(_MarkComponent instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'markTitle': instance.markTitle,
      'maxMark': instance.maxMark,
      'weightage': instance.weightage,
      'status': instance.status,
      'scoredMark': instance.scoredMark,
      'weightageMark': instance.weightageMark,
    };
