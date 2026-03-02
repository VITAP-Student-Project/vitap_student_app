// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalAssignment _$DigitalAssignmentFromJson(Map<String, dynamic> json) =>
    DigitalAssignment(
      serialNumber: json['serial_number'] as String,
      classId: json['class_id'] as String,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      courseType: json['course_type'] as String,
      faculty: json['faculty'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) => AssignmentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DigitalAssignmentToJson(DigitalAssignment instance) =>
    <String, dynamic>{
      'serial_number': instance.serialNumber,
      'class_id': instance.classId,
      'course_code': instance.courseCode,
      'course_title': instance.courseTitle,
      'course_type': instance.courseType,
      'faculty': instance.faculty,
      'details': instance.details,
    };

AssignmentDetail _$AssignmentDetailFromJson(Map<String, dynamic> json) =>
    AssignmentDetail(
      serialNumber: json['serial_number'] as String,
      assignmentTitle: json['assignment_title'] as String,
      maxAssignmentMark: json['max_assignment_mark'] as String,
      assignmentWeightageMark: json['assignment_weightage_mark'] as String,
      dueDate: json['due_date'] as String,
      canQpDownload: json['can_qp_download'] as bool,
      qpDownloadUrl: json['qp_download_url'] as String,
      submissionStatus: json['submission_status'] as String,
      canUpdate: json['can_update'] as bool,
      mcode: json['mcode'] as String,
      canDaDownload: json['can_da_download'] as bool,
      daDownloadUrl: json['da_download_url'] as String,
    );

Map<String, dynamic> _$AssignmentDetailToJson(AssignmentDetail instance) =>
    <String, dynamic>{
      'serial_number': instance.serialNumber,
      'assignment_title': instance.assignmentTitle,
      'max_assignment_mark': instance.maxAssignmentMark,
      'assignment_weightage_mark': instance.assignmentWeightageMark,
      'due_date': instance.dueDate,
      'can_qp_download': instance.canQpDownload,
      'qp_download_url': instance.qpDownloadUrl,
      'submission_status': instance.submissionStatus,
      'can_update': instance.canUpdate,
      'mcode': instance.mcode,
      'can_da_download': instance.canDaDownload,
      'da_download_url': instance.daDownloadUrl,
    };
