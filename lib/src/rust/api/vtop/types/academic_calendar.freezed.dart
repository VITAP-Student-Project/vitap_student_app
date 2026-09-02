// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academic_calendar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AcademicCalendar {

 String get semesterId; String get classGroupId; List<CalendarMonthRef> get months; List<CalendarDay> get days;
/// Create a copy of AcademicCalendar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcademicCalendarCopyWith<AcademicCalendar> get copyWith => _$AcademicCalendarCopyWithImpl<AcademicCalendar>(this as AcademicCalendar, _$identity);

  /// Serializes this AcademicCalendar to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcademicCalendar&&(identical(other.semesterId, semesterId) || other.semesterId == semesterId)&&(identical(other.classGroupId, classGroupId) || other.classGroupId == classGroupId)&&const DeepCollectionEquality().equals(other.months, months)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,semesterId,classGroupId,const DeepCollectionEquality().hash(months),const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'AcademicCalendar(semesterId: $semesterId, classGroupId: $classGroupId, months: $months, days: $days)';
}


}

/// @nodoc
abstract mixin class $AcademicCalendarCopyWith<$Res>  {
  factory $AcademicCalendarCopyWith(AcademicCalendar value, $Res Function(AcademicCalendar) _then) = _$AcademicCalendarCopyWithImpl;
@useResult
$Res call({
 String semesterId, String classGroupId, List<CalendarMonthRef> months, List<CalendarDay> days
});




}
/// @nodoc
class _$AcademicCalendarCopyWithImpl<$Res>
    implements $AcademicCalendarCopyWith<$Res> {
  _$AcademicCalendarCopyWithImpl(this._self, this._then);

  final AcademicCalendar _self;
  final $Res Function(AcademicCalendar) _then;

/// Create a copy of AcademicCalendar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? semesterId = null,Object? classGroupId = null,Object? months = null,Object? days = null,}) {
  return _then(_self.copyWith(
semesterId: null == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as String,classGroupId: null == classGroupId ? _self.classGroupId : classGroupId // ignore: cast_nullable_to_non_nullable
as String,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as List<CalendarMonthRef>,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<CalendarDay>,
  ));
}

}


/// Adds pattern-matching-related methods to [AcademicCalendar].
extension AcademicCalendarPatterns on AcademicCalendar {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AcademicCalendar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AcademicCalendar() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AcademicCalendar value)  $default,){
final _that = this;
switch (_that) {
case _AcademicCalendar():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AcademicCalendar value)?  $default,){
final _that = this;
switch (_that) {
case _AcademicCalendar() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String semesterId,  String classGroupId,  List<CalendarMonthRef> months,  List<CalendarDay> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AcademicCalendar() when $default != null:
return $default(_that.semesterId,_that.classGroupId,_that.months,_that.days);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String semesterId,  String classGroupId,  List<CalendarMonthRef> months,  List<CalendarDay> days)  $default,) {final _that = this;
switch (_that) {
case _AcademicCalendar():
return $default(_that.semesterId,_that.classGroupId,_that.months,_that.days);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String semesterId,  String classGroupId,  List<CalendarMonthRef> months,  List<CalendarDay> days)?  $default,) {final _that = this;
switch (_that) {
case _AcademicCalendar() when $default != null:
return $default(_that.semesterId,_that.classGroupId,_that.months,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AcademicCalendar extends AcademicCalendar {
  const _AcademicCalendar({required this.semesterId, required this.classGroupId, required final  List<CalendarMonthRef> months, required final  List<CalendarDay> days}): _months = months,_days = days,super._();
  factory _AcademicCalendar.fromJson(Map<String, dynamic> json) => _$AcademicCalendarFromJson(json);

@override final  String semesterId;
@override final  String classGroupId;
 final  List<CalendarMonthRef> _months;
@override List<CalendarMonthRef> get months {
  if (_months is EqualUnmodifiableListView) return _months;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_months);
}

 final  List<CalendarDay> _days;
@override List<CalendarDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of AcademicCalendar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcademicCalendarCopyWith<_AcademicCalendar> get copyWith => __$AcademicCalendarCopyWithImpl<_AcademicCalendar>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcademicCalendarToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcademicCalendar&&(identical(other.semesterId, semesterId) || other.semesterId == semesterId)&&(identical(other.classGroupId, classGroupId) || other.classGroupId == classGroupId)&&const DeepCollectionEquality().equals(other._months, _months)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,semesterId,classGroupId,const DeepCollectionEquality().hash(_months),const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'AcademicCalendar(semesterId: $semesterId, classGroupId: $classGroupId, months: $months, days: $days)';
}


}

/// @nodoc
abstract mixin class _$AcademicCalendarCopyWith<$Res> implements $AcademicCalendarCopyWith<$Res> {
  factory _$AcademicCalendarCopyWith(_AcademicCalendar value, $Res Function(_AcademicCalendar) _then) = __$AcademicCalendarCopyWithImpl;
@override @useResult
$Res call({
 String semesterId, String classGroupId, List<CalendarMonthRef> months, List<CalendarDay> days
});




}
/// @nodoc
class __$AcademicCalendarCopyWithImpl<$Res>
    implements _$AcademicCalendarCopyWith<$Res> {
  __$AcademicCalendarCopyWithImpl(this._self, this._then);

  final _AcademicCalendar _self;
  final $Res Function(_AcademicCalendar) _then;

/// Create a copy of AcademicCalendar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? semesterId = null,Object? classGroupId = null,Object? months = null,Object? days = null,}) {
  return _then(_AcademicCalendar(
semesterId: null == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as String,classGroupId: null == classGroupId ? _self.classGroupId : classGroupId // ignore: cast_nullable_to_non_nullable
as String,months: null == months ? _self._months : months // ignore: cast_nullable_to_non_nullable
as List<CalendarMonthRef>,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<CalendarDay>,
  ));
}


}


