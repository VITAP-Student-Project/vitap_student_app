// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssignmentRecordEach _$AssignmentRecordEachFromJson(
        Map<String, dynamic> json) =>
    _AssignmentRecordEach(
      serialNumber: json['serialNumber'] as String,
      assignmentTitle: json['assignmentTitle'] as String,
      maxAssignmentMark: json['maxAssignmentMark'] as String,
      assignmentWeightageMark: json['assignmentWeightageMark'] as String,
      dueDate: json['dueDate'] as String,
      canQpDownload: json['canQpDownload'] as bool,
      qpDownloadUrl: json['qpDownloadUrl'] as String,
      submissionStatus: json['submissionStatus'] as String,
      canUpdate: json['canUpdate'] as bool,
      mcode: json['mcode'] as String,
      canDaDownload: json['canDaDownload'] as bool,
      daDownloadUrl: json['daDownloadUrl'] as String,
    );

Map<String, dynamic> _$AssignmentRecordEachToJson(
        _AssignmentRecordEach instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'assignmentTitle': instance.assignmentTitle,
      'maxAssignmentMark': instance.maxAssignmentMark,
      'assignmentWeightageMark': instance.assignmentWeightageMark,
      'dueDate': instance.dueDate,
      'canQpDownload': instance.canQpDownload,
      'qpDownloadUrl': instance.qpDownloadUrl,
      'submissionStatus': instance.submissionStatus,
      'canUpdate': instance.canUpdate,
      'mcode': instance.mcode,
      'canDaDownload': instance.canDaDownload,
      'daDownloadUrl': instance.daDownloadUrl,
    };

_DigitalAssignments _$DigitalAssignmentsFromJson(Map<String, dynamic> json) =>
    _DigitalAssignments(
      serialNumber: json['serialNumber'] as String,
      classId: json['classId'] as String,
      courseCode: json['courseCode'] as String,
      courseTitle: json['courseTitle'] as String,
      courseType: json['courseType'] as String,
      faculty: json['faculty'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) => AssignmentRecordEach.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DigitalAssignmentsToJson(_DigitalAssignments instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'classId': instance.classId,
      'courseCode': instance.courseCode,
      'courseTitle': instance.courseTitle,
      'courseType': instance.courseType,
      'faculty': instance.faculty,
      'details': instance.details,
    };
