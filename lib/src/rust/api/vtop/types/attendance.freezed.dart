// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceDetailRecord {
  String get serial;
  String get date;
  String get slot;
  String get dayTime;
  String get status;
  String get remark;

  /// Create a copy of AttendanceDetailRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttendanceDetailRecordCopyWith<AttendanceDetailRecord> get copyWith =>
      _$AttendanceDetailRecordCopyWithImpl<AttendanceDetailRecord>(
          this as AttendanceDetailRecord, _$identity);

  /// Serializes this AttendanceDetailRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttendanceDetailRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.dayTime, dayTime) || other.dayTime == dayTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, serial, date, slot, dayTime, status, remark);

  @override
  String toString() {
    return 'AttendanceDetailRecord(serial: $serial, date: $date, slot: $slot, dayTime: $dayTime, status: $status, remark: $remark)';
  }
}

/// @nodoc
abstract mixin class $AttendanceDetailRecordCopyWith<$Res> {
  factory $AttendanceDetailRecordCopyWith(AttendanceDetailRecord value,
          $Res Function(AttendanceDetailRecord) _then) =
      _$AttendanceDetailRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String date,
      String slot,
      String dayTime,
      String status,
      String remark});
}

/// @nodoc
class _$AttendanceDetailRecordCopyWithImpl<$Res>
    implements $AttendanceDetailRecordCopyWith<$Res> {
  _$AttendanceDetailRecordCopyWithImpl(this._self, this._then);

  final AttendanceDetailRecord _self;
  final $Res Function(AttendanceDetailRecord) _then;

  /// Create a copy of AttendanceDetailRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serial = null,
    Object? date = null,
    Object? slot = null,
    Object? dayTime = null,
    Object? status = null,
    Object? remark = null,
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
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      dayTime: null == dayTime
          ? _self.dayTime
          : dayTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      remark: null == remark
          ? _self.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AttendanceDetailRecord].
extension AttendanceDetailRecordPatterns on AttendanceDetailRecord {
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
    TResult Function(_AttendanceDetailRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttendanceDetailRecord() when $default != null:
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
    TResult Function(_AttendanceDetailRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceDetailRecord():
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
    TResult? Function(_AttendanceDetailRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceDetailRecord() when $default != null:
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
    TResult Function(String serial, String date, String slot, String dayTime,
            String status, String remark)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttendanceDetailRecord() when $default != null:
        return $default(_that.serial, _that.date, _that.slot, _that.dayTime,
            _that.status, _that.remark);
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
    TResult Function(String serial, String date, String slot, String dayTime,
            String status, String remark)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceDetailRecord():
        return $default(_that.serial, _that.date, _that.slot, _that.dayTime,
            _that.status, _that.remark);
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
    TResult? Function(String serial, String date, String slot, String dayTime,
            String status, String remark)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceDetailRecord() when $default != null:
        return $default(_that.serial, _that.date, _that.slot, _that.dayTime,
            _that.status, _that.remark);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AttendanceDetailRecord implements AttendanceDetailRecord {
  const _AttendanceDetailRecord(
      {required this.serial,
      required this.date,
      required this.slot,
      required this.dayTime,
      required this.status,
      required this.remark});
  factory _AttendanceDetailRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailRecordFromJson(json);

  @override
  final String serial;
  @override
  final String date;
  @override
  final String slot;
  @override
  final String dayTime;
  @override
  final String status;
  @override
  final String remark;

  /// Create a copy of AttendanceDetailRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttendanceDetailRecordCopyWith<_AttendanceDetailRecord> get copyWith =>
      __$AttendanceDetailRecordCopyWithImpl<_AttendanceDetailRecord>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AttendanceDetailRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttendanceDetailRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.dayTime, dayTime) || other.dayTime == dayTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, serial, date, slot, dayTime, status, remark);

  @override
  String toString() {
    return 'AttendanceDetailRecord(serial: $serial, date: $date, slot: $slot, dayTime: $dayTime, status: $status, remark: $remark)';
  }
}

/// @nodoc
abstract mixin class _$AttendanceDetailRecordCopyWith<$Res>
    implements $AttendanceDetailRecordCopyWith<$Res> {
  factory _$AttendanceDetailRecordCopyWith(_AttendanceDetailRecord value,
          $Res Function(_AttendanceDetailRecord) _then) =
      __$AttendanceDetailRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serial,
      String date,
      String slot,
      String dayTime,
      String status,
      String remark});
}

