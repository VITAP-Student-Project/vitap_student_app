// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicCalendar _$AcademicCalendarFromJson(Map<String, dynamic> json) =>
    AcademicCalendar(
      id: (json['id'] as num?)?.toInt(),
      semesterId: json['semester_id'] as String,
      classGroupId: json['class_group_id'] as String,
      months: const _CalendarMonthRelToManyConverter().fromJson(
        json['months'] as List?,
      ),
      days: const _CalendarDayRelToManyConverter().fromJson(
        json['days'] as List?,
      ),
    );

Map<String, dynamic> _$AcademicCalendarToJson(
  AcademicCalendar instance,
) => <String, dynamic>{
  'id': instance.id,
  'semester_id': instance.semesterId,
  'class_group_id': instance.classGroupId,
  'months': const _CalendarMonthRelToManyConverter().toJson(instance.months),
  'days': const _CalendarDayRelToManyConverter().toJson(instance.days),
};

CalendarMonthRef _$CalendarMonthRefFromJson(Map<String, dynamic> json) =>
    CalendarMonthRef(
      id: (json['id'] as num?)?.toInt(),
      label: json['label'] as String,
      calDate: json['cal_date'] as String,
    );

Map<String, dynamic> _$CalendarMonthRefToJson(CalendarMonthRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'cal_date': instance.calDate,
    };

CalendarDay _$CalendarDayFromJson(Map<String, dynamic> json) => CalendarDay(
  id: (json['id'] as num?)?.toInt(),
  date: json['date'] as String,
  day: (json['day'] as num).toInt(),
  weekday: json['weekday'] as String,
  events: const _CalendarEventRelToManyConverter().fromJson(
    json['events'] as List?,
  ),
);

Map<String, dynamic> _$CalendarDayToJson(
  CalendarDay instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'day': instance.day,
  'weekday': instance.weekday,
  'events': const _CalendarEventRelToManyConverter().toJson(instance.events),
};

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    CalendarEvent(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'label': instance.label,
    };
