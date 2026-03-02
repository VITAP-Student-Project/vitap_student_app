// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_course_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GradeCourseHistory {

 String get courseCode; String get courseTitle; String get courseType; String get credits; String get grade; String get examMonth; String get courseDistribution;
/// Create a copy of GradeCourseHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeCourseHistoryCopyWith<GradeCourseHistory> get copyWith => _$GradeCourseHistoryCopyWithImpl<GradeCourseHistory>(this as GradeCourseHistory, _$identity);

  /// Serializes this GradeCourseHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeCourseHistory&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.examMonth, examMonth) || other.examMonth == examMonth)&&(identical(other.courseDistribution, courseDistribution) || other.courseDistribution == courseDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseCode,courseTitle,courseType,credits,grade,examMonth,courseDistribution);

@override
String toString() {
  return 'GradeCourseHistory(courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, credits: $credits, grade: $grade, examMonth: $examMonth, courseDistribution: $courseDistribution)';
}


}

/// @nodoc
abstract mixin class $GradeCourseHistoryCopyWith<$Res>  {
  factory $GradeCourseHistoryCopyWith(GradeCourseHistory value, $Res Function(GradeCourseHistory) _then) = _$GradeCourseHistoryCopyWithImpl;
@useResult
$Res call({
 String courseCode, String courseTitle, String courseType, String credits, String grade, String examMonth, String courseDistribution
});




}
/// @nodoc
class _$GradeCourseHistoryCopyWithImpl<$Res>
    implements $GradeCourseHistoryCopyWith<$Res> {
  _$GradeCourseHistoryCopyWithImpl(this._self, this._then);

  final GradeCourseHistory _self;
  final $Res Function(GradeCourseHistory) _then;

/// Create a copy of GradeCourseHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseCode = null,Object? courseTitle = null,Object? courseType = null,Object? credits = null,Object? grade = null,Object? examMonth = null,Object? courseDistribution = null,}) {
  return _then(_self.copyWith(
courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String,courseType: null == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,examMonth: null == examMonth ? _self.examMonth : examMonth // ignore: cast_nullable_to_non_nullable
as String,courseDistribution: null == courseDistribution ? _self.courseDistribution : courseDistribution // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeCourseHistory].
extension GradeCourseHistoryPatterns on GradeCourseHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeCourseHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeCourseHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeCourseHistory value)  $default,){
final _that = this;
switch (_that) {
case _GradeCourseHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeCourseHistory value)?  $default,){
final _that = this;
switch (_that) {
case _GradeCourseHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseCode,  String courseTitle,  String courseType,  String credits,  String grade,  String examMonth,  String courseDistribution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeCourseHistory() when $default != null:
return $default(_that.courseCode,_that.courseTitle,_that.courseType,_that.credits,_that.grade,_that.examMonth,_that.courseDistribution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseCode,  String courseTitle,  String courseType,  String credits,  String grade,  String examMonth,  String courseDistribution)  $default,) {final _that = this;
switch (_that) {
case _GradeCourseHistory():
return $default(_that.courseCode,_that.courseTitle,_that.courseType,_that.credits,_that.grade,_that.examMonth,_that.courseDistribution);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseCode,  String courseTitle,  String courseType,  String credits,  String grade,  String examMonth,  String courseDistribution)?  $default,) {final _that = this;
switch (_that) {
case _GradeCourseHistory() when $default != null:
return $default(_that.courseCode,_that.courseTitle,_that.courseType,_that.credits,_that.grade,_that.examMonth,_that.courseDistribution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeCourseHistory implements GradeCourseHistory {
  const _GradeCourseHistory({required this.courseCode, required this.courseTitle, required this.courseType, required this.credits, required this.grade, required this.examMonth, required this.courseDistribution});
  factory _GradeCourseHistory.fromJson(Map<String, dynamic> json) => _$GradeCourseHistoryFromJson(json);

@override final  String courseCode;
@override final  String courseTitle;
@override final  String courseType;
@override final  String credits;
@override final  String grade;
@override final  String examMonth;
@override final  String courseDistribution;

/// Create a copy of GradeCourseHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeCourseHistoryCopyWith<_GradeCourseHistory> get copyWith => __$GradeCourseHistoryCopyWithImpl<_GradeCourseHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeCourseHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeCourseHistory&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.examMonth, examMonth) || other.examMonth == examMonth)&&(identical(other.courseDistribution, courseDistribution) || other.courseDistribution == courseDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseCode,courseTitle,courseType,credits,grade,examMonth,courseDistribution);

@override
String toString() {
  return 'GradeCourseHistory(courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, credits: $credits, grade: $grade, examMonth: $examMonth, courseDistribution: $courseDistribution)';
}


}

/// @nodoc
abstract mixin class _$GradeCourseHistoryCopyWith<$Res> implements $GradeCourseHistoryCopyWith<$Res> {
  factory _$GradeCourseHistoryCopyWith(_GradeCourseHistory value, $Res Function(_GradeCourseHistory) _then) = __$GradeCourseHistoryCopyWithImpl;
@override @useResult
$Res call({
 String courseCode, String courseTitle, String courseType, String credits, String grade, String examMonth, String courseDistribution
});




}
/// @nodoc
class __$GradeCourseHistoryCopyWithImpl<$Res>
    implements _$GradeCourseHistoryCopyWith<$Res> {
  __$GradeCourseHistoryCopyWithImpl(this._self, this._then);

  final _GradeCourseHistory _self;
  final $Res Function(_GradeCourseHistory) _then;

/// Create a copy of GradeCourseHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseCode = null,Object? courseTitle = null,Object? courseType = null,Object? credits = null,Object? grade = null,Object? examMonth = null,Object? courseDistribution = null,}) {
  return _then(_GradeCourseHistory(
courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String,courseType: null == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,examMonth: null == examMonth ? _self.examMonth : examMonth // ignore: cast_nullable_to_non_nullable
as String,courseDistribution: null == courseDistribution ? _self.courseDistribution : courseDistribution // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
