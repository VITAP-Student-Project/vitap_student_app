// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamScheduleRecord {
  String get serial;
  String get slot;
  String get courseName;
  String get courseCode;
  String get courseType;
  String get courseId;
  String get examDate;
  String get examSession;
  String get reportingTime;
  String get examTime;
  String get venue;
  String get seatLocation;
  String get seatNo;

  /// Create a copy of ExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExamScheduleRecordCopyWith<ExamScheduleRecord> get copyWith =>
      _$ExamScheduleRecordCopyWithImpl<ExamScheduleRecord>(
          this as ExamScheduleRecord, _$identity);

  /// Serializes this ExamScheduleRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExamScheduleRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.examDate, examDate) ||
                other.examDate == examDate) &&
            (identical(other.examSession, examSession) ||
                other.examSession == examSession) &&
            (identical(other.reportingTime, reportingTime) ||
                other.reportingTime == reportingTime) &&
            (identical(other.examTime, examTime) ||
                other.examTime == examTime) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.seatLocation, seatLocation) ||
                other.seatLocation == seatLocation) &&
            (identical(other.seatNo, seatNo) || other.seatNo == seatNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      slot,
      courseName,
      courseCode,
      courseType,
      courseId,
      examDate,
      examSession,
      reportingTime,
      examTime,
      venue,
      seatLocation,
      seatNo);

  @override
  String toString() {
    return 'ExamScheduleRecord(serial: $serial, slot: $slot, courseName: $courseName, courseCode: $courseCode, courseType: $courseType, courseId: $courseId, examDate: $examDate, examSession: $examSession, reportingTime: $reportingTime, examTime: $examTime, venue: $venue, seatLocation: $seatLocation, seatNo: $seatNo)';
  }
}

/// @nodoc
abstract mixin class $ExamScheduleRecordCopyWith<$Res> {
  factory $ExamScheduleRecordCopyWith(
          ExamScheduleRecord value, $Res Function(ExamScheduleRecord) _then) =
      _$ExamScheduleRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String slot,
      String courseName,
      String courseCode,
      String courseType,
      String courseId,
      String examDate,
      String examSession,
      String reportingTime,
      String examTime,
      String venue,
      String seatLocation,
      String seatNo});
}

/// @nodoc
class _$ExamScheduleRecordCopyWithImpl<$Res>
    implements $ExamScheduleRecordCopyWith<$Res> {
  _$ExamScheduleRecordCopyWithImpl(this._self, this._then);

  final ExamScheduleRecord _self;
  final $Res Function(ExamScheduleRecord) _then;

  /// Create a copy of ExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serial = null,
    Object? slot = null,
    Object? courseName = null,
    Object? courseCode = null,
    Object? courseType = null,
    Object? courseId = null,
    Object? examDate = null,
    Object? examSession = null,
    Object? reportingTime = null,
    Object? examTime = null,
    Object? venue = null,
    Object? seatLocation = null,
    Object? seatNo = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
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
      courseId: null == courseId
          ? _self.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      examDate: null == examDate
          ? _self.examDate
          : examDate // ignore: cast_nullable_to_non_nullable
              as String,
      examSession: null == examSession
          ? _self.examSession
          : examSession // ignore: cast_nullable_to_non_nullable
              as String,
      reportingTime: null == reportingTime
          ? _self.reportingTime
          : reportingTime // ignore: cast_nullable_to_non_nullable
              as String,
      examTime: null == examTime
          ? _self.examTime
          : examTime // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _self.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      seatLocation: null == seatLocation
          ? _self.seatLocation
          : seatLocation // ignore: cast_nullable_to_non_nullable
              as String,
      seatNo: null == seatNo
          ? _self.seatNo
          : seatNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExamScheduleRecord].
