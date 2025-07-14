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
  String get serial;
  String get category;
  String get courseName;
  String get courseCode;
  String get courseType;
  String get facultyDetail;
  String get classesAttended;
  String get totalClasses;
  String get attendancePercentage;
  String get attendanceFatCat;
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
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.facultyDetail, facultyDetail) ||
                other.facultyDetail == facultyDetail) &&
            (identical(other.classesAttended, classesAttended) ||
                other.classesAttended == classesAttended) &&
            (identical(other.totalClasses, totalClasses) ||
                other.totalClasses == totalClasses) &&
            (identical(other.attendancePercentage, attendancePercentage) ||
                other.attendancePercentage == attendancePercentage) &&
            (identical(other.attendanceFatCat, attendanceFatCat) ||
                other.attendanceFatCat == attendanceFatCat) &&
            (identical(other.debarStatus, debarStatus) ||
                other.debarStatus == debarStatus) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      category,
      courseName,
      courseCode,
      courseType,
      facultyDetail,
      classesAttended,
      totalClasses,
      attendancePercentage,
      attendanceFatCat,
      debarStatus,
      courseId);

  @override
  String toString() {
    return 'AttendanceRecord(serial: $serial, category: $category, courseName: $courseName, courseCode: $courseCode, courseType: $courseType, facultyDetail: $facultyDetail, classesAttended: $classesAttended, totalClasses: $totalClasses, attendancePercentage: $attendancePercentage, attendanceFatCat: $attendanceFatCat, debarStatus: $debarStatus, courseId: $courseId)';
  }
}