/// @nodoc
class __$AttendanceDetailRecordCopyWithImpl<$Res>
    implements _$AttendanceDetailRecordCopyWith<$Res> {
  __$AttendanceDetailRecordCopyWithImpl(this._self, this._then);

  final _AttendanceDetailRecord _self;
  final $Res Function(_AttendanceDetailRecord) _then;

  /// Create a copy of AttendanceDetailRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serial = null,
    Object? date = null,
    Object? slot = null,
    Object? dayTime = null,
    Object? status = null,
    Object? remark = null,
  }) {
    return _then(_AttendanceDetailRecord(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      dayTime: null == dayTime
          ? _self.dayTime
          : dayTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      remark: null == remark
          ? _self.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$AttendanceRecord {
  String get classNumber;
  String get courseCode;
  String get courseName;
  String get courseType;
  String get courseTypeCode;
  String get courseSlot;
  String get faculty;
  String get attendedClasses;
  String get totalClasses;
  String get attendancePercentage;
  String get attendanceBetweenPercentage;
  String get debarStatus;
  String get courseId;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttendanceRecordCopyWith<AttendanceRecord> get copyWith =>
      _$AttendanceRecordCopyWithImpl<AttendanceRecord>(
          this as AttendanceRecord, _$identity);

  /// Serializes this AttendanceRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttendanceRecord &&
            (identical(other.classNumber, classNumber) ||
                other.classNumber == classNumber) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.courseTypeCode, courseTypeCode) ||
                other.courseTypeCode == courseTypeCode) &&
            (identical(other.courseSlot, courseSlot) ||
                other.courseSlot == courseSlot) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            (identical(other.attendedClasses, attendedClasses) ||
                other.attendedClasses == attendedClasses) &&
            (identical(other.totalClasses, totalClasses) ||
                other.totalClasses == totalClasses) &&
            (identical(other.attendancePercentage, attendancePercentage) ||
                other.attendancePercentage == attendancePercentage) &&
            (identical(other.attendanceBetweenPercentage,
                    attendanceBetweenPercentage) ||
                other.attendanceBetweenPercentage ==
                    attendanceBetweenPercentage) &&
            (identical(other.debarStatus, debarStatus) ||
                other.debarStatus == debarStatus) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      classNumber,
      courseCode,
      courseName,
      courseType,
      courseTypeCode,
      courseSlot,
      faculty,
      attendedClasses,
      totalClasses,
      attendancePercentage,
      attendanceBetweenPercentage,
      debarStatus,
      courseId);

  @override
  String toString() {
    return 'AttendanceRecord(classNumber: $classNumber, courseCode: $courseCode, courseName: $courseName, courseType: $courseType, courseTypeCode: $courseTypeCode, courseSlot: $courseSlot, faculty: $faculty, attendedClasses: $attendedClasses, totalClasses: $totalClasses, attendancePercentage: $attendancePercentage, attendanceBetweenPercentage: $attendanceBetweenPercentage, debarStatus: $debarStatus, courseId: $courseId)';
  }
}

/// @nodoc
abstract mixin class $AttendanceRecordCopyWith<$Res> {
  factory $AttendanceRecordCopyWith(
          AttendanceRecord value, $Res Function(AttendanceRecord) _then) =
      _$AttendanceRecordCopyWithImpl;
  @useResult
  $Res call(
      {String classNumber,
      String courseCode,
      String courseName,
      String courseType,
      String courseTypeCode,
      String courseSlot,
      String faculty,
      String attendedClasses,
      String totalClasses,
      String attendancePercentage,
      String attendanceBetweenPercentage,
      String debarStatus,
      String courseId});
}