extension ExamScheduleRecordPatterns on ExamScheduleRecord {
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
    TResult Function(_ExamScheduleRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamScheduleRecord() when $default != null:
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
    TResult Function(_ExamScheduleRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamScheduleRecord():
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
    TResult? Function(_ExamScheduleRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamScheduleRecord() when $default != null:
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
            String slot,
            String courseName,
            String courseCode,
            String courseType,
            String courseId,
            String examDate,
            String examSession,
            String reportingTime,
            String examTime,
            String venue,
            String seatLocation,
            String seatNo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamScheduleRecord() when $default != null:
        return $default(
            _that.serial,
            _that.slot,
            _that.courseName,
            _that.courseCode,
            _that.courseType,
            _that.courseId,
            _that.examDate,
            _that.examSession,
            _that.reportingTime,
            _that.examTime,
            _that.venue,
            _that.seatLocation,
            _that.seatNo);
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
            String slot,
            String courseName,
            String courseCode,
            String courseType,
            String courseId,
            String examDate,
            String examSession,
            String reportingTime,
            String examTime,
            String venue,
            String seatLocation,
            String seatNo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamScheduleRecord():
        return $default(
            _that.serial,
            _that.slot,
            _that.courseName,
            _that.courseCode,
            _that.courseType,
            _that.courseId,
            _that.examDate,
            _that.examSession,
            _that.reportingTime,
            _that.examTime,
            _that.venue,
            _that.seatLocation,
            _that.seatNo);
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
            String slot,
            String courseName,
            String courseCode,
            String courseType,
            String courseId,
            String examDate,
            String examSession,
            String reportingTime,
            String examTime,
            String venue,
            String seatLocation,
            String seatNo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamScheduleRecord() when $default != null:
        return $default(
            _that.serial,
            _that.slot,
            _that.courseName,
            _that.courseCode,
            _that.courseType,
            _that.courseId,
            _that.examDate,
            _that.examSession,
            _that.reportingTime,
            _that.examTime,
            _that.venue,
            _that.seatLocation,
            _that.seatNo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExamScheduleRecord implements ExamScheduleRecord {
  const _ExamScheduleRecord(
      {required this.serial,
      required this.slot,
      required this.courseName,
      required this.courseCode,
      required this.courseType,
      required this.courseId,
      required this.examDate,
      required this.examSession,
      required this.reportingTime,
      required this.examTime,
      required this.venue,
      required this.seatLocation,
      required this.seatNo});
  factory _ExamScheduleRecord.fromJson(Map<String, dynamic> json) =>
      _$ExamScheduleRecordFromJson(json);

  @override
  final String serial;
  @override
  final String slot;
  @override
  final String courseName;
  @override
  final String courseCode;
  @override
  final String courseType;
  @override
  final String courseId;
  @override
  final String examDate;
  @override
  final String examSession;
  @override
  final String reportingTime;
  @override
  final String examTime;
  @override
  final String venue;
  @override
  final String seatLocation;
  @override
  final String seatNo;

  /// Create a copy of ExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExamScheduleRecordCopyWith<_ExamScheduleRecord> get copyWith =>
      __$ExamScheduleRecordCopyWithImpl<_ExamScheduleRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExamScheduleRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExamScheduleRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.examDate, examDate) ||
                other.examDate == examDate) &&
            (identical(other.examSession, examSession) ||
                other.examSession == examSession) &&
            (identical(other.reportingTime, reportingTime) ||
                other.reportingTime == reportingTime) &&
            (identical(other.examTime, examTime) ||
                other.examTime == examTime) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.seatLocation, seatLocation) ||
                other.seatLocation == seatLocation) &&
            (identical(other.seatNo, seatNo) || other.seatNo == seatNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      slot,
      courseName,
      courseCode,
      courseType,
      courseId,
      examDate,
      examSession,
      reportingTime,
      examTime,
      venue,
      seatLocation,
      seatNo);

  @override
  String toString() {
    return 'ExamScheduleRecord(serial: $serial, slot: $slot, courseName: $courseName, courseCode: $courseCode, courseType: $courseType, courseId: $courseId, examDate: $examDate, examSession: $examSession, reportingTime: $reportingTime, examTime: $examTime, venue: $venue, seatLocation: $seatLocation, seatNo: $seatNo)';
  }
}

/// @nodoc
abstract mixin class _$ExamScheduleRecordCopyWith<$Res>
    implements $ExamScheduleRecordCopyWith<$Res> {
  factory _$ExamScheduleRecordCopyWith(
          _ExamScheduleRecord value, $Res Function(_ExamScheduleRecord) _then) =
      __$ExamScheduleRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serial,
      String slot,
      String courseName,
      String courseCode,
      String courseType,
      String courseId,
      String examDate,
      String examSession,
      String reportingTime,
      String examTime,
      String venue,
      String seatLocation,
      String seatNo});
}

