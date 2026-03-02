// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faculty.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FacultyDetails {

 String get name; String get designation; String get department; String get schoolCentre; String get email; String get cabinNumber; List<OfficeHour> get officeHours;
/// Create a copy of FacultyDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FacultyDetailsCopyWith<FacultyDetails> get copyWith => _$FacultyDetailsCopyWithImpl<FacultyDetails>(this as FacultyDetails, _$identity);

  /// Serializes this FacultyDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FacultyDetails&&(identical(other.name, name) || other.name == name)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.department, department) || other.department == department)&&(identical(other.schoolCentre, schoolCentre) || other.schoolCentre == schoolCentre)&&(identical(other.email, email) || other.email == email)&&(identical(other.cabinNumber, cabinNumber) || other.cabinNumber == cabinNumber)&&const DeepCollectionEquality().equals(other.officeHours, officeHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,designation,department,schoolCentre,email,cabinNumber,const DeepCollectionEquality().hash(officeHours));

@override
String toString() {
  return 'FacultyDetails(name: $name, designation: $designation, department: $department, schoolCentre: $schoolCentre, email: $email, cabinNumber: $cabinNumber, officeHours: $officeHours)';
}


}

/// @nodoc
abstract mixin class $FacultyDetailsCopyWith<$Res>  {
  factory $FacultyDetailsCopyWith(FacultyDetails value, $Res Function(FacultyDetails) _then) = _$FacultyDetailsCopyWithImpl;
@useResult
$Res call({
 String name, String designation, String department, String schoolCentre, String email, String cabinNumber, List<OfficeHour> officeHours
});




}
/// @nodoc
class _$FacultyDetailsCopyWithImpl<$Res>
    implements $FacultyDetailsCopyWith<$Res> {
  _$FacultyDetailsCopyWithImpl(this._self, this._then);

  final FacultyDetails _self;
  final $Res Function(FacultyDetails) _then;

/// Create a copy of FacultyDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? designation = null,Object? department = null,Object? schoolCentre = null,Object? email = null,Object? cabinNumber = null,Object? officeHours = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,schoolCentre: null == schoolCentre ? _self.schoolCentre : schoolCentre // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,cabinNumber: null == cabinNumber ? _self.cabinNumber : cabinNumber // ignore: cast_nullable_to_non_nullable
as String,officeHours: null == officeHours ? _self.officeHours : officeHours // ignore: cast_nullable_to_non_nullable
as List<OfficeHour>,
  ));
}

}


