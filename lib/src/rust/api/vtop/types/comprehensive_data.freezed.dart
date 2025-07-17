// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comprehensive_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComprehensiveDataResponse {
  StudentProfile get profile;
  List<AttendanceRecord> get attendance;
  Timetable get timetable;
  List<PerExamScheduleRecord> get examSchedule;
  List<GradeCourseHistory> get gradeCourseHistory;
  List<Marks> get marks;

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComprehensiveDataResponseCopyWith<ComprehensiveDataResponse> get copyWith =>
      _$ComprehensiveDataResponseCopyWithImpl<ComprehensiveDataResponse>(
          this as ComprehensiveDataResponse, _$identity);

  /// Serializes this ComprehensiveDataResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComprehensiveDataResponse &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality()
                .equals(other.attendance, attendance) &&
            (identical(other.timetable, timetable) ||
                other.timetable == timetable) &&
            const DeepCollectionEquality()
                .equals(other.examSchedule, examSchedule) &&
            const DeepCollectionEquality()
                .equals(other.gradeCourseHistory, gradeCourseHistory) &&
            const DeepCollectionEquality().equals(other.marks, marks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      profile,
      const DeepCollectionEquality().hash(attendance),
      timetable,
      const DeepCollectionEquality().hash(examSchedule),
      const DeepCollectionEquality().hash(gradeCourseHistory),
      const DeepCollectionEquality().hash(marks));

  @override
  String toString() {
    return 'ComprehensiveDataResponse(profile: $profile, attendance: $attendance, timetable: $timetable, examSchedule: $examSchedule, gradeCourseHistory: $gradeCourseHistory, marks: $marks)';
  }
}

/// @nodoc
abstract mixin class $ComprehensiveDataResponseCopyWith<$Res> {
  factory $ComprehensiveDataResponseCopyWith(ComprehensiveDataResponse value,
          $Res Function(ComprehensiveDataResponse) _then) =
      _$ComprehensiveDataResponseCopyWithImpl;
  @useResult
  $Res call(
      {StudentProfile profile,
      List<AttendanceRecord> attendance,
      Timetable timetable,
      List<PerExamScheduleRecord> examSchedule,
      List<GradeCourseHistory> gradeCourseHistory,
      List<Marks> marks});

  $StudentProfileCopyWith<$Res> get profile;
  $TimetableCopyWith<$Res> get timetable;
}

