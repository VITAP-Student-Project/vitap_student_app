// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FacultyDetails _$FacultyDetailsFromJson(Map<String, dynamic> json) =>
    _FacultyDetails(
      name: json['name'] as String,
      designation: json['designation'] as String,
      department: json['department'] as String,
      schoolCentre: json['schoolCentre'] as String,
      email: json['email'] as String,
      cabinNumber: json['cabinNumber'] as String,
      officeHours: (json['officeHours'] as List<dynamic>)
          .map((e) => OfficeHour.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FacultyDetailsToJson(_FacultyDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'designation': instance.designation,
      'department': instance.department,
      'schoolCentre': instance.schoolCentre,
      'email': instance.email,
      'cabinNumber': instance.cabinNumber,
      'officeHours': instance.officeHours,
    };

_OfficeHour _$OfficeHourFromJson(Map<String, dynamic> json) => _OfficeHour(
      day: json['day'] as String,
      timings: json['timings'] as String,
    );

Map<String, dynamic> _$OfficeHourToJson(_OfficeHour instance) =>
    <String, dynamic>{
      'day': instance.day,
      'timings': instance.timings,
    };
