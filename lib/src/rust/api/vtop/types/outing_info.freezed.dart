// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outing_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OutingInfo {
  String get registrationNumber;
  String get name;
  String get applicationNo;
  String get gender;
  String get hostelBlock;
  String get roomNumber;
  String get parentContactNumber;

  /// Create a copy of OutingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutingInfoCopyWith<OutingInfo> get copyWith =>
      _$OutingInfoCopyWithImpl<OutingInfo>(this as OutingInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OutingInfo &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.applicationNo, applicationNo) ||
                other.applicationNo == applicationNo) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.hostelBlock, hostelBlock) ||
                other.hostelBlock == hostelBlock) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.parentContactNumber, parentContactNumber) ||
                other.parentContactNumber == parentContactNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registrationNumber, name,
      applicationNo, gender, hostelBlock, roomNumber, parentContactNumber);

  @override
  String toString() {
    return 'OutingInfo(registrationNumber: $registrationNumber, name: $name, applicationNo: $applicationNo, gender: $gender, hostelBlock: $hostelBlock, roomNumber: $roomNumber, parentContactNumber: $parentContactNumber)';
  }
}

/// @nodoc
abstract mixin class $OutingInfoCopyWith<$Res> {
  factory $OutingInfoCopyWith(
          OutingInfo value, $Res Function(OutingInfo) _then) =
      _$OutingInfoCopyWithImpl;
  @useResult
  $Res call(
      {String registrationNumber,
      String name,
      String applicationNo,
      String gender,
      String hostelBlock,
      String roomNumber,
      String parentContactNumber});
}

/// @nodoc
class _$OutingInfoCopyWithImpl<$Res> implements $OutingInfoCopyWith<$Res> {
  _$OutingInfoCopyWithImpl(this._self, this._then);

  final OutingInfo _self;
  final $Res Function(OutingInfo) _then;

  /// Create a copy of OutingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationNumber = null,
    Object? name = null,
    Object? applicationNo = null,
    Object? gender = null,
    Object? hostelBlock = null,
    Object? roomNumber = null,
    Object? parentContactNumber = null,
  }) {
    return _then(_self.copyWith(
      registrationNumber: null == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      applicationNo: null == applicationNo
          ? _self.applicationNo
          : applicationNo // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      hostelBlock: null == hostelBlock
          ? _self.hostelBlock
          : hostelBlock // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _self.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      parentContactNumber: null == parentContactNumber
          ? _self.parentContactNumber
          : parentContactNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [OutingInfo].
extension OutingInfoPatterns on OutingInfo {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_OutingInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutingInfo() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_OutingInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingInfo():
        return $default(_that);
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_OutingInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingInfo() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String registrationNumber,
            String name,
            String applicationNo,
            String gender,
            String hostelBlock,
            String roomNumber,
            String parentContactNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutingInfo() when $default != null:
        return $default(
            _that.registrationNumber,
            _that.name,
            _that.applicationNo,
            _that.gender,
            _that.hostelBlock,
            _that.roomNumber,
            _that.parentContactNumber);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String registrationNumber,
            String name,
            String applicationNo,
            String gender,
            String hostelBlock,
            String roomNumber,
            String parentContactNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingInfo():
        return $default(
            _that.registrationNumber,
            _that.name,
            _that.applicationNo,
            _that.gender,
            _that.hostelBlock,
            _that.roomNumber,
            _that.parentContactNumber);
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String registrationNumber,
            String name,
            String applicationNo,
            String gender,
            String hostelBlock,
            String roomNumber,
            String parentContactNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingInfo() when $default != null:
        return $default(
            _that.registrationNumber,
            _that.name,
            _that.applicationNo,
            _that.gender,
            _that.hostelBlock,
            _that.roomNumber,
            _that.parentContactNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OutingInfo implements OutingInfo {
  const _OutingInfo(
      {required this.registrationNumber,
      required this.name,
      required this.applicationNo,
      required this.gender,
      required this.hostelBlock,
      required this.roomNumber,
      required this.parentContactNumber});

  @override
  final String registrationNumber;
  @override
  final String name;
  @override
  final String applicationNo;
  @override
  final String gender;
  @override
  final String hostelBlock;
  @override
  final String roomNumber;
  @override
  final String parentContactNumber;

  /// Create a copy of OutingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutingInfoCopyWith<_OutingInfo> get copyWith =>
      __$OutingInfoCopyWithImpl<_OutingInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OutingInfo &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.applicationNo, applicationNo) ||
                other.applicationNo == applicationNo) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.hostelBlock, hostelBlock) ||
                other.hostelBlock == hostelBlock) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.parentContactNumber, parentContactNumber) ||
                other.parentContactNumber == parentContactNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registrationNumber, name,
      applicationNo, gender, hostelBlock, roomNumber, parentContactNumber);

  @override
  String toString() {
    return 'OutingInfo(registrationNumber: $registrationNumber, name: $name, applicationNo: $applicationNo, gender: $gender, hostelBlock: $hostelBlock, roomNumber: $roomNumber, parentContactNumber: $parentContactNumber)';
  }
}

/// @nodoc
abstract mixin class _$OutingInfoCopyWith<$Res>
    implements $OutingInfoCopyWith<$Res> {
  factory _$OutingInfoCopyWith(
          _OutingInfo value, $Res Function(_OutingInfo) _then) =
      __$OutingInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String registrationNumber,
      String name,
      String applicationNo,
      String gender,
      String hostelBlock,
      String roomNumber,
      String parentContactNumber});
}

/// @nodoc
class __$OutingInfoCopyWithImpl<$Res> implements _$OutingInfoCopyWith<$Res> {
  __$OutingInfoCopyWithImpl(this._self, this._then);

  final _OutingInfo _self;
  final $Res Function(_OutingInfo) _then;

  /// Create a copy of OutingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? registrationNumber = null,
    Object? name = null,
    Object? applicationNo = null,
    Object? gender = null,
    Object? hostelBlock = null,
    Object? roomNumber = null,
    Object? parentContactNumber = null,
  }) {
    return _then(_OutingInfo(
      registrationNumber: null == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      applicationNo: null == applicationNo
          ? _self.applicationNo
          : applicationNo // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      hostelBlock: null == hostelBlock
          ? _self.hostelBlock
          : hostelBlock // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _self.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      parentContactNumber: null == parentContactNumber
          ? _self.parentContactNumber
          : parentContactNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
