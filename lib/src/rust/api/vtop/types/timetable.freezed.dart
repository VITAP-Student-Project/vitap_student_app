// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimetableSlot {
  String get serial;
  String get day;
  String get slot;
  String get courseCode;
  String get courseType;
  String get roomNo;
  String get block;
  String get startTime;
  String get endTime;
  String get name;

  /// Create a copy of TimetableSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimetableSlotCopyWith<TimetableSlot> get copyWith =>
      _$TimetableSlotCopyWithImpl<TimetableSlot>(
          this as TimetableSlot, _$identity);

  /// Serializes this TimetableSlot to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimetableSlot &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.roomNo, roomNo) || other.roomNo == roomNo) &&
            (identical(other.block, block) || other.block == block) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serial, day, slot, courseCode,
      courseType, roomNo, block, startTime, endTime, name);

  @override
  String toString() {
    return 'TimetableSlot(serial: $serial, day: $day, slot: $slot, courseCode: $courseCode, courseType: $courseType, roomNo: $roomNo, block: $block, startTime: $startTime, endTime: $endTime, name: $name)';
  }
}

/// @nodoc
abstract mixin class $TimetableSlotCopyWith<$Res> {
  factory $TimetableSlotCopyWith(
          TimetableSlot value, $Res Function(TimetableSlot) _then) =
      _$TimetableSlotCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String day,
      String slot,
      String courseCode,
      String courseType,
      String roomNo,
      String block,
      String startTime,
      String endTime,
      String name});
}

/// @nodoc
class _$TimetableSlotCopyWithImpl<$Res>
    implements $TimetableSlotCopyWith<$Res> {
  _$TimetableSlotCopyWithImpl(this._self, this._then);

  final TimetableSlot _self;
  final $Res Function(TimetableSlot) _then;

  /// Create a copy of TimetableSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serial = null,
    Object? day = null,
    Object? slot = null,
    Object? courseCode = null,
    Object? courseType = null,
    Object? roomNo = null,
    Object? block = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      roomNo: null == roomNo
          ? _self.roomNo
          : roomNo // ignore: cast_nullable_to_non_nullable
              as String,
      block: null == block
          ? _self.block
          : block // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimetableSlot].
extension TimetableSlotPatterns on TimetableSlot {
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
    TResult Function(_TimetableSlot value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimetableSlot() when $default != null:
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
    TResult Function(_TimetableSlot value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableSlot():
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
    TResult? Function(_TimetableSlot value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableSlot() when $default != null:
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
            String serial,
            String day,
            String slot,
            String courseCode,
            String courseType,
            String roomNo,
            String block,
            String startTime,
            String endTime,
            String name)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimetableSlot() when $default != null:
        return $default(
            _that.serial,
            _that.day,
            _that.slot,
            _that.courseCode,
            _that.courseType,
            _that.roomNo,
            _that.block,
            _that.startTime,
            _that.endTime,
            _that.name);
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
            String serial,
            String day,
            String slot,
            String courseCode,
            String courseType,
            String roomNo,
            String block,
            String startTime,
            String endTime,
            String name)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableSlot():
        return $default(
            _that.serial,
            _that.day,
            _that.slot,
            _that.courseCode,
            _that.courseType,
            _that.roomNo,
            _that.block,
            _that.startTime,
            _that.endTime,
            _that.name);
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
            String serial,
            String day,
            String slot,
            String courseCode,
            String courseType,
            String roomNo,
            String block,
            String startTime,
            String endTime,
            String name)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableSlot() when $default != null:
        return $default(
            _that.serial,
            _that.day,
            _that.slot,
            _that.courseCode,
            _that.courseType,
            _that.roomNo,
            _that.block,
            _that.startTime,
            _that.endTime,
            _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimetableSlot implements TimetableSlot {
  const _TimetableSlot(
      {required this.serial,
      required this.day,
      required this.slot,
      required this.courseCode,
      required this.courseType,
      required this.roomNo,
      required this.block,
      required this.startTime,
      required this.endTime,
      required this.name});
  factory _TimetableSlot.fromJson(Map<String, dynamic> json) =>
      _$TimetableSlotFromJson(json);

  @override
  final String serial;
  @override
  final String day;
  @override
  final String slot;
  @override
  final String courseCode;
  @override
  final String courseType;
  @override
  final String roomNo;
  @override
  final String block;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String name;

  /// Create a copy of TimetableSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimetableSlotCopyWith<_TimetableSlot> get copyWith =>
      __$TimetableSlotCopyWithImpl<_TimetableSlot>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimetableSlotToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimetableSlot &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.roomNo, roomNo) || other.roomNo == roomNo) &&
            (identical(other.block, block) || other.block == block) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serial, day, slot, courseCode,
      courseType, roomNo, block, startTime, endTime, name);

  @override
  String toString() {
    return 'TimetableSlot(serial: $serial, day: $day, slot: $slot, courseCode: $courseCode, courseType: $courseType, roomNo: $roomNo, block: $block, startTime: $startTime, endTime: $endTime, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$TimetableSlotCopyWith<$Res>
    implements $TimetableSlotCopyWith<$Res> {
  factory _$TimetableSlotCopyWith(
          _TimetableSlot value, $Res Function(_TimetableSlot) _then) =
      __$TimetableSlotCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serial,
      String day,
      String slot,
      String courseCode,
      String courseType,
      String roomNo,
      String block,
      String startTime,
      String endTime,
      String name});
}

/// @nodoc
class __$TimetableSlotCopyWithImpl<$Res>
    implements _$TimetableSlotCopyWith<$Res> {
  __$TimetableSlotCopyWithImpl(this._self, this._then);

  final _TimetableSlot _self;
  final $Res Function(_TimetableSlot) _then;

  /// Create a copy of TimetableSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serial = null,
    Object? day = null,
    Object? slot = null,
    Object? courseCode = null,
    Object? courseType = null,
    Object? roomNo = null,
    Object? block = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? name = null,
  }) {
    return _then(_TimetableSlot(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      roomNo: null == roomNo
          ? _self.roomNo
          : roomNo // ignore: cast_nullable_to_non_nullable
              as String,
      block: null == block
          ? _self.block
          : block // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