/// @nodoc
mixin _$CalendarDay {

 String get date; int get day; String get weekday; List<CalendarEvent> get events;
/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayCopyWith<CalendarDay> get copyWith => _$CalendarDayCopyWithImpl<CalendarDay>(this as CalendarDay, _$identity);

  /// Serializes this CalendarDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDay&&(identical(other.date, date) || other.date == date)&&(identical(other.day, day) || other.day == day)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,day,weekday,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'CalendarDay(date: $date, day: $day, weekday: $weekday, events: $events)';
}


}

/// @nodoc
abstract mixin class $CalendarDayCopyWith<$Res>  {
  factory $CalendarDayCopyWith(CalendarDay value, $Res Function(CalendarDay) _then) = _$CalendarDayCopyWithImpl;
@useResult
$Res call({
 String date, int day, String weekday, List<CalendarEvent> events
});




}
/// @nodoc
class _$CalendarDayCopyWithImpl<$Res>
    implements $CalendarDayCopyWith<$Res> {
  _$CalendarDayCopyWithImpl(this._self, this._then);

  final CalendarDay _self;
  final $Res Function(CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? day = null,Object? weekday = null,Object? events = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarDay].
extension CalendarDayPatterns on CalendarDay {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarDay value)  $default,){
final _that = this;
switch (_that) {
case _CalendarDay():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarDay value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int day,  String weekday,  List<CalendarEvent> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that.date,_that.day,_that.weekday,_that.events);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int day,  String weekday,  List<CalendarEvent> events)  $default,) {final _that = this;
switch (_that) {
case _CalendarDay():
return $default(_that.date,_that.day,_that.weekday,_that.events);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int day,  String weekday,  List<CalendarEvent> events)?  $default,) {final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that.date,_that.day,_that.weekday,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarDay implements CalendarDay {
  const _CalendarDay({required this.date, required this.day, required this.weekday, required final  List<CalendarEvent> events}): _events = events;
  factory _CalendarDay.fromJson(Map<String, dynamic> json) => _$CalendarDayFromJson(json);

@override final  String date;
@override final  int day;
@override final  String weekday;
 final  List<CalendarEvent> _events;
@override List<CalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayCopyWith<_CalendarDay> get copyWith => __$CalendarDayCopyWithImpl<_CalendarDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDay&&(identical(other.date, date) || other.date == date)&&(identical(other.day, day) || other.day == day)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,day,weekday,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'CalendarDay(date: $date, day: $day, weekday: $weekday, events: $events)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayCopyWith<$Res> implements $CalendarDayCopyWith<$Res> {
  factory _$CalendarDayCopyWith(_CalendarDay value, $Res Function(_CalendarDay) _then) = __$CalendarDayCopyWithImpl;
@override @useResult
$Res call({
 String date, int day, String weekday, List<CalendarEvent> events
});




}
/// @nodoc
class __$CalendarDayCopyWithImpl<$Res>
    implements _$CalendarDayCopyWith<$Res> {
  __$CalendarDayCopyWithImpl(this._self, this._then);

  final _CalendarDay _self;
  final $Res Function(_CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? day = null,Object? weekday = null,Object? events = null,}) {
  return _then(_CalendarDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}


}


/// @nodoc
mixin _$CalendarEvent {

 String get description; String get label;
/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventCopyWith<CalendarEvent> get copyWith => _$CalendarEventCopyWithImpl<CalendarEvent>(this as CalendarEvent, _$identity);

  /// Serializes this CalendarEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEvent&&(identical(other.description, description) || other.description == description)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,label);

@override
String toString() {
  return 'CalendarEvent(description: $description, label: $label)';
}


}

/// @nodoc
abstract mixin class $CalendarEventCopyWith<$Res>  {
  factory $CalendarEventCopyWith(CalendarEvent value, $Res Function(CalendarEvent) _then) = _$CalendarEventCopyWithImpl;
@useResult
$Res call({
 String description, String label
});




}
/// @nodoc
class _$CalendarEventCopyWithImpl<$Res>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._self, this._then);

  final CalendarEvent _self;
  final $Res Function(CalendarEvent) _then;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? label = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEvent].
