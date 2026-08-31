// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capstone_attendance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CapstoneAttendance {

 CapstoneInfo get info; CapstoneSummary get summary; List<CapstonePunch> get punches;
/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapstoneAttendanceCopyWith<CapstoneAttendance> get copyWith => _$CapstoneAttendanceCopyWithImpl<CapstoneAttendance>(this as CapstoneAttendance, _$identity);

  /// Serializes this CapstoneAttendance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapstoneAttendance&&(identical(other.info, info) || other.info == info)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.punches, punches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,summary,const DeepCollectionEquality().hash(punches));

@override
String toString() {
  return 'CapstoneAttendance(info: $info, summary: $summary, punches: $punches)';
}


}

/// @nodoc
abstract mixin class $CapstoneAttendanceCopyWith<$Res>  {
  factory $CapstoneAttendanceCopyWith(CapstoneAttendance value, $Res Function(CapstoneAttendance) _then) = _$CapstoneAttendanceCopyWithImpl;
@useResult
$Res call({
 CapstoneInfo info, CapstoneSummary summary, List<CapstonePunch> punches
});


$CapstoneInfoCopyWith<$Res> get info;$CapstoneSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$CapstoneAttendanceCopyWithImpl<$Res>
    implements $CapstoneAttendanceCopyWith<$Res> {
  _$CapstoneAttendanceCopyWithImpl(this._self, this._then);

  final CapstoneAttendance _self;
  final $Res Function(CapstoneAttendance) _then;

/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? summary = null,Object? punches = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as CapstoneInfo,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as CapstoneSummary,punches: null == punches ? _self.punches : punches // ignore: cast_nullable_to_non_nullable
as List<CapstonePunch>,
  ));
}
/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapstoneInfoCopyWith<$Res> get info {
  
  return $CapstoneInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapstoneSummaryCopyWith<$Res> get summary {
  
  return $CapstoneSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [CapstoneAttendance].
extension CapstoneAttendancePatterns on CapstoneAttendance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapstoneAttendance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapstoneAttendance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapstoneAttendance value)  $default,){
final _that = this;
switch (_that) {
case _CapstoneAttendance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapstoneAttendance value)?  $default,){
final _that = this;
switch (_that) {
case _CapstoneAttendance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CapstoneInfo info,  CapstoneSummary summary,  List<CapstonePunch> punches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapstoneAttendance() when $default != null:
return $default(_that.info,_that.summary,_that.punches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CapstoneInfo info,  CapstoneSummary summary,  List<CapstonePunch> punches)  $default,) {final _that = this;
switch (_that) {
case _CapstoneAttendance():
return $default(_that.info,_that.summary,_that.punches);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CapstoneInfo info,  CapstoneSummary summary,  List<CapstonePunch> punches)?  $default,) {final _that = this;
switch (_that) {
case _CapstoneAttendance() when $default != null:
return $default(_that.info,_that.summary,_that.punches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CapstoneAttendance extends CapstoneAttendance {
  const _CapstoneAttendance({required this.info, required this.summary, required final  List<CapstonePunch> punches}): _punches = punches,super._();
  factory _CapstoneAttendance.fromJson(Map<String, dynamic> json) => _$CapstoneAttendanceFromJson(json);

@override final  CapstoneInfo info;
@override final  CapstoneSummary summary;
 final  List<CapstonePunch> _punches;
@override List<CapstonePunch> get punches {
  if (_punches is EqualUnmodifiableListView) return _punches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_punches);
}


/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapstoneAttendanceCopyWith<_CapstoneAttendance> get copyWith => __$CapstoneAttendanceCopyWithImpl<_CapstoneAttendance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CapstoneAttendanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapstoneAttendance&&(identical(other.info, info) || other.info == info)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._punches, _punches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,summary,const DeepCollectionEquality().hash(_punches));

@override
String toString() {
  return 'CapstoneAttendance(info: $info, summary: $summary, punches: $punches)';
}


}

/// @nodoc
abstract mixin class _$CapstoneAttendanceCopyWith<$Res> implements $CapstoneAttendanceCopyWith<$Res> {
  factory _$CapstoneAttendanceCopyWith(_CapstoneAttendance value, $Res Function(_CapstoneAttendance) _then) = __$CapstoneAttendanceCopyWithImpl;
@override @useResult
$Res call({
 CapstoneInfo info, CapstoneSummary summary, List<CapstonePunch> punches
});


@override $CapstoneInfoCopyWith<$Res> get info;@override $CapstoneSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$CapstoneAttendanceCopyWithImpl<$Res>
    implements _$CapstoneAttendanceCopyWith<$Res> {
  __$CapstoneAttendanceCopyWithImpl(this._self, this._then);

  final _CapstoneAttendance _self;
  final $Res Function(_CapstoneAttendance) _then;

/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? summary = null,Object? punches = null,}) {
  return _then(_CapstoneAttendance(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as CapstoneInfo,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as CapstoneSummary,punches: null == punches ? _self._punches : punches // ignore: cast_nullable_to_non_nullable
as List<CapstonePunch>,
  ));
}

/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapstoneInfoCopyWith<$Res> get info {
  
  return $CapstoneInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of CapstoneAttendance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapstoneSummaryCopyWith<$Res> get summary {
  
  return $CapstoneSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$CapstoneInfo {

 String get title; String get guideEvaluationStatus; String get dateOfRegistration;
/// Create a copy of CapstoneInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapstoneInfoCopyWith<CapstoneInfo> get copyWith => _$CapstoneInfoCopyWithImpl<CapstoneInfo>(this as CapstoneInfo, _$identity);

  /// Serializes this CapstoneInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapstoneInfo&&(identical(other.title, title) || other.title == title)&&(identical(other.guideEvaluationStatus, guideEvaluationStatus) || other.guideEvaluationStatus == guideEvaluationStatus)&&(identical(other.dateOfRegistration, dateOfRegistration) || other.dateOfRegistration == dateOfRegistration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,guideEvaluationStatus,dateOfRegistration);

@override
String toString() {
  return 'CapstoneInfo(title: $title, guideEvaluationStatus: $guideEvaluationStatus, dateOfRegistration: $dateOfRegistration)';
}


}

/// @nodoc
abstract mixin class $CapstoneInfoCopyWith<$Res>  {
  factory $CapstoneInfoCopyWith(CapstoneInfo value, $Res Function(CapstoneInfo) _then) = _$CapstoneInfoCopyWithImpl;
@useResult
$Res call({
 String title, String guideEvaluationStatus, String dateOfRegistration
});




}
/// @nodoc
class _$CapstoneInfoCopyWithImpl<$Res>
    implements $CapstoneInfoCopyWith<$Res> {
  _$CapstoneInfoCopyWithImpl(this._self, this._then);

  final CapstoneInfo _self;
  final $Res Function(CapstoneInfo) _then;

/// Create a copy of CapstoneInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? guideEvaluationStatus = null,Object? dateOfRegistration = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,guideEvaluationStatus: null == guideEvaluationStatus ? _self.guideEvaluationStatus : guideEvaluationStatus // ignore: cast_nullable_to_non_nullable
as String,dateOfRegistration: null == dateOfRegistration ? _self.dateOfRegistration : dateOfRegistration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CapstoneInfo].
extension CapstoneInfoPatterns on CapstoneInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapstoneInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapstoneInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapstoneInfo value)  $default,){
final _that = this;
switch (_that) {
case _CapstoneInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapstoneInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CapstoneInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String guideEvaluationStatus,  String dateOfRegistration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapstoneInfo() when $default != null:
return $default(_that.title,_that.guideEvaluationStatus,_that.dateOfRegistration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String guideEvaluationStatus,  String dateOfRegistration)  $default,) {final _that = this;
switch (_that) {
case _CapstoneInfo():
return $default(_that.title,_that.guideEvaluationStatus,_that.dateOfRegistration);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String guideEvaluationStatus,  String dateOfRegistration)?  $default,) {final _that = this;
switch (_that) {
case _CapstoneInfo() when $default != null:
return $default(_that.title,_that.guideEvaluationStatus,_that.dateOfRegistration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CapstoneInfo extends CapstoneInfo {
  const _CapstoneInfo({required this.title, required this.guideEvaluationStatus, required this.dateOfRegistration}): super._();
  factory _CapstoneInfo.fromJson(Map<String, dynamic> json) => _$CapstoneInfoFromJson(json);

@override final  String title;
@override final  String guideEvaluationStatus;
@override final  String dateOfRegistration;

/// Create a copy of CapstoneInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapstoneInfoCopyWith<_CapstoneInfo> get copyWith => __$CapstoneInfoCopyWithImpl<_CapstoneInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CapstoneInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapstoneInfo&&(identical(other.title, title) || other.title == title)&&(identical(other.guideEvaluationStatus, guideEvaluationStatus) || other.guideEvaluationStatus == guideEvaluationStatus)&&(identical(other.dateOfRegistration, dateOfRegistration) || other.dateOfRegistration == dateOfRegistration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,guideEvaluationStatus,dateOfRegistration);

@override
String toString() {
  return 'CapstoneInfo(title: $title, guideEvaluationStatus: $guideEvaluationStatus, dateOfRegistration: $dateOfRegistration)';
}


}

/// @nodoc
abstract mixin class _$CapstoneInfoCopyWith<$Res> implements $CapstoneInfoCopyWith<$Res> {
  factory _$CapstoneInfoCopyWith(_CapstoneInfo value, $Res Function(_CapstoneInfo) _then) = __$CapstoneInfoCopyWithImpl;
@override @useResult
$Res call({
 String title, String guideEvaluationStatus, String dateOfRegistration
});




}
/// @nodoc
class __$CapstoneInfoCopyWithImpl<$Res>
    implements _$CapstoneInfoCopyWith<$Res> {
  __$CapstoneInfoCopyWithImpl(this._self, this._then);

  final _CapstoneInfo _self;
  final $Res Function(_CapstoneInfo) _then;

/// Create a copy of CapstoneInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? guideEvaluationStatus = null,Object? dateOfRegistration = null,}) {
  return _then(_CapstoneInfo(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,guideEvaluationStatus: null == guideEvaluationStatus ? _self.guideEvaluationStatus : guideEvaluationStatus // ignore: cast_nullable_to_non_nullable
as String,dateOfRegistration: null == dateOfRegistration ? _self.dateOfRegistration : dateOfRegistration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CapstonePunch {

 String get serial; String get date; String get day; String get dayType; String get status; String get punchTime;
/// Create a copy of CapstonePunch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapstonePunchCopyWith<CapstonePunch> get copyWith => _$CapstonePunchCopyWithImpl<CapstonePunch>(this as CapstonePunch, _$identity);

  /// Serializes this CapstonePunch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapstonePunch&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.date, date) || other.date == date)&&(identical(other.day, day) || other.day == day)&&(identical(other.dayType, dayType) || other.dayType == dayType)&&(identical(other.status, status) || other.status == status)&&(identical(other.punchTime, punchTime) || other.punchTime == punchTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serial,date,day,dayType,status,punchTime);

@override
String toString() {
  return 'CapstonePunch(serial: $serial, date: $date, day: $day, dayType: $dayType, status: $status, punchTime: $punchTime)';
}


}

/// @nodoc
abstract mixin class $CapstonePunchCopyWith<$Res>  {
  factory $CapstonePunchCopyWith(CapstonePunch value, $Res Function(CapstonePunch) _then) = _$CapstonePunchCopyWithImpl;
@useResult
$Res call({
 String serial, String date, String day, String dayType, String status, String punchTime
});




}
/// @nodoc
class _$CapstonePunchCopyWithImpl<$Res>
    implements $CapstonePunchCopyWith<$Res> {
  _$CapstonePunchCopyWithImpl(this._self, this._then);

  final CapstonePunch _self;
  final $Res Function(CapstonePunch) _then;

/// Create a copy of CapstonePunch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serial = null,Object? date = null,Object? day = null,Object? dayType = null,Object? status = null,Object? punchTime = null,}) {
  return _then(_self.copyWith(
serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,dayType: null == dayType ? _self.dayType : dayType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,punchTime: null == punchTime ? _self.punchTime : punchTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CapstonePunch].
extension CapstonePunchPatterns on CapstonePunch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapstonePunch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapstonePunch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapstonePunch value)  $default,){
final _that = this;
switch (_that) {
case _CapstonePunch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapstonePunch value)?  $default,){
final _that = this;
switch (_that) {
case _CapstonePunch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serial,  String date,  String day,  String dayType,  String status,  String punchTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapstonePunch() when $default != null:
return $default(_that.serial,_that.date,_that.day,_that.dayType,_that.status,_that.punchTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serial,  String date,  String day,  String dayType,  String status,  String punchTime)  $default,) {final _that = this;
switch (_that) {
case _CapstonePunch():
return $default(_that.serial,_that.date,_that.day,_that.dayType,_that.status,_that.punchTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serial,  String date,  String day,  String dayType,  String status,  String punchTime)?  $default,) {final _that = this;
switch (_that) {
case _CapstonePunch() when $default != null:
return $default(_that.serial,_that.date,_that.day,_that.dayType,_that.status,_that.punchTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CapstonePunch implements CapstonePunch {
  const _CapstonePunch({required this.serial, required this.date, required this.day, required this.dayType, required this.status, required this.punchTime});
  factory _CapstonePunch.fromJson(Map<String, dynamic> json) => _$CapstonePunchFromJson(json);

@override final  String serial;
@override final  String date;
@override final  String day;
@override final  String dayType;
@override final  String status;
@override final  String punchTime;

/// Create a copy of CapstonePunch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapstonePunchCopyWith<_CapstonePunch> get copyWith => __$CapstonePunchCopyWithImpl<_CapstonePunch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CapstonePunchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapstonePunch&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.date, date) || other.date == date)&&(identical(other.day, day) || other.day == day)&&(identical(other.dayType, dayType) || other.dayType == dayType)&&(identical(other.status, status) || other.status == status)&&(identical(other.punchTime, punchTime) || other.punchTime == punchTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serial,date,day,dayType,status,punchTime);

@override
String toString() {
  return 'CapstonePunch(serial: $serial, date: $date, day: $day, dayType: $dayType, status: $status, punchTime: $punchTime)';
}


}

/// @nodoc
abstract mixin class _$CapstonePunchCopyWith<$Res> implements $CapstonePunchCopyWith<$Res> {
  factory _$CapstonePunchCopyWith(_CapstonePunch value, $Res Function(_CapstonePunch) _then) = __$CapstonePunchCopyWithImpl;
@override @useResult
$Res call({
 String serial, String date, String day, String dayType, String status, String punchTime
});




}
/// @nodoc
class __$CapstonePunchCopyWithImpl<$Res>
    implements _$CapstonePunchCopyWith<$Res> {
  __$CapstonePunchCopyWithImpl(this._self, this._then);

  final _CapstonePunch _self;
  final $Res Function(_CapstonePunch) _then;

/// Create a copy of CapstonePunch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serial = null,Object? date = null,Object? day = null,Object? dayType = null,Object? status = null,Object? punchTime = null,}) {
  return _then(_CapstonePunch(
serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,dayType: null == dayType ? _self.dayType : dayType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,punchTime: null == punchTime ? _self.punchTime : punchTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CapstoneSummary {

 String get present; String get onDuty; String get absent; String get percentage;
/// Create a copy of CapstoneSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapstoneSummaryCopyWith<CapstoneSummary> get copyWith => _$CapstoneSummaryCopyWithImpl<CapstoneSummary>(this as CapstoneSummary, _$identity);

  /// Serializes this CapstoneSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapstoneSummary&&(identical(other.present, present) || other.present == present)&&(identical(other.onDuty, onDuty) || other.onDuty == onDuty)&&(identical(other.absent, absent) || other.absent == absent)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,present,onDuty,absent,percentage);

@override
String toString() {
  return 'CapstoneSummary(present: $present, onDuty: $onDuty, absent: $absent, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $CapstoneSummaryCopyWith<$Res>  {
  factory $CapstoneSummaryCopyWith(CapstoneSummary value, $Res Function(CapstoneSummary) _then) = _$CapstoneSummaryCopyWithImpl;
@useResult
$Res call({
 String present, String onDuty, String absent, String percentage
});




}
/// @nodoc
class _$CapstoneSummaryCopyWithImpl<$Res>
    implements $CapstoneSummaryCopyWith<$Res> {
  _$CapstoneSummaryCopyWithImpl(this._self, this._then);

  final CapstoneSummary _self;
  final $Res Function(CapstoneSummary) _then;

/// Create a copy of CapstoneSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? present = null,Object? onDuty = null,Object? absent = null,Object? percentage = null,}) {
  return _then(_self.copyWith(
present: null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as String,onDuty: null == onDuty ? _self.onDuty : onDuty // ignore: cast_nullable_to_non_nullable
as String,absent: null == absent ? _self.absent : absent // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CapstoneSummary].
extension CapstoneSummaryPatterns on CapstoneSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapstoneSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapstoneSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapstoneSummary value)  $default,){
final _that = this;
switch (_that) {
case _CapstoneSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapstoneSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CapstoneSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String present,  String onDuty,  String absent,  String percentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapstoneSummary() when $default != null:
return $default(_that.present,_that.onDuty,_that.absent,_that.percentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String present,  String onDuty,  String absent,  String percentage)  $default,) {final _that = this;
switch (_that) {
case _CapstoneSummary():
return $default(_that.present,_that.onDuty,_that.absent,_that.percentage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String present,  String onDuty,  String absent,  String percentage)?  $default,) {final _that = this;
switch (_that) {
case _CapstoneSummary() when $default != null:
return $default(_that.present,_that.onDuty,_that.absent,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CapstoneSummary extends CapstoneSummary {
  const _CapstoneSummary({required this.present, required this.onDuty, required this.absent, required this.percentage}): super._();
  factory _CapstoneSummary.fromJson(Map<String, dynamic> json) => _$CapstoneSummaryFromJson(json);

@override final  String present;
@override final  String onDuty;
@override final  String absent;
@override final  String percentage;

/// Create a copy of CapstoneSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapstoneSummaryCopyWith<_CapstoneSummary> get copyWith => __$CapstoneSummaryCopyWithImpl<_CapstoneSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CapstoneSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapstoneSummary&&(identical(other.present, present) || other.present == present)&&(identical(other.onDuty, onDuty) || other.onDuty == onDuty)&&(identical(other.absent, absent) || other.absent == absent)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,present,onDuty,absent,percentage);

@override
String toString() {
  return 'CapstoneSummary(present: $present, onDuty: $onDuty, absent: $absent, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$CapstoneSummaryCopyWith<$Res> implements $CapstoneSummaryCopyWith<$Res> {
  factory _$CapstoneSummaryCopyWith(_CapstoneSummary value, $Res Function(_CapstoneSummary) _then) = __$CapstoneSummaryCopyWithImpl;
@override @useResult
$Res call({
 String present, String onDuty, String absent, String percentage
});




}
/// @nodoc
class __$CapstoneSummaryCopyWithImpl<$Res>
    implements _$CapstoneSummaryCopyWith<$Res> {
  __$CapstoneSummaryCopyWithImpl(this._self, this._then);

  final _CapstoneSummary _self;
  final $Res Function(_CapstoneSummary) _then;

/// Create a copy of CapstoneSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? present = null,Object? onDuty = null,Object? absent = null,Object? percentage = null,}) {
  return _then(_CapstoneSummary(
present: null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as String,onDuty: null == onDuty ? _self.onDuty : onDuty // ignore: cast_nullable_to_non_nullable
as String,absent: null == absent ? _self.absent : absent // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
