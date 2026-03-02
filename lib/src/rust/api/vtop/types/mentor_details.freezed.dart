// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MentorDetails {

 String get facultyId; String get facultyName; String get facultyDesignation; String get school; String get cabin; String get facultyDepartment; String get facultyEmail; String get facultyIntercom; String get facultyMobileNumber;
/// Create a copy of MentorDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorDetailsCopyWith<MentorDetails> get copyWith => _$MentorDetailsCopyWithImpl<MentorDetails>(this as MentorDetails, _$identity);

  /// Serializes this MentorDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorDetails&&(identical(other.facultyId, facultyId) || other.facultyId == facultyId)&&(identical(other.facultyName, facultyName) || other.facultyName == facultyName)&&(identical(other.facultyDesignation, facultyDesignation) || other.facultyDesignation == facultyDesignation)&&(identical(other.school, school) || other.school == school)&&(identical(other.cabin, cabin) || other.cabin == cabin)&&(identical(other.facultyDepartment, facultyDepartment) || other.facultyDepartment == facultyDepartment)&&(identical(other.facultyEmail, facultyEmail) || other.facultyEmail == facultyEmail)&&(identical(other.facultyIntercom, facultyIntercom) || other.facultyIntercom == facultyIntercom)&&(identical(other.facultyMobileNumber, facultyMobileNumber) || other.facultyMobileNumber == facultyMobileNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,facultyId,facultyName,facultyDesignation,school,cabin,facultyDepartment,facultyEmail,facultyIntercom,facultyMobileNumber);

@override
String toString() {
  return 'MentorDetails(facultyId: $facultyId, facultyName: $facultyName, facultyDesignation: $facultyDesignation, school: $school, cabin: $cabin, facultyDepartment: $facultyDepartment, facultyEmail: $facultyEmail, facultyIntercom: $facultyIntercom, facultyMobileNumber: $facultyMobileNumber)';
}


}