/// Adds pattern-matching-related methods to [FacultyDetails].
extension FacultyDetailsPatterns on FacultyDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FacultyDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FacultyDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FacultyDetails value)  $default,){
final _that = this;
switch (_that) {
case _FacultyDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FacultyDetails value)?  $default,){
final _that = this;
switch (_that) {
case _FacultyDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String designation,  String department,  String schoolCentre,  String email,  String cabinNumber,  List<OfficeHour> officeHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FacultyDetails() when $default != null:
return $default(_that.name,_that.designation,_that.department,_that.schoolCentre,_that.email,_that.cabinNumber,_that.officeHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String designation,  String department,  String schoolCentre,  String email,  String cabinNumber,  List<OfficeHour> officeHours)  $default,) {final _that = this;
switch (_that) {
case _FacultyDetails():
return $default(_that.name,_that.designation,_that.department,_that.schoolCentre,_that.email,_that.cabinNumber,_that.officeHours);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String designation,  String department,  String schoolCentre,  String email,  String cabinNumber,  List<OfficeHour> officeHours)?  $default,) {final _that = this;
switch (_that) {
case _FacultyDetails() when $default != null:
return $default(_that.name,_that.designation,_that.department,_that.schoolCentre,_that.email,_that.cabinNumber,_that.officeHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FacultyDetails implements FacultyDetails {
  const _FacultyDetails({required this.name, required this.designation, required this.department, required this.schoolCentre, required this.email, required this.cabinNumber, required final  List<OfficeHour> officeHours}): _officeHours = officeHours;
  factory _FacultyDetails.fromJson(Map<String, dynamic> json) => _$FacultyDetailsFromJson(json);

@override final  String name;
@override final  String designation;
@override final  String department;
@override final  String schoolCentre;
@override final  String email;
@override final  String cabinNumber;
 final  List<OfficeHour> _officeHours;
@override List<OfficeHour> get officeHours {
  if (_officeHours is EqualUnmodifiableListView) return _officeHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_officeHours);
}


/// Create a copy of FacultyDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FacultyDetailsCopyWith<_FacultyDetails> get copyWith => __$FacultyDetailsCopyWithImpl<_FacultyDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FacultyDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FacultyDetails&&(identical(other.name, name) || other.name == name)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.department, department) || other.department == department)&&(identical(other.schoolCentre, schoolCentre) || other.schoolCentre == schoolCentre)&&(identical(other.email, email) || other.email == email)&&(identical(other.cabinNumber, cabinNumber) || other.cabinNumber == cabinNumber)&&const DeepCollectionEquality().equals(other._officeHours, _officeHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,designation,department,schoolCentre,email,cabinNumber,const DeepCollectionEquality().hash(_officeHours));

@override
String toString() {
  return 'FacultyDetails(name: $name, designation: $designation, department: $department, schoolCentre: $schoolCentre, email: $email, cabinNumber: $cabinNumber, officeHours: $officeHours)';
}


}

/// @nodoc
abstract mixin class _$FacultyDetailsCopyWith<$Res> implements $FacultyDetailsCopyWith<$Res> {
  factory _$FacultyDetailsCopyWith(_FacultyDetails value, $Res Function(_FacultyDetails) _then) = __$FacultyDetailsCopyWithImpl;
@override @useResult
$Res call({
 String name, String designation, String department, String schoolCentre, String email, String cabinNumber, List<OfficeHour> officeHours
});




}
/// @nodoc
class __$FacultyDetailsCopyWithImpl<$Res>
    implements _$FacultyDetailsCopyWith<$Res> {
  __$FacultyDetailsCopyWithImpl(this._self, this._then);

  final _FacultyDetails _self;
  final $Res Function(_FacultyDetails) _then;

/// Create a copy of FacultyDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? designation = null,Object? department = null,Object? schoolCentre = null,Object? email = null,Object? cabinNumber = null,Object? officeHours = null,}) {
  return _then(_FacultyDetails(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,schoolCentre: null == schoolCentre ? _self.schoolCentre : schoolCentre // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,cabinNumber: null == cabinNumber ? _self.cabinNumber : cabinNumber // ignore: cast_nullable_to_non_nullable
as String,officeHours: null == officeHours ? _self._officeHours : officeHours // ignore: cast_nullable_to_non_nullable
as List<OfficeHour>,
  ));
}


}

/// @nodoc
mixin _$GetFaculty {

 String get facultyName; String get designation; String get schoolOrCentre; String get empId;
/// Create a copy of GetFaculty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetFacultyCopyWith<GetFaculty> get copyWith => _$GetFacultyCopyWithImpl<GetFaculty>(this as GetFaculty, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetFaculty&&(identical(other.facultyName, facultyName) || other.facultyName == facultyName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.schoolOrCentre, schoolOrCentre) || other.schoolOrCentre == schoolOrCentre)&&(identical(other.empId, empId) || other.empId == empId));
}


@override
int get hashCode => Object.hash(runtimeType,facultyName,designation,schoolOrCentre,empId);

@override
String toString() {
  return 'GetFaculty(facultyName: $facultyName, designation: $designation, schoolOrCentre: $schoolOrCentre, empId: $empId)';
}


}

/// @nodoc
abstract mixin class $GetFacultyCopyWith<$Res>  {
  factory $GetFacultyCopyWith(GetFaculty value, $Res Function(GetFaculty) _then) = _$GetFacultyCopyWithImpl;
@useResult
$Res call({
 String facultyName, String designation, String schoolOrCentre, String empId
});




}
/// @nodoc
class _$GetFacultyCopyWithImpl<$Res>
    implements $GetFacultyCopyWith<$Res> {
  _$GetFacultyCopyWithImpl(this._self, this._then);

  final GetFaculty _self;
  final $Res Function(GetFaculty) _then;

/// Create a copy of GetFaculty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? facultyName = null,Object? designation = null,Object? schoolOrCentre = null,Object? empId = null,}) {
  return _then(_self.copyWith(
facultyName: null == facultyName ? _self.facultyName : facultyName // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,schoolOrCentre: null == schoolOrCentre ? _self.schoolOrCentre : schoolOrCentre // ignore: cast_nullable_to_non_nullable
as String,empId: null == empId ? _self.empId : empId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetFaculty].
extension GetFacultyPatterns on GetFaculty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetFaculty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetFaculty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetFaculty value)  $default,){
final _that = this;
switch (_that) {
case _GetFaculty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetFaculty value)?  $default,){
final _that = this;
switch (_that) {
case _GetFaculty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String facultyName,  String designation,  String schoolOrCentre,  String empId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetFaculty() when $default != null:
return $default(_that.facultyName,_that.designation,_that.schoolOrCentre,_that.empId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String facultyName,  String designation,  String schoolOrCentre,  String empId)  $default,) {final _that = this;
switch (_that) {
case _GetFaculty():
return $default(_that.facultyName,_that.designation,_that.schoolOrCentre,_that.empId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String facultyName,  String designation,  String schoolOrCentre,  String empId)?  $default,) {final _that = this;
switch (_that) {
case _GetFaculty() when $default != null:
return $default(_that.facultyName,_that.designation,_that.schoolOrCentre,_that.empId);case _:
  return null;

}
}

}

/// @nodoc


class _GetFaculty implements GetFaculty {
  const _GetFaculty({required this.facultyName, required this.designation, required this.schoolOrCentre, required this.empId});
  

@override final  String facultyName;
@override final  String designation;
@override final  String schoolOrCentre;
@override final  String empId;

/// Create a copy of GetFaculty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetFacultyCopyWith<_GetFaculty> get copyWith => __$GetFacultyCopyWithImpl<_GetFaculty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetFaculty&&(identical(other.facultyName, facultyName) || other.facultyName == facultyName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.schoolOrCentre, schoolOrCentre) || other.schoolOrCentre == schoolOrCentre)&&(identical(other.empId, empId) || other.empId == empId));
}


@override
int get hashCode => Object.hash(runtimeType,facultyName,designation,schoolOrCentre,empId);

@override
String toString() {
  return 'GetFaculty(facultyName: $facultyName, designation: $designation, schoolOrCentre: $schoolOrCentre, empId: $empId)';
}


}

/// @nodoc
abstract mixin class _$GetFacultyCopyWith<$Res> implements $GetFacultyCopyWith<$Res> {
  factory _$GetFacultyCopyWith(_GetFaculty value, $Res Function(_GetFaculty) _then) = __$GetFacultyCopyWithImpl;
@override @useResult
$Res call({
 String facultyName, String designation, String schoolOrCentre, String empId
});




}
/// @nodoc
class __$GetFacultyCopyWithImpl<$Res>
    implements _$GetFacultyCopyWith<$Res> {
  __$GetFacultyCopyWithImpl(this._self, this._then);

  final _GetFaculty _self;
  final $Res Function(_GetFaculty) _then;

/// Create a copy of GetFaculty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? facultyName = null,Object? designation = null,Object? schoolOrCentre = null,Object? empId = null,}) {
  return _then(_GetFaculty(
facultyName: null == facultyName ? _self.facultyName : facultyName // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,schoolOrCentre: null == schoolOrCentre ? _self.schoolOrCentre : schoolOrCentre // ignore: cast_nullable_to_non_nullable
as String,empId: null == empId ? _self.empId : empId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OfficeHour {

 String get day; String get timings;
/// Create a copy of OfficeHour
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfficeHourCopyWith<OfficeHour> get copyWith => _$OfficeHourCopyWithImpl<OfficeHour>(this as OfficeHour, _$identity);

  /// Serializes this OfficeHour to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfficeHour&&(identical(other.day, day) || other.day == day)&&(identical(other.timings, timings) || other.timings == timings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,timings);

@override
String toString() {
  return 'OfficeHour(day: $day, timings: $timings)';
}


}

/// @nodoc
abstract mixin class $OfficeHourCopyWith<$Res>  {
  factory $OfficeHourCopyWith(OfficeHour value, $Res Function(OfficeHour) _then) = _$OfficeHourCopyWithImpl;
@useResult
$Res call({
 String day, String timings
});




}
/// @nodoc
class _$OfficeHourCopyWithImpl<$Res>
    implements $OfficeHourCopyWith<$Res> {
  _$OfficeHourCopyWithImpl(this._self, this._then);

  final OfficeHour _self;
  final $Res Function(OfficeHour) _then;

/// Create a copy of OfficeHour
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? timings = null,}) {
  return _then(_self.copyWith(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,timings: null == timings ? _self.timings : timings // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OfficeHour].
extension OfficeHourPatterns on OfficeHour {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfficeHour value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfficeHour() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfficeHour value)  $default,){
final _that = this;
switch (_that) {
case _OfficeHour():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfficeHour value)?  $default,){
final _that = this;
switch (_that) {
case _OfficeHour() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String day,  String timings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfficeHour() when $default != null:
return $default(_that.day,_that.timings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String day,  String timings)  $default,) {final _that = this;
switch (_that) {
case _OfficeHour():
return $default(_that.day,_that.timings);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String day,  String timings)?  $default,) {final _that = this;
switch (_that) {
case _OfficeHour() when $default != null:
return $default(_that.day,_that.timings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OfficeHour implements OfficeHour {
  const _OfficeHour({required this.day, required this.timings});
  factory _OfficeHour.fromJson(Map<String, dynamic> json) => _$OfficeHourFromJson(json);

@override final  String day;
@override final  String timings;

/// Create a copy of OfficeHour
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfficeHourCopyWith<_OfficeHour> get copyWith => __$OfficeHourCopyWithImpl<_OfficeHour>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfficeHourToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfficeHour&&(identical(other.day, day) || other.day == day)&&(identical(other.timings, timings) || other.timings == timings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,timings);

@override
String toString() {
  return 'OfficeHour(day: $day, timings: $timings)';
}


}

/// @nodoc
abstract mixin class _$OfficeHourCopyWith<$Res> implements $OfficeHourCopyWith<$Res> {
  factory _$OfficeHourCopyWith(_OfficeHour value, $Res Function(_OfficeHour) _then) = __$OfficeHourCopyWithImpl;
@override @useResult
$Res call({
 String day, String timings
});




}
/// @nodoc
class __$OfficeHourCopyWithImpl<$Res>
    implements _$OfficeHourCopyWith<$Res> {
  __$OfficeHourCopyWithImpl(this._self, this._then);

  final _OfficeHour _self;
  final $Res Function(_OfficeHour) _then;

/// Create a copy of OfficeHour
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? timings = null,}) {
  return _then(_OfficeHour(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,timings: null == timings ? _self.timings : timings // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