/// @nodoc
abstract mixin class $AttendanceRecordCopyWith<$Res> {
  factory $AttendanceRecordCopyWith(
          AttendanceRecord value, $Res Function(AttendanceRecord) _then) =
      _$AttendanceRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String category,
      String courseName,
      String courseCode,
      String courseType,
      String facultyDetail,
      String classesAttended,
      String totalClasses,
      String attendancePercentage,
      String attendanceFatCat,
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
    Object? serial = null,
    Object? category = null,
    Object? courseName = null,
    Object? courseCode = null,
    Object? courseType = null,
    Object? facultyDetail = null,
    Object? classesAttended = null,
    Object? totalClasses = null,
    Object? attendancePercentage = null,
    Object? attendanceFatCat = null,
    Object? debarStatus = null,
    Object? courseId = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _self.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      facultyDetail: null == facultyDetail
          ? _self.facultyDetail
          : facultyDetail // ignore: cast_nullable_to_non_nullable
              as String,
      classesAttended: null == classesAttended
          ? _self.classesAttended
          : classesAttended // ignore: cast_nullable_to_non_nullable
              as String,
      totalClasses: null == totalClasses
          ? _self.totalClasses
          : totalClasses // ignore: cast_nullable_to_non_nullable
              as String,
      attendancePercentage: null == attendancePercentage
          ? _self.attendancePercentage
          : attendancePercentage // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceFatCat: null == attendanceFatCat
          ? _self.attendanceFatCat
          : attendanceFatCat // ignore: cast_nullable_to_non_nullable
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
            String serial,
            String category,
            String courseName,
            String courseCode,
            String courseType,
            String facultyDetail,
            String classesAttended,
            String totalClasses,
            String attendancePercentage,
            String attendanceFatCat,
            String debarStatus,
            String courseId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord() when $default != null:
        return $default(
            _that.serial,
            _that.category,
            _that.courseName,
            _that.courseCode,
            _that.courseType,
            _that.facultyDetail,
            _that.classesAttended,
            _that.totalClasses,
            _that.attendancePercentage,
            _that.attendanceFatCat,
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
            String serial,
            String category,
            String courseName,
            String courseCode,
            String courseType,
            String facultyDetail,
            String classesAttended,
            String totalClasses,
            String attendancePercentage,
            String attendanceFatCat,
            String debarStatus,
            String courseId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord():
        return $default(
            _that.serial,
            _that.category,
            _that.courseName,
            _that.courseCode,
            _that.courseType,
            _that.facultyDetail,
            _that.classesAttended,
            _that.totalClasses,
            _that.attendancePercentage,
            _that.attendanceFatCat,
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
            String serial,
            String category,
            String courseName,
            String courseCode,
            String courseType,
            String facultyDetail,
            String classesAttended,
            String totalClasses,
            String attendancePercentage,
            String attendanceFatCat,
            String debarStatus,
            String courseId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceRecord() when $default != null:
        return $default(
            _that.serial,
            _that.category,
            _that.courseName,
            _that.courseCode,
            _that.courseType,
            _that.facultyDetail,
            _that.classesAttended,
            _that.totalClasses,
            _that.attendancePercentage,
            _that.attendanceFatCat,
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
      {required this.serial,
      required this.category,
      required this.courseName,
      required this.courseCode,
      required this.courseType,
      required this.facultyDetail,
      required this.classesAttended,
      required this.totalClasses,
      required this.attendancePercentage,
      required this.attendanceFatCat,
      required this.debarStatus,
      required this.courseId});
  factory _AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);

  @override
  final String serial;
  @override
  final String category;
  @override
  final String courseName;
  @override
  final String courseCode;
  @override
  final String courseType;
  @override
  final String facultyDetail;
  @override
  final String classesAttended;
  @override
  final String totalClasses;
  @override
  final String attendancePercentage;
  @override
  final String attendanceFatCat;
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
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.facultyDetail, facultyDetail) ||
                other.facultyDetail == facultyDetail) &&
            (identical(other.classesAttended, classesAttended) ||
                other.classesAttended == classesAttended) &&
            (identical(other.totalClasses, totalClasses) ||
                other.totalClasses == totalClasses) &&
            (identical(other.attendancePercentage, attendancePercentage) ||
                other.attendancePercentage == attendancePercentage) &&
            (identical(other.attendanceFatCat, attendanceFatCat) ||
                other.attendanceFatCat == attendanceFatCat) &&
            (identical(other.debarStatus, debarStatus) ||
                other.debarStatus == debarStatus) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      category,
      courseName,
      courseCode,
      courseType,
      facultyDetail,
      classesAttended,
      totalClasses,
      attendancePercentage,
      attendanceFatCat,
      debarStatus,
      courseId);

  @override
  String toString() {
    return 'AttendanceRecord(serial: $serial, category: $category, courseName: $courseName, courseCode: $courseCode, courseType: $courseType, facultyDetail: $facultyDetail, classesAttended: $classesAttended, totalClasses: $totalClasses, attendancePercentage: $attendancePercentage, attendanceFatCat: $attendanceFatCat, debarStatus: $debarStatus, courseId: $courseId)';
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
      {String serial,
      String category,
      String courseName,
      String courseCode,
      String courseType,
      String facultyDetail,
      String classesAttended,
      String totalClasses,
      String attendancePercentage,
      String attendanceFatCat,
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
    Object? serial = null,
    Object? category = null,
    Object? courseName = null,
    Object? courseCode = null,
    Object? courseType = null,
    Object? facultyDetail = null,
    Object? classesAttended = null,
    Object? totalClasses = null,
    Object? attendancePercentage = null,
    Object? attendanceFatCat = null,
    Object? debarStatus = null,
    Object? courseId = null,
  }) {
    return _then(_AttendanceRecord(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _self.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      facultyDetail: null == facultyDetail
          ? _self.facultyDetail
          : facultyDetail // ignore: cast_nullable_to_non_nullable
              as String,
      classesAttended: null == classesAttended
          ? _self.classesAttended
          : classesAttended // ignore: cast_nullable_to_non_nullable
              as String,
      totalClasses: null == totalClasses
          ? _self.totalClasses
          : totalClasses // ignore: cast_nullable_to_non_nullable
              as String,
      attendancePercentage: null == attendancePercentage
          ? _self.attendancePercentage
          : attendancePercentage // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceFatCat: null == attendanceFatCat
          ? _self.attendanceFatCat
          : attendanceFatCat // ignore: cast_nullable_to_non_nullable
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
