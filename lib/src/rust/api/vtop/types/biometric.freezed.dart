// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiometricRecord {
  String get serial;
  String get date;
  String get day;
  String get inTime;
  String get outTime;
  String get duration;
  String get location;

  /// Create a copy of BiometricRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BiometricRecordCopyWith<BiometricRecord> get copyWith =>
      _$BiometricRecordCopyWithImpl<BiometricRecord>(
          this as BiometricRecord, _$identity);

  /// Serializes this BiometricRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BiometricRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.inTime, inTime) || other.inTime == inTime) &&
            (identical(other.outTime, outTime) || other.outTime == outTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, serial, date, day, inTime, outTime, duration, location);

  @override
  String toString() {
    return 'BiometricRecord(serial: $serial, date: $date, day: $day, inTime: $inTime, outTime: $outTime, duration: $duration, location: $location)';
  }
}

/// @nodoc
abstract mixin class $BiometricRecordCopyWith<$Res> {
  factory $BiometricRecordCopyWith(
          BiometricRecord value, $Res Function(BiometricRecord) _then) =
      _$BiometricRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String date,
      String day,
      String inTime,
      String outTime,
      String duration,
      String location});
}

/// @nodoc
class _$BiometricRecordCopyWithImpl<$Res>
    implements $BiometricRecordCopyWith<$Res> {
  _$BiometricRecordCopyWithImpl(this._self, this._then);

  final BiometricRecord _self;
  final $Res Function(BiometricRecord) _then;

  /// Create a copy of BiometricRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serial = null,
    Object? date = null,
    Object? day = null,
    Object? inTime = null,
    Object? outTime = null,
    Object? duration = null,
    Object? location = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      inTime: null == inTime
          ? _self.inTime
          : inTime // ignore: cast_nullable_to_non_nullable
              as String,
      outTime: null == outTime
          ? _self.outTime
          : outTime // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [BiometricRecord].
extension BiometricRecordPatterns on BiometricRecord {
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
    TResult Function(_BiometricRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BiometricRecord() when $default != null:
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
    TResult Function(_BiometricRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BiometricRecord():
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
    TResult? Function(_BiometricRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BiometricRecord() when $default != null:
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
    TResult Function(String serial, String date, String day, String inTime,
            String outTime, String duration, String location)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BiometricRecord() when $default != null:
        return $default(_that.serial, _that.date, _that.day, _that.inTime,
            _that.outTime, _that.duration, _that.location);
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
    TResult Function(String serial, String date, String day, String inTime,
            String outTime, String duration, String location)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BiometricRecord():
        return $default(_that.serial, _that.date, _that.day, _that.inTime,
            _that.outTime, _that.duration, _that.location);
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
    TResult? Function(String serial, String date, String day, String inTime,
            String outTime, String duration, String location)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BiometricRecord() when $default != null:
        return $default(_that.serial, _that.date, _that.day, _that.inTime,
            _that.outTime, _that.duration, _that.location);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BiometricRecord implements BiometricRecord {
  const _BiometricRecord(
      {required this.serial,
      required this.date,
      required this.day,
      required this.inTime,
      required this.outTime,
      required this.duration,
      required this.location});
  factory _BiometricRecord.fromJson(Map<String, dynamic> json) =>
      _$BiometricRecordFromJson(json);

  @override
  final String serial;
  @override
  final String date;
  @override
  final String day;
  @override
  final String inTime;
  @override
  final String outTime;
  @override
  final String duration;
  @override
  final String location;

  /// Create a copy of BiometricRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BiometricRecordCopyWith<_BiometricRecord> get copyWith =>
      __$BiometricRecordCopyWithImpl<_BiometricRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BiometricRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BiometricRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.inTime, inTime) || other.inTime == inTime) &&
            (identical(other.outTime, outTime) || other.outTime == outTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, serial, date, day, inTime, outTime, duration, location);

  @override
  String toString() {
    return 'BiometricRecord(serial: $serial, date: $date, day: $day, inTime: $inTime, outTime: $outTime, duration: $duration, location: $location)';
  }
}

/// @nodoc
abstract mixin class _$BiometricRecordCopyWith<$Res>
    implements $BiometricRecordCopyWith<$Res> {
  factory _$BiometricRecordCopyWith(
          _BiometricRecord value, $Res Function(_BiometricRecord) _then) =
      __$BiometricRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serial,
      String date,
      String day,
      String inTime,
      String outTime,
      String duration,
      String location});
}

/// @nodoc
class __$BiometricRecordCopyWithImpl<$Res>
    implements _$BiometricRecordCopyWith<$Res> {
  __$BiometricRecordCopyWithImpl(this._self, this._then);

  final _BiometricRecord _self;
  final $Res Function(_BiometricRecord) _then;

  /// Create a copy of BiometricRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serial = null,
    Object? date = null,
    Object? day = null,
    Object? inTime = null,
    Object? outTime = null,
    Object? duration = null,
    Object? location = null,
  }) {
    return _then(_BiometricRecord(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      inTime: null == inTime
          ? _self.inTime
          : inTime // ignore: cast_nullable_to_non_nullable
              as String,
      outTime: null == outTime
          ? _self.outTime
          : outTime // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