/// @nodoc
class __$ExamScheduleRecordCopyWithImpl<$Res>
    implements _$ExamScheduleRecordCopyWith<$Res> {
  __$ExamScheduleRecordCopyWithImpl(this._self, this._then);

  final _ExamScheduleRecord _self;
  final $Res Function(_ExamScheduleRecord) _then;

  /// Create a copy of ExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serial = null,
    Object? slot = null,
    Object? courseName = null,
    Object? courseCode = null,
    Object? courseType = null,
    Object? courseId = null,
    Object? examDate = null,
    Object? examSession = null,
    Object? reportingTime = null,
    Object? examTime = null,
    Object? venue = null,
    Object? seatLocation = null,
    Object? seatNo = null,
  }) {
    return _then(_ExamScheduleRecord(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
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
      courseId: null == courseId
          ? _self.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      examDate: null == examDate
          ? _self.examDate
          : examDate // ignore: cast_nullable_to_non_nullable
              as String,
      examSession: null == examSession
          ? _self.examSession
          : examSession // ignore: cast_nullable_to_non_nullable
              as String,
      reportingTime: null == reportingTime
          ? _self.reportingTime
          : reportingTime // ignore: cast_nullable_to_non_nullable
              as String,
      examTime: null == examTime
          ? _self.examTime
          : examTime // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _self.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      seatLocation: null == seatLocation
          ? _self.seatLocation
          : seatLocation // ignore: cast_nullable_to_non_nullable
              as String,
      seatNo: null == seatNo
          ? _self.seatNo
          : seatNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$PerExamScheduleRecord {
  List<ExamScheduleRecord> get records;
  String get examType;

  /// Create a copy of PerExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PerExamScheduleRecordCopyWith<PerExamScheduleRecord> get copyWith =>
      _$PerExamScheduleRecordCopyWithImpl<PerExamScheduleRecord>(
          this as PerExamScheduleRecord, _$identity);

  /// Serializes this PerExamScheduleRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PerExamScheduleRecord &&
            const DeepCollectionEquality().equals(other.records, records) &&
            (identical(other.examType, examType) ||
                other.examType == examType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(records), examType);

  @override
  String toString() {
    return 'PerExamScheduleRecord(records: $records, examType: $examType)';
  }
}

/// @nodoc
abstract mixin class $PerExamScheduleRecordCopyWith<$Res> {
  factory $PerExamScheduleRecordCopyWith(PerExamScheduleRecord value,
          $Res Function(PerExamScheduleRecord) _then) =
      _$PerExamScheduleRecordCopyWithImpl;
  @useResult
  $Res call({List<ExamScheduleRecord> records, String examType});
}

/// @nodoc
class _$PerExamScheduleRecordCopyWithImpl<$Res>
    implements $PerExamScheduleRecordCopyWith<$Res> {
  _$PerExamScheduleRecordCopyWithImpl(this._self, this._then);

  final PerExamScheduleRecord _self;
  final $Res Function(PerExamScheduleRecord) _then;

  /// Create a copy of PerExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
    Object? examType = null,
  }) {
    return _then(_self.copyWith(
      records: null == records
          ? _self.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<ExamScheduleRecord>,
      examType: null == examType
          ? _self.examType
          : examType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [PerExamScheduleRecord].
extension PerExamScheduleRecordPatterns on PerExamScheduleRecord {
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
    TResult Function(_PerExamScheduleRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PerExamScheduleRecord() when $default != null:
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
    TResult Function(_PerExamScheduleRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerExamScheduleRecord():
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
    TResult? Function(_PerExamScheduleRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerExamScheduleRecord() when $default != null:
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
    TResult Function(List<ExamScheduleRecord> records, String examType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PerExamScheduleRecord() when $default != null:
        return $default(_that.records, _that.examType);
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
    TResult Function(List<ExamScheduleRecord> records, String examType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerExamScheduleRecord():
        return $default(_that.records, _that.examType);
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
    TResult? Function(List<ExamScheduleRecord> records, String examType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerExamScheduleRecord() when $default != null:
        return $default(_that.records, _that.examType);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PerExamScheduleRecord implements PerExamScheduleRecord {
  const _PerExamScheduleRecord(
      {required final List<ExamScheduleRecord> records, required this.examType})
      : _records = records;
  factory _PerExamScheduleRecord.fromJson(Map<String, dynamic> json) =>
      _$PerExamScheduleRecordFromJson(json);

  final List<ExamScheduleRecord> _records;
  @override
  List<ExamScheduleRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  final String examType;

  /// Create a copy of PerExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PerExamScheduleRecordCopyWith<_PerExamScheduleRecord> get copyWith =>
      __$PerExamScheduleRecordCopyWithImpl<_PerExamScheduleRecord>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PerExamScheduleRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PerExamScheduleRecord &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.examType, examType) ||
                other.examType == examType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_records), examType);

  @override
  String toString() {
    return 'PerExamScheduleRecord(records: $records, examType: $examType)';
  }
}

/// @nodoc
abstract mixin class _$PerExamScheduleRecordCopyWith<$Res>
    implements $PerExamScheduleRecordCopyWith<$Res> {
  factory _$PerExamScheduleRecordCopyWith(_PerExamScheduleRecord value,
          $Res Function(_PerExamScheduleRecord) _then) =
      __$PerExamScheduleRecordCopyWithImpl;
  @override
  @useResult
  $Res call({List<ExamScheduleRecord> records, String examType});
}

/// @nodoc
class __$PerExamScheduleRecordCopyWithImpl<$Res>
    implements _$PerExamScheduleRecordCopyWith<$Res> {
  __$PerExamScheduleRecordCopyWithImpl(this._self, this._then);

  final _PerExamScheduleRecord _self;
  final $Res Function(_PerExamScheduleRecord) _then;

  /// Create a copy of PerExamScheduleRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? records = null,
    Object? examType = null,
  }) {
    return _then(_PerExamScheduleRecord(
      records: null == records
          ? _self._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<ExamScheduleRecord>,
      examType: null == examType
          ? _self.examType
          : examType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
