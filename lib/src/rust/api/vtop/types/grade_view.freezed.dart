// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GradeRange {

 String get grade; String get range;
/// Create a copy of GradeRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeRangeCopyWith<GradeRange> get copyWith => _$GradeRangeCopyWithImpl<GradeRange>(this as GradeRange, _$identity);

  /// Serializes this GradeRange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeRange&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.range, range) || other.range == range));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grade,range);

@override
String toString() {
  return 'GradeRange(grade: $grade, range: $range)';
}


}

/// @nodoc
abstract mixin class $GradeRangeCopyWith<$Res>  {
  factory $GradeRangeCopyWith(GradeRange value, $Res Function(GradeRange) _then) = _$GradeRangeCopyWithImpl;
@useResult
$Res call({
 String grade, String range
});




}
/// @nodoc
class _$GradeRangeCopyWithImpl<$Res>
    implements $GradeRangeCopyWith<$Res> {
  _$GradeRangeCopyWithImpl(this._self, this._then);

  final GradeRange _self;
  final $Res Function(GradeRange) _then;

/// Create a copy of GradeRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grade = null,Object? range = null,}) {
  return _then(_self.copyWith(
grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeRange].
extension GradeRangePatterns on GradeRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeRange value)  $default,){
final _that = this;
switch (_that) {
case _GradeRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeRange value)?  $default,){
final _that = this;
switch (_that) {
case _GradeRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String grade,  String range)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeRange() when $default != null:
return $default(_that.grade,_that.range);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String grade,  String range)  $default,) {final _that = this;
switch (_that) {
case _GradeRange():
return $default(_that.grade,_that.range);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String grade,  String range)?  $default,) {final _that = this;
switch (_that) {
case _GradeRange() when $default != null:
return $default(_that.grade,_that.range);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeRange implements GradeRange {
  const _GradeRange({required this.grade, required this.range});
  factory _GradeRange.fromJson(Map<String, dynamic> json) => _$GradeRangeFromJson(json);

@override final  String grade;
@override final  String range;

/// Create a copy of GradeRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeRangeCopyWith<_GradeRange> get copyWith => __$GradeRangeCopyWithImpl<_GradeRange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeRangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeRange&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.range, range) || other.range == range));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grade,range);

@override
String toString() {
  return 'GradeRange(grade: $grade, range: $range)';
}


}

/// @nodoc
abstract mixin class _$GradeRangeCopyWith<$Res> implements $GradeRangeCopyWith<$Res> {
  factory _$GradeRangeCopyWith(_GradeRange value, $Res Function(_GradeRange) _then) = __$GradeRangeCopyWithImpl;
@override @useResult
$Res call({
 String grade, String range
});




}
/// @nodoc
class __$GradeRangeCopyWithImpl<$Res>
    implements _$GradeRangeCopyWith<$Res> {
  __$GradeRangeCopyWithImpl(this._self, this._then);

  final _GradeRange _self;
  final $Res Function(_GradeRange) _then;

/// Create a copy of GradeRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grade = null,Object? range = null,}) {
  return _then(_GradeRange(
grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GradeStatistics {

 String get classStrength; String get gradingStrength; String get mean; String get sd; List<GradeRange> get gradeRanges;
/// Create a copy of GradeStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeStatisticsCopyWith<GradeStatistics> get copyWith => _$GradeStatisticsCopyWithImpl<GradeStatistics>(this as GradeStatistics, _$identity);

  /// Serializes this GradeStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeStatistics&&(identical(other.classStrength, classStrength) || other.classStrength == classStrength)&&(identical(other.gradingStrength, gradingStrength) || other.gradingStrength == gradingStrength)&&(identical(other.mean, mean) || other.mean == mean)&&(identical(other.sd, sd) || other.sd == sd)&&const DeepCollectionEquality().equals(other.gradeRanges, gradeRanges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classStrength,gradingStrength,mean,sd,const DeepCollectionEquality().hash(gradeRanges));

@override
String toString() {
  return 'GradeStatistics(classStrength: $classStrength, gradingStrength: $gradingStrength, mean: $mean, sd: $sd, gradeRanges: $gradeRanges)';
}


}

/// @nodoc
abstract mixin class $GradeStatisticsCopyWith<$Res>  {
  factory $GradeStatisticsCopyWith(GradeStatistics value, $Res Function(GradeStatistics) _then) = _$GradeStatisticsCopyWithImpl;
@useResult
$Res call({
 String classStrength, String gradingStrength, String mean, String sd, List<GradeRange> gradeRanges
});




}
/// @nodoc
class _$GradeStatisticsCopyWithImpl<$Res>
    implements $GradeStatisticsCopyWith<$Res> {
  _$GradeStatisticsCopyWithImpl(this._self, this._then);

  final GradeStatistics _self;
  final $Res Function(GradeStatistics) _then;

/// Create a copy of GradeStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classStrength = null,Object? gradingStrength = null,Object? mean = null,Object? sd = null,Object? gradeRanges = null,}) {
  return _then(_self.copyWith(
classStrength: null == classStrength ? _self.classStrength : classStrength // ignore: cast_nullable_to_non_nullable
as String,gradingStrength: null == gradingStrength ? _self.gradingStrength : gradingStrength // ignore: cast_nullable_to_non_nullable
as String,mean: null == mean ? _self.mean : mean // ignore: cast_nullable_to_non_nullable
as String,sd: null == sd ? _self.sd : sd // ignore: cast_nullable_to_non_nullable
as String,gradeRanges: null == gradeRanges ? _self.gradeRanges : gradeRanges // ignore: cast_nullable_to_non_nullable
as List<GradeRange>,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeStatistics].
extension GradeStatisticsPatterns on GradeStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeStatistics value)  $default,){
final _that = this;
switch (_that) {
case _GradeStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _GradeStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String classStrength,  String gradingStrength,  String mean,  String sd,  List<GradeRange> gradeRanges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeStatistics() when $default != null:
return $default(_that.classStrength,_that.gradingStrength,_that.mean,_that.sd,_that.gradeRanges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String classStrength,  String gradingStrength,  String mean,  String sd,  List<GradeRange> gradeRanges)  $default,) {final _that = this;
switch (_that) {
case _GradeStatistics():
return $default(_that.classStrength,_that.gradingStrength,_that.mean,_that.sd,_that.gradeRanges);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String classStrength,  String gradingStrength,  String mean,  String sd,  List<GradeRange> gradeRanges)?  $default,) {final _that = this;
switch (_that) {
case _GradeStatistics() when $default != null:
return $default(_that.classStrength,_that.gradingStrength,_that.mean,_that.sd,_that.gradeRanges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeStatistics implements GradeStatistics {
  const _GradeStatistics({required this.classStrength, required this.gradingStrength, required this.mean, required this.sd, required final  List<GradeRange> gradeRanges}): _gradeRanges = gradeRanges;
  factory _GradeStatistics.fromJson(Map<String, dynamic> json) => _$GradeStatisticsFromJson(json);

@override final  String classStrength;
@override final  String gradingStrength;
@override final  String mean;
@override final  String sd;
 final  List<GradeRange> _gradeRanges;
@override List<GradeRange> get gradeRanges {
  if (_gradeRanges is EqualUnmodifiableListView) return _gradeRanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gradeRanges);
}


/// Create a copy of GradeStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeStatisticsCopyWith<_GradeStatistics> get copyWith => __$GradeStatisticsCopyWithImpl<_GradeStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeStatistics&&(identical(other.classStrength, classStrength) || other.classStrength == classStrength)&&(identical(other.gradingStrength, gradingStrength) || other.gradingStrength == gradingStrength)&&(identical(other.mean, mean) || other.mean == mean)&&(identical(other.sd, sd) || other.sd == sd)&&const DeepCollectionEquality().equals(other._gradeRanges, _gradeRanges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classStrength,gradingStrength,mean,sd,const DeepCollectionEquality().hash(_gradeRanges));

@override
String toString() {
  return 'GradeStatistics(classStrength: $classStrength, gradingStrength: $gradingStrength, mean: $mean, sd: $sd, gradeRanges: $gradeRanges)';
}


}

/// @nodoc
abstract mixin class _$GradeStatisticsCopyWith<$Res> implements $GradeStatisticsCopyWith<$Res> {
  factory _$GradeStatisticsCopyWith(_GradeStatistics value, $Res Function(_GradeStatistics) _then) = __$GradeStatisticsCopyWithImpl;
@override @useResult
$Res call({
 String classStrength, String gradingStrength, String mean, String sd, List<GradeRange> gradeRanges
});




}
/// @nodoc
class __$GradeStatisticsCopyWithImpl<$Res>
    implements _$GradeStatisticsCopyWith<$Res> {
  __$GradeStatisticsCopyWithImpl(this._self, this._then);

  final _GradeStatistics _self;
  final $Res Function(_GradeStatistics) _then;

/// Create a copy of GradeStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classStrength = null,Object? gradingStrength = null,Object? mean = null,Object? sd = null,Object? gradeRanges = null,}) {
  return _then(_GradeStatistics(
classStrength: null == classStrength ? _self.classStrength : classStrength // ignore: cast_nullable_to_non_nullable
as String,gradingStrength: null == gradingStrength ? _self.gradingStrength : gradingStrength // ignore: cast_nullable_to_non_nullable
as String,mean: null == mean ? _self.mean : mean // ignore: cast_nullable_to_non_nullable
as String,sd: null == sd ? _self.sd : sd // ignore: cast_nullable_to_non_nullable
as String,gradeRanges: null == gradeRanges ? _self._gradeRanges : gradeRanges // ignore: cast_nullable_to_non_nullable
as List<GradeRange>,
  ));
}


}


/// @nodoc
mixin _$GradeViewCourse {

 String get serialNumber; String get courseCode; String get courseTitle; String get courseType; String get gradingType; String get grandTotal; String get grade; String get courseId;
/// Create a copy of GradeViewCourse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeViewCourseCopyWith<GradeViewCourse> get copyWith => _$GradeViewCourseCopyWithImpl<GradeViewCourse>(this as GradeViewCourse, _$identity);

  /// Serializes this GradeViewCourse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeViewCourse&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&(identical(other.gradingType, gradingType) || other.gradingType == gradingType)&&(identical(other.grandTotal, grandTotal) || other.grandTotal == grandTotal)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.courseId, courseId) || other.courseId == courseId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serialNumber,courseCode,courseTitle,courseType,gradingType,grandTotal,grade,courseId);

@override
String toString() {
  return 'GradeViewCourse(serialNumber: $serialNumber, courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, gradingType: $gradingType, grandTotal: $grandTotal, grade: $grade, courseId: $courseId)';
}


}

/// @nodoc
abstract mixin class $GradeViewCourseCopyWith<$Res>  {
  factory $GradeViewCourseCopyWith(GradeViewCourse value, $Res Function(GradeViewCourse) _then) = _$GradeViewCourseCopyWithImpl;
@useResult
$Res call({
 String serialNumber, String courseCode, String courseTitle, String courseType, String gradingType, String grandTotal, String grade, String courseId
});




}
/// @nodoc
class _$GradeViewCourseCopyWithImpl<$Res>
    implements $GradeViewCourseCopyWith<$Res> {
  _$GradeViewCourseCopyWithImpl(this._self, this._then);

  final GradeViewCourse _self;
  final $Res Function(GradeViewCourse) _then;

/// Create a copy of GradeViewCourse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serialNumber = null,Object? courseCode = null,Object? courseTitle = null,Object? courseType = null,Object? gradingType = null,Object? grandTotal = null,Object? grade = null,Object? courseId = null,}) {
  return _then(_self.copyWith(
serialNumber: null == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String,courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String,courseType: null == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String,gradingType: null == gradingType ? _self.gradingType : gradingType // ignore: cast_nullable_to_non_nullable
as String,grandTotal: null == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeViewCourse].
extension GradeViewCoursePatterns on GradeViewCourse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeViewCourse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeViewCourse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeViewCourse value)  $default,){
final _that = this;
switch (_that) {
case _GradeViewCourse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeViewCourse value)?  $default,){
final _that = this;
switch (_that) {
case _GradeViewCourse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serialNumber,  String courseCode,  String courseTitle,  String courseType,  String gradingType,  String grandTotal,  String grade,  String courseId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeViewCourse() when $default != null:
return $default(_that.serialNumber,_that.courseCode,_that.courseTitle,_that.courseType,_that.gradingType,_that.grandTotal,_that.grade,_that.courseId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serialNumber,  String courseCode,  String courseTitle,  String courseType,  String gradingType,  String grandTotal,  String grade,  String courseId)  $default,) {final _that = this;
switch (_that) {
case _GradeViewCourse():
return $default(_that.serialNumber,_that.courseCode,_that.courseTitle,_that.courseType,_that.gradingType,_that.grandTotal,_that.grade,_that.courseId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serialNumber,  String courseCode,  String courseTitle,  String courseType,  String gradingType,  String grandTotal,  String grade,  String courseId)?  $default,) {final _that = this;
switch (_that) {
case _GradeViewCourse() when $default != null:
return $default(_that.serialNumber,_that.courseCode,_that.courseTitle,_that.courseType,_that.gradingType,_that.grandTotal,_that.grade,_that.courseId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeViewCourse implements GradeViewCourse {
  const _GradeViewCourse({required this.serialNumber, required this.courseCode, required this.courseTitle, required this.courseType, required this.gradingType, required this.grandTotal, required this.grade, required this.courseId});
  factory _GradeViewCourse.fromJson(Map<String, dynamic> json) => _$GradeViewCourseFromJson(json);

@override final  String serialNumber;
@override final  String courseCode;
@override final  String courseTitle;
@override final  String courseType;
@override final  String gradingType;
@override final  String grandTotal;
@override final  String grade;
@override final  String courseId;

/// Create a copy of GradeViewCourse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeViewCourseCopyWith<_GradeViewCourse> get copyWith => __$GradeViewCourseCopyWithImpl<_GradeViewCourse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeViewCourseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeViewCourse&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&(identical(other.gradingType, gradingType) || other.gradingType == gradingType)&&(identical(other.grandTotal, grandTotal) || other.grandTotal == grandTotal)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.courseId, courseId) || other.courseId == courseId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serialNumber,courseCode,courseTitle,courseType,gradingType,grandTotal,grade,courseId);

@override
String toString() {
  return 'GradeViewCourse(serialNumber: $serialNumber, courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, gradingType: $gradingType, grandTotal: $grandTotal, grade: $grade, courseId: $courseId)';
}


}

/// @nodoc
abstract mixin class _$GradeViewCourseCopyWith<$Res> implements $GradeViewCourseCopyWith<$Res> {
  factory _$GradeViewCourseCopyWith(_GradeViewCourse value, $Res Function(_GradeViewCourse) _then) = __$GradeViewCourseCopyWithImpl;
@override @useResult
$Res call({
 String serialNumber, String courseCode, String courseTitle, String courseType, String gradingType, String grandTotal, String grade, String courseId
});




}
/// @nodoc
class __$GradeViewCourseCopyWithImpl<$Res>
    implements _$GradeViewCourseCopyWith<$Res> {
  __$GradeViewCourseCopyWithImpl(this._self, this._then);

  final _GradeViewCourse _self;
  final $Res Function(_GradeViewCourse) _then;

/// Create a copy of GradeViewCourse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serialNumber = null,Object? courseCode = null,Object? courseTitle = null,Object? courseType = null,Object? gradingType = null,Object? grandTotal = null,Object? grade = null,Object? courseId = null,}) {
  return _then(_GradeViewCourse(
serialNumber: null == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String,courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String,courseType: null == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String,gradingType: null == gradingType ? _self.gradingType : gradingType // ignore: cast_nullable_to_non_nullable
as String,grandTotal: null == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GradeViewDetail {

 String get classNumber; String get courseType; List<MarkComponent> get marks; String get total; GradeStatistics get statistics;
/// Create a copy of GradeViewDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeViewDetailCopyWith<GradeViewDetail> get copyWith => _$GradeViewDetailCopyWithImpl<GradeViewDetail>(this as GradeViewDetail, _$identity);

  /// Serializes this GradeViewDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeViewDetail&&(identical(other.classNumber, classNumber) || other.classNumber == classNumber)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&const DeepCollectionEquality().equals(other.marks, marks)&&(identical(other.total, total) || other.total == total)&&(identical(other.statistics, statistics) || other.statistics == statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classNumber,courseType,const DeepCollectionEquality().hash(marks),total,statistics);

@override
String toString() {
  return 'GradeViewDetail(classNumber: $classNumber, courseType: $courseType, marks: $marks, total: $total, statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class $GradeViewDetailCopyWith<$Res>  {
  factory $GradeViewDetailCopyWith(GradeViewDetail value, $Res Function(GradeViewDetail) _then) = _$GradeViewDetailCopyWithImpl;
@useResult
$Res call({
 String classNumber, String courseType, List<MarkComponent> marks, String total, GradeStatistics statistics
});


$GradeStatisticsCopyWith<$Res> get statistics;

}
/// @nodoc
class _$GradeViewDetailCopyWithImpl<$Res>
    implements $GradeViewDetailCopyWith<$Res> {
  _$GradeViewDetailCopyWithImpl(this._self, this._then);

  final GradeViewDetail _self;
  final $Res Function(GradeViewDetail) _then;

/// Create a copy of GradeViewDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classNumber = null,Object? courseType = null,Object? marks = null,Object? total = null,Object? statistics = null,}) {
  return _then(_self.copyWith(
classNumber: null == classNumber ? _self.classNumber : classNumber // ignore: cast_nullable_to_non_nullable
as String,courseType: null == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String,marks: null == marks ? _self.marks : marks // ignore: cast_nullable_to_non_nullable
as List<MarkComponent>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as GradeStatistics,
  ));
}
/// Create a copy of GradeViewDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradeStatisticsCopyWith<$Res> get statistics {
  
  return $GradeStatisticsCopyWith<$Res>(_self.statistics, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}
}


/// Adds pattern-matching-related methods to [GradeViewDetail].
extension GradeViewDetailPatterns on GradeViewDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeViewDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeViewDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeViewDetail value)  $default,){
final _that = this;
switch (_that) {
case _GradeViewDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeViewDetail value)?  $default,){
final _that = this;
switch (_that) {
case _GradeViewDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String classNumber,  String courseType,  List<MarkComponent> marks,  String total,  GradeStatistics statistics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeViewDetail() when $default != null:
return $default(_that.classNumber,_that.courseType,_that.marks,_that.total,_that.statistics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String classNumber,  String courseType,  List<MarkComponent> marks,  String total,  GradeStatistics statistics)  $default,) {final _that = this;
switch (_that) {
case _GradeViewDetail():
return $default(_that.classNumber,_that.courseType,_that.marks,_that.total,_that.statistics);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String classNumber,  String courseType,  List<MarkComponent> marks,  String total,  GradeStatistics statistics)?  $default,) {final _that = this;
switch (_that) {
case _GradeViewDetail() when $default != null:
return $default(_that.classNumber,_that.courseType,_that.marks,_that.total,_that.statistics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeViewDetail implements GradeViewDetail {
  const _GradeViewDetail({required this.classNumber, required this.courseType, required final  List<MarkComponent> marks, required this.total, required this.statistics}): _marks = marks;
  factory _GradeViewDetail.fromJson(Map<String, dynamic> json) => _$GradeViewDetailFromJson(json);

@override final  String classNumber;
@override final  String courseType;
 final  List<MarkComponent> _marks;
@override List<MarkComponent> get marks {
  if (_marks is EqualUnmodifiableListView) return _marks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marks);
}

@override final  String total;
@override final  GradeStatistics statistics;

/// Create a copy of GradeViewDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeViewDetailCopyWith<_GradeViewDetail> get copyWith => __$GradeViewDetailCopyWithImpl<_GradeViewDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeViewDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeViewDetail&&(identical(other.classNumber, classNumber) || other.classNumber == classNumber)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&const DeepCollectionEquality().equals(other._marks, _marks)&&(identical(other.total, total) || other.total == total)&&(identical(other.statistics, statistics) || other.statistics == statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classNumber,courseType,const DeepCollectionEquality().hash(_marks),total,statistics);

@override
String toString() {
  return 'GradeViewDetail(classNumber: $classNumber, courseType: $courseType, marks: $marks, total: $total, statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class _$GradeViewDetailCopyWith<$Res> implements $GradeViewDetailCopyWith<$Res> {
  factory _$GradeViewDetailCopyWith(_GradeViewDetail value, $Res Function(_GradeViewDetail) _then) = __$GradeViewDetailCopyWithImpl;
@override @useResult
$Res call({
 String classNumber, String courseType, List<MarkComponent> marks, String total, GradeStatistics statistics
});


@override $GradeStatisticsCopyWith<$Res> get statistics;

}
/// @nodoc
class __$GradeViewDetailCopyWithImpl<$Res>
    implements _$GradeViewDetailCopyWith<$Res> {
  __$GradeViewDetailCopyWithImpl(this._self, this._then);

  final _GradeViewDetail _self;
  final $Res Function(_GradeViewDetail) _then;

/// Create a copy of GradeViewDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classNumber = null,Object? courseType = null,Object? marks = null,Object? total = null,Object? statistics = null,}) {
  return _then(_GradeViewDetail(
classNumber: null == classNumber ? _self.classNumber : classNumber // ignore: cast_nullable_to_non_nullable
as String,courseType: null == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String,marks: null == marks ? _self._marks : marks // ignore: cast_nullable_to_non_nullable
as List<MarkComponent>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as GradeStatistics,
  ));
}

/// Create a copy of GradeViewDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradeStatisticsCopyWith<$Res> get statistics {
  
  return $GradeStatisticsCopyWith<$Res>(_self.statistics, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}
}


/// @nodoc
mixin _$MarkComponent {

 String get serialNumber; String get markTitle; String get maxMark; String get weightage; String get status; String get scoredMark; String get weightageMark;
/// Create a copy of MarkComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkComponentCopyWith<MarkComponent> get copyWith => _$MarkComponentCopyWithImpl<MarkComponent>(this as MarkComponent, _$identity);

  /// Serializes this MarkComponent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkComponent&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.markTitle, markTitle) || other.markTitle == markTitle)&&(identical(other.maxMark, maxMark) || other.maxMark == maxMark)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.status, status) || other.status == status)&&(identical(other.scoredMark, scoredMark) || other.scoredMark == scoredMark)&&(identical(other.weightageMark, weightageMark) || other.weightageMark == weightageMark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serialNumber,markTitle,maxMark,weightage,status,scoredMark,weightageMark);

@override
String toString() {
  return 'MarkComponent(serialNumber: $serialNumber, markTitle: $markTitle, maxMark: $maxMark, weightage: $weightage, status: $status, scoredMark: $scoredMark, weightageMark: $weightageMark)';
}


}

/// @nodoc
abstract mixin class $MarkComponentCopyWith<$Res>  {
  factory $MarkComponentCopyWith(MarkComponent value, $Res Function(MarkComponent) _then) = _$MarkComponentCopyWithImpl;
@useResult
$Res call({
 String serialNumber, String markTitle, String maxMark, String weightage, String status, String scoredMark, String weightageMark
});




}
/// @nodoc
class _$MarkComponentCopyWithImpl<$Res>
    implements $MarkComponentCopyWith<$Res> {
  _$MarkComponentCopyWithImpl(this._self, this._then);

  final MarkComponent _self;
  final $Res Function(MarkComponent) _then;

/// Create a copy of MarkComponent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serialNumber = null,Object? markTitle = null,Object? maxMark = null,Object? weightage = null,Object? status = null,Object? scoredMark = null,Object? weightageMark = null,}) {
  return _then(_self.copyWith(
serialNumber: null == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String,markTitle: null == markTitle ? _self.markTitle : markTitle // ignore: cast_nullable_to_non_nullable
as String,maxMark: null == maxMark ? _self.maxMark : maxMark // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,scoredMark: null == scoredMark ? _self.scoredMark : scoredMark // ignore: cast_nullable_to_non_nullable
as String,weightageMark: null == weightageMark ? _self.weightageMark : weightageMark // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkComponent].
extension MarkComponentPatterns on MarkComponent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkComponent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkComponent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkComponent value)  $default,){
final _that = this;
switch (_that) {
case _MarkComponent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkComponent value)?  $default,){
final _that = this;
switch (_that) {
case _MarkComponent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serialNumber,  String markTitle,  String maxMark,  String weightage,  String status,  String scoredMark,  String weightageMark)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkComponent() when $default != null:
return $default(_that.serialNumber,_that.markTitle,_that.maxMark,_that.weightage,_that.status,_that.scoredMark,_that.weightageMark);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serialNumber,  String markTitle,  String maxMark,  String weightage,  String status,  String scoredMark,  String weightageMark)  $default,) {final _that = this;
switch (_that) {
case _MarkComponent():
return $default(_that.serialNumber,_that.markTitle,_that.maxMark,_that.weightage,_that.status,_that.scoredMark,_that.weightageMark);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serialNumber,  String markTitle,  String maxMark,  String weightage,  String status,  String scoredMark,  String weightageMark)?  $default,) {final _that = this;
switch (_that) {
case _MarkComponent() when $default != null:
return $default(_that.serialNumber,_that.markTitle,_that.maxMark,_that.weightage,_that.status,_that.scoredMark,_that.weightageMark);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkComponent implements MarkComponent {
  const _MarkComponent({required this.serialNumber, required this.markTitle, required this.maxMark, required this.weightage, required this.status, required this.scoredMark, required this.weightageMark});
  factory _MarkComponent.fromJson(Map<String, dynamic> json) => _$MarkComponentFromJson(json);

@override final  String serialNumber;
@override final  String markTitle;
@override final  String maxMark;
@override final  String weightage;
@override final  String status;
@override final  String scoredMark;
@override final  String weightageMark;

/// Create a copy of MarkComponent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkComponentCopyWith<_MarkComponent> get copyWith => __$MarkComponentCopyWithImpl<_MarkComponent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkComponentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkComponent&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.markTitle, markTitle) || other.markTitle == markTitle)&&(identical(other.maxMark, maxMark) || other.maxMark == maxMark)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.status, status) || other.status == status)&&(identical(other.scoredMark, scoredMark) || other.scoredMark == scoredMark)&&(identical(other.weightageMark, weightageMark) || other.weightageMark == weightageMark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serialNumber,markTitle,maxMark,weightage,status,scoredMark,weightageMark);

@override
String toString() {
  return 'MarkComponent(serialNumber: $serialNumber, markTitle: $markTitle, maxMark: $maxMark, weightage: $weightage, status: $status, scoredMark: $scoredMark, weightageMark: $weightageMark)';
}


}

/// @nodoc
abstract mixin class _$MarkComponentCopyWith<$Res> implements $MarkComponentCopyWith<$Res> {
  factory _$MarkComponentCopyWith(_MarkComponent value, $Res Function(_MarkComponent) _then) = __$MarkComponentCopyWithImpl;
@override @useResult
$Res call({
 String serialNumber, String markTitle, String maxMark, String weightage, String status, String scoredMark, String weightageMark
});




}
/// @nodoc
class __$MarkComponentCopyWithImpl<$Res>
    implements _$MarkComponentCopyWith<$Res> {
  __$MarkComponentCopyWithImpl(this._self, this._then);

  final _MarkComponent _self;
  final $Res Function(_MarkComponent) _then;

/// Create a copy of MarkComponent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serialNumber = null,Object? markTitle = null,Object? maxMark = null,Object? weightage = null,Object? status = null,Object? scoredMark = null,Object? weightageMark = null,}) {
  return _then(_MarkComponent(
serialNumber: null == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String,markTitle: null == markTitle ? _self.markTitle : markTitle // ignore: cast_nullable_to_non_nullable
as String,maxMark: null == maxMark ? _self.maxMark : maxMark // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,scoredMark: null == scoredMark ? _self.scoredMark : scoredMark // ignore: cast_nullable_to_non_nullable
as String,weightageMark: null == weightageMark ? _self.weightageMark : weightageMark // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