extension CalendarEventPatterns on CalendarEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEvent value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEvent():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEvent value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
return $default(_that.description,_that.label);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  String label)  $default,) {final _that = this;
switch (_that) {
case _CalendarEvent():
return $default(_that.description,_that.label);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  String label)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
return $default(_that.description,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarEvent implements CalendarEvent {
  const _CalendarEvent({required this.description, required this.label});
  factory _CalendarEvent.fromJson(Map<String, dynamic> json) => _$CalendarEventFromJson(json);

@override final  String description;
@override final  String label;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventCopyWith<_CalendarEvent> get copyWith => __$CalendarEventCopyWithImpl<_CalendarEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEvent&&(identical(other.description, description) || other.description == description)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,label);

@override
String toString() {
  return 'CalendarEvent(description: $description, label: $label)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventCopyWith<$Res> implements $CalendarEventCopyWith<$Res> {
  factory _$CalendarEventCopyWith(_CalendarEvent value, $Res Function(_CalendarEvent) _then) = __$CalendarEventCopyWithImpl;
@override @useResult
$Res call({
 String description, String label
});




}
/// @nodoc
class __$CalendarEventCopyWithImpl<$Res>
    implements _$CalendarEventCopyWith<$Res> {
  __$CalendarEventCopyWithImpl(this._self, this._then);

  final _CalendarEvent _self;
  final $Res Function(_CalendarEvent) _then;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? label = null,}) {
  return _then(_CalendarEvent(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CalendarMonthRef {

 String get label; String get calDate;
/// Create a copy of CalendarMonthRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarMonthRefCopyWith<CalendarMonthRef> get copyWith => _$CalendarMonthRefCopyWithImpl<CalendarMonthRef>(this as CalendarMonthRef, _$identity);

  /// Serializes this CalendarMonthRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarMonthRef&&(identical(other.label, label) || other.label == label)&&(identical(other.calDate, calDate) || other.calDate == calDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,calDate);

@override
String toString() {
  return 'CalendarMonthRef(label: $label, calDate: $calDate)';
}


}

/// @nodoc
abstract mixin class $CalendarMonthRefCopyWith<$Res>  {
  factory $CalendarMonthRefCopyWith(CalendarMonthRef value, $Res Function(CalendarMonthRef) _then) = _$CalendarMonthRefCopyWithImpl;
@useResult
$Res call({
 String label, String calDate
});




}
/// @nodoc
class _$CalendarMonthRefCopyWithImpl<$Res>
    implements $CalendarMonthRefCopyWith<$Res> {
  _$CalendarMonthRefCopyWithImpl(this._self, this._then);

  final CalendarMonthRef _self;
  final $Res Function(CalendarMonthRef) _then;

/// Create a copy of CalendarMonthRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? calDate = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,calDate: null == calDate ? _self.calDate : calDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarMonthRef].
extension CalendarMonthRefPatterns on CalendarMonthRef {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarMonthRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarMonthRef() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarMonthRef value)  $default,){
final _that = this;
switch (_that) {
case _CalendarMonthRef():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarMonthRef value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarMonthRef() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String calDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarMonthRef() when $default != null:
return $default(_that.label,_that.calDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String calDate)  $default,) {final _that = this;
switch (_that) {
case _CalendarMonthRef():
return $default(_that.label,_that.calDate);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String calDate)?  $default,) {final _that = this;
switch (_that) {
case _CalendarMonthRef() when $default != null:
return $default(_that.label,_that.calDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarMonthRef implements CalendarMonthRef {
  const _CalendarMonthRef({required this.label, required this.calDate});
  factory _CalendarMonthRef.fromJson(Map<String, dynamic> json) => _$CalendarMonthRefFromJson(json);

@override final  String label;
@override final  String calDate;

/// Create a copy of CalendarMonthRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarMonthRefCopyWith<_CalendarMonthRef> get copyWith => __$CalendarMonthRefCopyWithImpl<_CalendarMonthRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarMonthRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarMonthRef&&(identical(other.label, label) || other.label == label)&&(identical(other.calDate, calDate) || other.calDate == calDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,calDate);

@override
String toString() {
  return 'CalendarMonthRef(label: $label, calDate: $calDate)';
}


}

/// @nodoc
abstract mixin class _$CalendarMonthRefCopyWith<$Res> implements $CalendarMonthRefCopyWith<$Res> {
  factory _$CalendarMonthRefCopyWith(_CalendarMonthRef value, $Res Function(_CalendarMonthRef) _then) = __$CalendarMonthRefCopyWithImpl;
@override @useResult
$Res call({
 String label, String calDate
});




}
/// @nodoc
class __$CalendarMonthRefCopyWithImpl<$Res>
    implements _$CalendarMonthRefCopyWith<$Res> {
  __$CalendarMonthRefCopyWithImpl(this._self, this._then);

  final _CalendarMonthRef _self;
  final $Res Function(_CalendarMonthRef) _then;

/// Create a copy of CalendarMonthRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? calDate = null,}) {
  return _then(_CalendarMonthRef(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,calDate: null == calDate ? _self.calDate : calDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ClassGroup {

 String get id; String get name;
/// Create a copy of ClassGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassGroupCopyWith<ClassGroup> get copyWith => _$ClassGroupCopyWithImpl<ClassGroup>(this as ClassGroup, _$identity);

  /// Serializes this ClassGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'ClassGroup(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $ClassGroupCopyWith<$Res>  {
  factory $ClassGroupCopyWith(ClassGroup value, $Res Function(ClassGroup) _then) = _$ClassGroupCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$ClassGroupCopyWithImpl<$Res>
    implements $ClassGroupCopyWith<$Res> {
  _$ClassGroupCopyWithImpl(this._self, this._then);

  final ClassGroup _self;
  final $Res Function(ClassGroup) _then;

/// Create a copy of ClassGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassGroup].
extension ClassGroupPatterns on ClassGroup {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassGroup() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassGroup value)  $default,){
final _that = this;
switch (_that) {
case _ClassGroup():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassGroup value)?  $default,){
final _that = this;
switch (_that) {
case _ClassGroup() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassGroup() when $default != null:
return $default(_that.id,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _ClassGroup():
return $default(_that.id,_that.name);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _ClassGroup() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassGroup implements ClassGroup {
  const _ClassGroup({required this.id, required this.name});
  factory _ClassGroup.fromJson(Map<String, dynamic> json) => _$ClassGroupFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of ClassGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassGroupCopyWith<_ClassGroup> get copyWith => __$ClassGroupCopyWithImpl<_ClassGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'ClassGroup(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ClassGroupCopyWith<$Res> implements $ClassGroupCopyWith<$Res> {
  factory _$ClassGroupCopyWith(_ClassGroup value, $Res Function(_ClassGroup) _then) = __$ClassGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$ClassGroupCopyWithImpl<$Res>
    implements _$ClassGroupCopyWith<$Res> {
  __$ClassGroupCopyWithImpl(this._self, this._then);

  final _ClassGroup _self;
  final $Res Function(_ClassGroup) _then;

/// Create a copy of ClassGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_ClassGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