/// @nodoc
abstract mixin class $MentorDetailsCopyWith<$Res>  {
  factory $MentorDetailsCopyWith(MentorDetails value, $Res Function(MentorDetails) _then) = _$MentorDetailsCopyWithImpl;
@useResult
$Res call({
 String facultyId, String facultyName, String facultyDesignation, String school, String cabin, String facultyDepartment, String facultyEmail, String facultyIntercom, String facultyMobileNumber
});




}
/// @nodoc
class _$MentorDetailsCopyWithImpl<$Res>
    implements $MentorDetailsCopyWith<$Res> {
  _$MentorDetailsCopyWithImpl(this._self, this._then);

  final MentorDetails _self;
  final $Res Function(MentorDetails) _then;

/// Create a copy of MentorDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? facultyId = null,Object? facultyName = null,Object? facultyDesignation = null,Object? school = null,Object? cabin = null,Object? facultyDepartment = null,Object? facultyEmail = null,Object? facultyIntercom = null,Object? facultyMobileNumber = null,}) {
  return _then(_self.copyWith(
facultyId: null == facultyId ? _self.facultyId : facultyId // ignore: cast_nullable_to_non_nullable
as String,facultyName: null == facultyName ? _self.facultyName : facultyName // ignore: cast_nullable_to_non_nullable
as String,facultyDesignation: null == facultyDesignation ? _self.facultyDesignation : facultyDesignation // ignore: cast_nullable_to_non_nullable
as String,school: null == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String,cabin: null == cabin ? _self.cabin : cabin // ignore: cast_nullable_to_non_nullable
as String,facultyDepartment: null == facultyDepartment ? _self.facultyDepartment : facultyDepartment // ignore: cast_nullable_to_non_nullable
as String,facultyEmail: null == facultyEmail ? _self.facultyEmail : facultyEmail // ignore: cast_nullable_to_non_nullable
as String,facultyIntercom: null == facultyIntercom ? _self.facultyIntercom : facultyIntercom // ignore: cast_nullable_to_non_nullable
as String,facultyMobileNumber: null == facultyMobileNumber ? _self.facultyMobileNumber : facultyMobileNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorDetails].
extension MentorDetailsPatterns on MentorDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorDetails value)  $default,){
final _that = this;
switch (_that) {
case _MentorDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorDetails value)?  $default,){
final _that = this;
switch (_that) {
case _MentorDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String facultyId,  String facultyName,  String facultyDesignation,  String school,  String cabin,  String facultyDepartment,  String facultyEmail,  String facultyIntercom,  String facultyMobileNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorDetails() when $default != null:
return $default(_that.facultyId,_that.facultyName,_that.facultyDesignation,_that.school,_that.cabin,_that.facultyDepartment,_that.facultyEmail,_that.facultyIntercom,_that.facultyMobileNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String facultyId,  String facultyName,  String facultyDesignation,  String school,  String cabin,  String facultyDepartment,  String facultyEmail,  String facultyIntercom,  String facultyMobileNumber)  $default,) {final _that = this;
switch (_that) {
case _MentorDetails():
return $default(_that.facultyId,_that.facultyName,_that.facultyDesignation,_that.school,_that.cabin,_that.facultyDepartment,_that.facultyEmail,_that.facultyIntercom,_that.facultyMobileNumber);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String facultyId,  String facultyName,  String facultyDesignation,  String school,  String cabin,  String facultyDepartment,  String facultyEmail,  String facultyIntercom,  String facultyMobileNumber)?  $default,) {final _that = this;
switch (_that) {
case _MentorDetails() when $default != null:
return $default(_that.facultyId,_that.facultyName,_that.facultyDesignation,_that.school,_that.cabin,_that.facultyDepartment,_that.facultyEmail,_that.facultyIntercom,_that.facultyMobileNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MentorDetails implements MentorDetails {
  const _MentorDetails({required this.facultyId, required this.facultyName, required this.facultyDesignation, required this.school, required this.cabin, required this.facultyDepartment, required this.facultyEmail, required this.facultyIntercom, required this.facultyMobileNumber});
  factory _MentorDetails.fromJson(Map<String, dynamic> json) => _$MentorDetailsFromJson(json);

@override final  String facultyId;
@override final  String facultyName;
@override final  String facultyDesignation;
@override final  String school;
@override final  String cabin;
@override final  String facultyDepartment;
@override final  String facultyEmail;
@override final  String facultyIntercom;
@override final  String facultyMobileNumber;

/// Create a copy of MentorDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorDetailsCopyWith<_MentorDetails> get copyWith => __$MentorDetailsCopyWithImpl<_MentorDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MentorDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorDetails&&(identical(other.facultyId, facultyId) || other.facultyId == facultyId)&&(identical(other.facultyName, facultyName) || other.facultyName == facultyName)&&(identical(other.facultyDesignation, facultyDesignation) || other.facultyDesignation == facultyDesignation)&&(identical(other.school, school) || other.school == school)&&(identical(other.cabin, cabin) || other.cabin == cabin)&&(identical(other.facultyDepartment, facultyDepartment) || other.facultyDepartment == facultyDepartment)&&(identical(other.facultyEmail, facultyEmail) || other.facultyEmail == facultyEmail)&&(identical(other.facultyIntercom, facultyIntercom) || other.facultyIntercom == facultyIntercom)&&(identical(other.facultyMobileNumber, facultyMobileNumber) || other.facultyMobileNumber == facultyMobileNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,facultyId,facultyName,facultyDesignation,school,cabin,facultyDepartment,facultyEmail,facultyIntercom,facultyMobileNumber);

@override
String toString() {
  return 'MentorDetails(facultyId: $facultyId, facultyName: $facultyName, facultyDesignation: $facultyDesignation, school: $school, cabin: $cabin, facultyDepartment: $facultyDepartment, facultyEmail: $facultyEmail, facultyIntercom: $facultyIntercom, facultyMobileNumber: $facultyMobileNumber)';
}


}

/// @nodoc
abstract mixin class _$MentorDetailsCopyWith<$Res> implements $MentorDetailsCopyWith<$Res> {
  factory _$MentorDetailsCopyWith(_MentorDetails value, $Res Function(_MentorDetails) _then) = __$MentorDetailsCopyWithImpl;
@override @useResult
$Res call({
 String facultyId, String facultyName, String facultyDesignation, String school, String cabin, String facultyDepartment, String facultyEmail, String facultyIntercom, String facultyMobileNumber
});




}
/// @nodoc
class __$MentorDetailsCopyWithImpl<$Res>
    implements _$MentorDetailsCopyWith<$Res> {
  __$MentorDetailsCopyWithImpl(this._self, this._then);

  final _MentorDetails _self;
  final $Res Function(_MentorDetails) _then;

/// Create a copy of MentorDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? facultyId = null,Object? facultyName = null,Object? facultyDesignation = null,Object? school = null,Object? cabin = null,Object? facultyDepartment = null,Object? facultyEmail = null,Object? facultyIntercom = null,Object? facultyMobileNumber = null,}) {
  return _then(_MentorDetails(
facultyId: null == facultyId ? _self.facultyId : facultyId // ignore: cast_nullable_to_non_nullable
as String,facultyName: null == facultyName ? _self.facultyName : facultyName // ignore: cast_nullable_to_non_nullable
as String,facultyDesignation: null == facultyDesignation ? _self.facultyDesignation : facultyDesignation // ignore: cast_nullable_to_non_nullable
as String,school: null == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String,cabin: null == cabin ? _self.cabin : cabin // ignore: cast_nullable_to_non_nullable
as String,facultyDepartment: null == facultyDepartment ? _self.facultyDepartment : facultyDepartment // ignore: cast_nullable_to_non_nullable
as String,facultyEmail: null == facultyEmail ? _self.facultyEmail : facultyEmail // ignore: cast_nullable_to_non_nullable
as String,facultyIntercom: null == facultyIntercom ? _self.facultyIntercom : facultyIntercom // ignore: cast_nullable_to_non_nullable
as String,facultyMobileNumber: null == facultyMobileNumber ? _self.facultyMobileNumber : facultyMobileNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