/// @nodoc
class _$AttendanceRecordCopyWithImpl<$Res>
    implements $AttendanceRecordCopyWith<$Res> {
  _$AttendanceRecordCopyWithImpl(this._self, this._then);

  final AttendanceRecord _self;
  final $Res Function(AttendanceRecord) _then;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classNumber = null,
    Object? courseCode = null,
    Object? courseName = null,
    Object? courseType = null,
    Object? courseTypeCode = null,
    Object? courseSlot = null,
    Object? faculty = null,
    Object? attendedClasses = null,
    Object? totalClasses = null,
    Object? attendancePercentage = null,
    Object? attendanceBetweenPercentage = null,
    Object? debarStatus = null,
    Object? courseId = null,
  }) {
    return _then(_self.copyWith(
      classNumber: null == classNumber
          ? _self.classNumber
          : classNumber // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _self.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      courseTypeCode: null == courseTypeCode
          ? _self.courseTypeCode
          : courseTypeCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseSlot: null == courseSlot
          ? _self.courseSlot
          : courseSlot // ignore: cast_nullable_to_non_nullable
              as String,
      faculty: null == faculty
          ? _self.faculty
          : faculty // ignore: cast_nullable_to_non_nullable
              as String,
      attendedClasses: null == attendedClasses
          ? _self.attendedClasses
          : attendedClasses // ignore: cast_nullable_to_non_nullable
              as String,
      totalClasses: null == totalClasses
          ? _self.totalClasses
          : totalClasses // ignore: cast_nullable_to_non_nullable
              as String,
      attendancePercentage: null == attendancePercentage
          ? _self.attendancePercentage
          : attendancePercentage // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceBetweenPercentage: null == attendanceBetweenPercentage
          ? _self.attendanceBetweenPercentage
          : attendanceBetweenPercentage // ignore: cast_nullable_to_non_nullable
              as String,
      debarStatus: null == debarStatus
          ? _self.debarStatus
          : debarStatus // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _self.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AttendanceRecord].
extension AttendanceRecordPatterns on AttendanceRecord {
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
    TResult Function(_AttendanceRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord() when $default != null:
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
    TResult Function(_AttendanceRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord():
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
    TResult? Function(_AttendanceRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord() when $default != null:
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
            String classNumber,
            String courseCode,
            String courseName,
            String courseType,
            String courseTypeCode,
            String courseSlot,
            String faculty,
            String attendedClasses,
            String totalClasses,
            String attendancePercentage,
            String attendanceBetweenPercentage,
            String debarStatus,
            String courseId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord() when $default != null:
        return $default(
            _that.classNumber,
            _that.courseCode,
            _that.courseName,
            _that.courseType,
            _that.courseTypeCode,
            _that.courseSlot,
            _that.faculty,
            _that.attendedClasses,
            _that.totalClasses,
            _that.attendancePercentage,
            _that.attendanceBetweenPercentage,
            _that.debarStatus,
            _that.courseId);
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
            String classNumber,
            String courseCode,
            String courseName,
            String courseType,
            String courseTypeCode,
            String courseSlot,
            String faculty,
            String attendedClasses,
            String totalClasses,
            String attendancePercentage,
            String attendanceBetweenPercentage,
            String debarStatus,
            String courseId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord():
        return $default(
            _that.classNumber,
            _that.courseCode,
            _that.courseName,
            _that.courseType,
            _that.courseTypeCode,
            _that.courseSlot,
            _that.faculty,
            _that.attendedClasses,
            _that.totalClasses,
            _that.attendancePercentage,
            _that.attendanceBetweenPercentage,
            _that.debarStatus,
            _that.courseId);
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
            String classNumber,
            String courseCode,
            String courseName,
            String courseType,
            String courseTypeCode,
            String courseSlot,
            String faculty,
            String attendedClasses,
            String totalClasses,
            String attendancePercentage,
            String attendanceBetweenPercentage,
            String debarStatus,
            String courseId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord() when $default != null:
        return $default(
            _that.classNumber,
            _that.courseCode,
            _that.courseName,
            _that.courseType,
            _that.courseTypeCode,
            _that.courseSlot,
            _that.faculty,
            _that.attendedClasses,
            _that.totalClasses,
            _that.attendancePercentage,
            _that.attendanceBetweenPercentage,
            _that.debarStatus,
            _that.courseId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AttendanceRecord implements AttendanceRecord {
  const _AttendanceRecord(
      {required this.classNumber,
      required this.courseCode,
      required this.courseName,
      required this.courseType,
      required this.courseTypeCode,
      required this.courseSlot,
      required this.faculty,
      required this.attendedClasses,
      required this.totalClasses,
      required this.attendancePercentage,
      required this.attendanceBetweenPercentage,
      required this.debarStatus,
      required this.courseId});
  factory _AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);

  @override
  final String classNumber;
  @override
  final String courseCode;
  @override
  final String courseName;
  @override
  final String courseType;
  @override
  final String courseTypeCode;
  @override
  final String courseSlot;
  @override
  final String faculty;
  @override
  final String attendedClasses;
  @override
  final String totalClasses;
  @override
  final String attendancePercentage;
  @override
  final String attendanceBetweenPercentage;
  @override
  final String debarStatus;
  @override
  final String courseId;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttendanceRecordCopyWith<_AttendanceRecord> get copyWith =>
      __$AttendanceRecordCopyWithImpl<_AttendanceRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AttendanceRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttendanceRecord &&
            (identical(other.classNumber, classNumber) ||
                other.classNumber == classNumber) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.courseTypeCode, courseTypeCode) ||
                other.courseTypeCode == courseTypeCode) &&
            (identical(other.courseSlot, courseSlot) ||
                other.courseSlot == courseSlot) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            (identical(other.attendedClasses, attendedClasses) ||
                other.attendedClasses == attendedClasses) &&
            (identical(other.totalClasses, totalClasses) ||
                other.totalClasses == totalClasses) &&
            (identical(other.attendancePercentage, attendancePercentage) ||
                other.attendancePercentage == attendancePercentage) &&
            (identical(other.attendanceBetweenPercentage,
                    attendanceBetweenPercentage) ||
                other.attendanceBetweenPercentage ==
                    attendanceBetweenPercentage) &&
            (identical(other.debarStatus, debarStatus) ||
                other.debarStatus == debarStatus) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      classNumber,
      courseCode,
      courseName,
      courseType,
      courseTypeCode,
      courseSlot,
      faculty,
      attendedClasses,
      totalClasses,
      attendancePercentage,
      attendanceBetweenPercentage,
      debarStatus,
      courseId);

  @override
  String toString() {
    return 'AttendanceRecord(classNumber: $classNumber, courseCode: $courseCode, courseName: $courseName, courseType: $courseType, courseTypeCode: $courseTypeCode, courseSlot: $courseSlot, faculty: $faculty, attendedClasses: $attendedClasses, totalClasses: $totalClasses, attendancePercentage: $attendancePercentage, attendanceBetweenPercentage: $attendanceBetweenPercentage, debarStatus: $debarStatus, courseId: $courseId)';
  }
}

/// @nodoc
abstract mixin class _$AttendanceRecordCopyWith<$Res>
    implements $AttendanceRecordCopyWith<$Res> {
  factory _$AttendanceRecordCopyWith(
          _AttendanceRecord value, $Res Function(_AttendanceRecord) _then) =
      __$AttendanceRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String classNumber,
      String courseCode,
      String courseName,
      String courseType,
      String courseTypeCode,
      String courseSlot,
      String faculty,
      String attendedClasses,
      String totalClasses,
      String attendancePercentage,
      String attendanceBetweenPercentage,
      String debarStatus,
      String courseId});
}

/// @nodoc
class __$AttendanceRecordCopyWithImpl<$Res>
    implements _$AttendanceRecordCopyWith<$Res> {
  __$AttendanceRecordCopyWithImpl(this._self, this._then);

  final _AttendanceRecord _self;
  final $Res Function(_AttendanceRecord) _then;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? classNumber = null,
    Object? courseCode = null,
    Object? courseName = null,
    Object? courseType = null,
    Object? courseTypeCode = null,
    Object? courseSlot = null,
    Object? faculty = null,
    Object? attendedClasses = null,
    Object? totalClasses = null,
    Object? attendancePercentage = null,
    Object? attendanceBetweenPercentage = null,
    Object? debarStatus = null,
    Object? courseId = null,
  }) {
    return _then(_AttendanceRecord(
      classNumber: null == classNumber
          ? _self.classNumber
          : classNumber // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _self.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      courseTypeCode: null == courseTypeCode
          ? _self.courseTypeCode
          : courseTypeCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseSlot: null == courseSlot
          ? _self.courseSlot
          : courseSlot // ignore: cast_nullable_to_non_nullable
              as String,
      faculty: null == faculty
          ? _self.faculty
          : faculty // ignore: cast_nullable_to_non_nullable
              as String,
      attendedClasses: null == attendedClasses
          ? _self.attendedClasses
          : attendedClasses // ignore: cast_nullable_to_non_nullable
              as String,
      totalClasses: null == totalClasses
          ? _self.totalClasses
          : totalClasses // ignore: cast_nullable_to_non_nullable
              as String,
      attendancePercentage: null == attendancePercentage
          ? _self.attendancePercentage
          : attendancePercentage // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceBetweenPercentage: null == attendanceBetweenPercentage
          ? _self.attendanceBetweenPercentage
          : attendanceBetweenPercentage // ignore: cast_nullable_to_non_nullable
              as String,
      debarStatus: null == debarStatus
          ? _self.debarStatus
          : debarStatus // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _self.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