/// @nodoc
class _$ComprehensiveDataResponseCopyWithImpl<$Res>
    implements $ComprehensiveDataResponseCopyWith<$Res> {
  _$ComprehensiveDataResponseCopyWithImpl(this._self, this._then);

  final ComprehensiveDataResponse _self;
  final $Res Function(ComprehensiveDataResponse) _then;

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? attendance = null,
    Object? timetable = null,
    Object? examSchedule = null,
    Object? gradeCourseHistory = null,
    Object? marks = null,
  }) {
    return _then(_self.copyWith(
      profile: null == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as StudentProfile,
      attendance: null == attendance
          ? _self.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
      timetable: null == timetable
          ? _self.timetable
          : timetable // ignore: cast_nullable_to_non_nullable
              as Timetable,
      examSchedule: null == examSchedule
          ? _self.examSchedule
          : examSchedule // ignore: cast_nullable_to_non_nullable
              as List<PerExamScheduleRecord>,
      gradeCourseHistory: null == gradeCourseHistory
          ? _self.gradeCourseHistory
          : gradeCourseHistory // ignore: cast_nullable_to_non_nullable
              as List<GradeCourseHistory>,
      marks: null == marks
          ? _self.marks
          : marks // ignore: cast_nullable_to_non_nullable
              as List<Marks>,
    ));
  }

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudentProfileCopyWith<$Res> get profile {
    return $StudentProfileCopyWith<$Res>(_self.profile, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimetableCopyWith<$Res> get timetable {
    return $TimetableCopyWith<$Res>(_self.timetable, (value) {
      return _then(_self.copyWith(timetable: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ComprehensiveDataResponse].
extension ComprehensiveDataResponsePatterns on ComprehensiveDataResponse {
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
    TResult Function(_ComprehensiveDataResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComprehensiveDataResponse() when $default != null:
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
    TResult Function(_ComprehensiveDataResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComprehensiveDataResponse():
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
    TResult? Function(_ComprehensiveDataResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComprehensiveDataResponse() when $default != null:
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
            StudentProfile profile,
            List<AttendanceRecord> attendance,
            Timetable timetable,
            List<PerExamScheduleRecord> examSchedule,
            List<GradeCourseHistory> gradeCourseHistory,
            List<Marks> marks)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComprehensiveDataResponse() when $default != null:
        return $default(_that.profile, _that.attendance, _that.timetable,
            _that.examSchedule, _that.gradeCourseHistory, _that.marks);
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
            StudentProfile profile,
            List<AttendanceRecord> attendance,
            Timetable timetable,
            List<PerExamScheduleRecord> examSchedule,
            List<GradeCourseHistory> gradeCourseHistory,
            List<Marks> marks)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComprehensiveDataResponse():
        return $default(_that.profile, _that.attendance, _that.timetable,
            _that.examSchedule, _that.gradeCourseHistory, _that.marks);
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
            StudentProfile profile,
            List<AttendanceRecord> attendance,
            Timetable timetable,
            List<PerExamScheduleRecord> examSchedule,
            List<GradeCourseHistory> gradeCourseHistory,
            List<Marks> marks)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComprehensiveDataResponse() when $default != null:
        return $default(_that.profile, _that.attendance, _that.timetable,
            _that.examSchedule, _that.gradeCourseHistory, _that.marks);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComprehensiveDataResponse implements ComprehensiveDataResponse {
  const _ComprehensiveDataResponse(
      {required this.profile,
      required final List<AttendanceRecord> attendance,
      required this.timetable,
      required final List<PerExamScheduleRecord> examSchedule,
      required final List<GradeCourseHistory> gradeCourseHistory,
      required final List<Marks> marks})
      : _attendance = attendance,
        _examSchedule = examSchedule,
        _gradeCourseHistory = gradeCourseHistory,
        _marks = marks;
  factory _ComprehensiveDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveDataResponseFromJson(json);

  @override
  final StudentProfile profile;
  final List<AttendanceRecord> _attendance;
  @override
  List<AttendanceRecord> get attendance {
    if (_attendance is EqualUnmodifiableListView) return _attendance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendance);
  }

  @override
  final Timetable timetable;
  final List<PerExamScheduleRecord> _examSchedule;
  @override
  List<PerExamScheduleRecord> get examSchedule {
    if (_examSchedule is EqualUnmodifiableListView) return _examSchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examSchedule);
  }

  final List<GradeCourseHistory> _gradeCourseHistory;
  @override
  List<GradeCourseHistory> get gradeCourseHistory {
    if (_gradeCourseHistory is EqualUnmodifiableListView)
      return _gradeCourseHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gradeCourseHistory);
  }

  final List<Marks> _marks;
  @override
  List<Marks> get marks {
    if (_marks is EqualUnmodifiableListView) return _marks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_marks);
  }

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComprehensiveDataResponseCopyWith<_ComprehensiveDataResponse>
      get copyWith =>
          __$ComprehensiveDataResponseCopyWithImpl<_ComprehensiveDataResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComprehensiveDataResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComprehensiveDataResponse &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality()
                .equals(other._attendance, _attendance) &&
            (identical(other.timetable, timetable) ||
                other.timetable == timetable) &&
            const DeepCollectionEquality()
                .equals(other._examSchedule, _examSchedule) &&
            const DeepCollectionEquality()
                .equals(other._gradeCourseHistory, _gradeCourseHistory) &&
            const DeepCollectionEquality().equals(other._marks, _marks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      profile,
      const DeepCollectionEquality().hash(_attendance),
      timetable,
      const DeepCollectionEquality().hash(_examSchedule),
      const DeepCollectionEquality().hash(_gradeCourseHistory),
      const DeepCollectionEquality().hash(_marks));

  @override
  String toString() {
    return 'ComprehensiveDataResponse(profile: $profile, attendance: $attendance, timetable: $timetable, examSchedule: $examSchedule, gradeCourseHistory: $gradeCourseHistory, marks: $marks)';
  }
}

/// @nodoc
abstract mixin class _$ComprehensiveDataResponseCopyWith<$Res>
    implements $ComprehensiveDataResponseCopyWith<$Res> {
  factory _$ComprehensiveDataResponseCopyWith(_ComprehensiveDataResponse value,
          $Res Function(_ComprehensiveDataResponse) _then) =
      __$ComprehensiveDataResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {StudentProfile profile,
      List<AttendanceRecord> attendance,
      Timetable timetable,
      List<PerExamScheduleRecord> examSchedule,
      List<GradeCourseHistory> gradeCourseHistory,
      List<Marks> marks});

  @override
  $StudentProfileCopyWith<$Res> get profile;
  @override
  $TimetableCopyWith<$Res> get timetable;
}

/// @nodoc
class __$ComprehensiveDataResponseCopyWithImpl<$Res>
    implements _$ComprehensiveDataResponseCopyWith<$Res> {
  __$ComprehensiveDataResponseCopyWithImpl(this._self, this._then);

  final _ComprehensiveDataResponse _self;
  final $Res Function(_ComprehensiveDataResponse) _then;

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? profile = null,
    Object? attendance = null,
    Object? timetable = null,
    Object? examSchedule = null,
    Object? gradeCourseHistory = null,
    Object? marks = null,
  }) {
    return _then(_ComprehensiveDataResponse(
      profile: null == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as StudentProfile,
      attendance: null == attendance
          ? _self._attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
      timetable: null == timetable
          ? _self.timetable
          : timetable // ignore: cast_nullable_to_non_nullable
              as Timetable,
      examSchedule: null == examSchedule
          ? _self._examSchedule
          : examSchedule // ignore: cast_nullable_to_non_nullable
              as List<PerExamScheduleRecord>,
      gradeCourseHistory: null == gradeCourseHistory
          ? _self._gradeCourseHistory
          : gradeCourseHistory // ignore: cast_nullable_to_non_nullable
              as List<GradeCourseHistory>,
      marks: null == marks
          ? _self._marks
          : marks // ignore: cast_nullable_to_non_nullable
              as List<Marks>,
    ));
  }

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudentProfileCopyWith<$Res> get profile {
    return $StudentProfileCopyWith<$Res>(_self.profile, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }

  /// Create a copy of ComprehensiveDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimetableCopyWith<$Res> get timetable {
    return $TimetableCopyWith<$Res>(_self.timetable, (value) {
      return _then(_self.copyWith(timetable: value));
    });
  }
}

// dart format on
