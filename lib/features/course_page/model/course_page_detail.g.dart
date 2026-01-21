// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_page_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursePageDetailModel _$CoursePageDetailModelFromJson(
        Map<String, dynamic> json) =>
    CoursePageDetailModel(
      courseInfo:
          CourseInfoModel.fromJson(json['course_info'] as Map<String, dynamic>),
      semesterId: json['semester_id'] as String,
      downloadAllPath: json['download_all_path'] as String?,
      downloadGeneralMaterialsPath:
          json['download_general_materials_path'] as String?,
      syllabusDownloadPath: json['syllabus_download_path'] as String?,
      coursePlanDownloadPath: json['course_plan_download_path'] as String?,
      lectures: (json['lectures'] as List<dynamic>)
          .map((e) => LectureEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursePageDetailModelToJson(
        CoursePageDetailModel instance) =>
    <String, dynamic>{
      'course_info': instance.courseInfo,
      'semester_id': instance.semesterId,
      'download_all_path': instance.downloadAllPath,
      'download_general_materials_path': instance.downloadGeneralMaterialsPath,
      'syllabus_download_path': instance.syllabusDownloadPath,
      'course_plan_download_path': instance.coursePlanDownloadPath,
      'lectures': instance.lectures,
    };

CourseInfoModel _$CourseInfoModelFromJson(Map<String, dynamic> json) =>
    CourseInfoModel(
      classGroup: json['class_group'] as String,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      courseType: json['course_type'] as String,
      classId: json['class_id'] as String,
      slot: json['slot'] as String,
      faculty: json['faculty'] as String,
      courseId: json['course_id'] as String,
    );

Map<String, dynamic> _$CourseInfoModelToJson(CourseInfoModel instance) =>
    <String, dynamic>{
      'class_group': instance.classGroup,
      'course_code': instance.courseCode,
      'course_title': instance.courseTitle,
      'course_type': instance.courseType,
      'class_id': instance.classId,
      'slot': instance.slot,
      'faculty': instance.faculty,
      'course_id': instance.courseId,
    };

LectureEntryModel _$LectureEntryModelFromJson(Map<String, dynamic> json) =>
    LectureEntryModel(
      slNo: (json['sl_no'] as num).toInt(),
      date: json['date'] as String,
      formattedDate: json['formatted_date'] as String,
      day: json['day'] as String,
      topic: json['topic'] as String,
      referenceMaterials: (json['reference_materials'] as List<dynamic>)
          .map(
              (e) => ReferenceMaterialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LectureEntryModelToJson(LectureEntryModel instance) =>
    <String, dynamic>{
      'sl_no': instance.slNo,
      'date': instance.date,
      'formatted_date': instance.formattedDate,
      'day': instance.day,
      'topic': instance.topic,
      'reference_materials': instance.referenceMaterials,
    };

ReferenceMaterialModel _$ReferenceMaterialModelFromJson(
        Map<String, dynamic> json) =>
    ReferenceMaterialModel(
      label: json['label'] as String,
      downloadPath: json['download_path'] as String,
    );

Map<String, dynamic> _$ReferenceMaterialModelToJson(
        ReferenceMaterialModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'download_path': instance.downloadPath,
    };
