// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AcademicCalendar _$AcademicCalendarFromJson(Map<String, dynamic> json) =>
    _AcademicCalendar(
      semesterId: json['semesterId'] as String,
      classGroupId: json['classGroupId'] as String,
      months: (json['months'] as List<dynamic>)
          .map((e) => CalendarMonthRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      days: (json['days'] as List<dynamic>)
          .map((e) => CalendarDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AcademicCalendarToJson(_AcademicCalendar instance) =>
    <String, dynamic>{
      'semesterId': instance.semesterId,
      'classGroupId': instance.classGroupId,
      'months': instance.months,
      'days': instance.days,
    };

_CalendarDay _$CalendarDayFromJson(Map<String, dynamic> json) => _CalendarDay(
  date: json['date'] as String,
  day: (json['day'] as num).toInt(),
  weekday: json['weekday'] as String,
  events: (json['events'] as List<dynamic>)
      .map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CalendarDayToJson(_CalendarDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day': instance.day,
      'weekday': instance.weekday,
      'events': instance.events,
    };

_CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    _CalendarEvent(
      description: json['description'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$CalendarEventToJson(_CalendarEvent instance) =>
    <String, dynamic>{
      'description': instance.description,
      'label': instance.label,
    };

_CalendarMonthRef _$CalendarMonthRefFromJson(Map<String, dynamic> json) =>
    _CalendarMonthRef(
      label: json['label'] as String,
      calDate: json['calDate'] as String,
    );

Map<String, dynamic> _$CalendarMonthRefToJson(_CalendarMonthRef instance) =>
    <String, dynamic>{'label': instance.label, 'calDate': instance.calDate};

_ClassGroup _$ClassGroupFromJson(Map<String, dynamic> json) =>
    _ClassGroup(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$ClassGroupToJson(_ClassGroup instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
