// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GradeHistory {
  String get creditsRegistered;
  String get creditsEarned;
  String get cgpa;
  List<GradeCourseHistory> get courses;

  /// Create a copy of GradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GradeHistoryCopyWith<GradeHistory> get copyWith =>
      _$GradeHistoryCopyWithImpl<GradeHistory>(
          this as GradeHistory, _$identity);

  /// Serializes this GradeHistory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GradeHistory &&
            (identical(other.creditsRegistered, creditsRegistered) ||
                other.creditsRegistered == creditsRegistered) &&
            (identical(other.creditsEarned, creditsEarned) ||
                other.creditsEarned == creditsEarned) &&
            (identical(other.cgpa, cgpa) || other.cgpa == cgpa) &&
            const DeepCollectionEquality().equals(other.courses, courses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, creditsRegistered, creditsEarned,
      cgpa, const DeepCollectionEquality().hash(courses));

  @override
  String toString() {
    return 'GradeHistory(creditsRegistered: $creditsRegistered, creditsEarned: $creditsEarned, cgpa: $cgpa, courses: $courses)';
  }
}

/// @nodoc
abstract mixin class $GradeHistoryCopyWith<$Res> {
  factory $GradeHistoryCopyWith(
          GradeHistory value, $Res Function(GradeHistory) _then) =
      _$GradeHistoryCopyWithImpl;
  @useResult
  $Res call(
      {String creditsRegistered,
      String creditsEarned,
      String cgpa,
      List<GradeCourseHistory> courses});
}

/// @nodoc
class _$GradeHistoryCopyWithImpl<$Res> implements $GradeHistoryCopyWith<$Res> {
  _$GradeHistoryCopyWithImpl(this._self, this._then);

  final GradeHistory _self;
  final $Res Function(GradeHistory) _then;

  /// Create a copy of GradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditsRegistered = null,
    Object? creditsEarned = null,
    Object? cgpa = null,
    Object? courses = null,
  }) {
    return _then(_self.copyWith(
      creditsRegistered: null == creditsRegistered
          ? _self.creditsRegistered
          : creditsRegistered // ignore: cast_nullable_to_non_nullable
              as String,
      creditsEarned: null == creditsEarned
          ? _self.creditsEarned
          : creditsEarned // ignore: cast_nullable_to_non_nullable
              as String,
      cgpa: null == cgpa
          ? _self.cgpa
          : cgpa // ignore: cast_nullable_to_non_nullable
              as String,
      courses: null == courses
          ? _self.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<GradeCourseHistory>,
    ));
  }
}

/// Adds pattern-matching-related methods to [GradeHistory].
extension GradeHistoryPatterns on GradeHistory {
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
    TResult Function(_GradeHistory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GradeHistory() when $default != null:
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
    TResult Function(_GradeHistory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GradeHistory():
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
    TResult? Function(_GradeHistory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GradeHistory() when $default != null:
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
    TResult Function(String creditsRegistered, String creditsEarned,
            String cgpa, List<GradeCourseHistory> courses)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GradeHistory() when $default != null:
        return $default(_that.creditsRegistered, _that.creditsEarned,
            _that.cgpa, _that.courses);
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
    TResult Function(String creditsRegistered, String creditsEarned,
            String cgpa, List<GradeCourseHistory> courses)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GradeHistory():
        return $default(_that.creditsRegistered, _that.creditsEarned,
            _that.cgpa, _that.courses);
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
    TResult? Function(String creditsRegistered, String creditsEarned,
            String cgpa, List<GradeCourseHistory> courses)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GradeHistory() when $default != null:
        return $default(_that.creditsRegistered, _that.creditsEarned,
            _that.cgpa, _that.courses);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GradeHistory implements GradeHistory {
  const _GradeHistory(
      {required this.creditsRegistered,
      required this.creditsEarned,
      required this.cgpa,
      required final List<GradeCourseHistory> courses})
      : _courses = courses;
  factory _GradeHistory.fromJson(Map<String, dynamic> json) =>
      _$GradeHistoryFromJson(json);

  @override
  final String creditsRegistered;
  @override
  final String creditsEarned;
  @override
  final String cgpa;
  final List<GradeCourseHistory> _courses;
  @override
  List<GradeCourseHistory> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  /// Create a copy of GradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GradeHistoryCopyWith<_GradeHistory> get copyWith =>
      __$GradeHistoryCopyWithImpl<_GradeHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GradeHistoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GradeHistory &&
            (identical(other.creditsRegistered, creditsRegistered) ||
                other.creditsRegistered == creditsRegistered) &&
            (identical(other.creditsEarned, creditsEarned) ||
                other.creditsEarned == creditsEarned) &&
            (identical(other.cgpa, cgpa) || other.cgpa == cgpa) &&
            const DeepCollectionEquality().equals(other._courses, _courses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, creditsRegistered, creditsEarned,
      cgpa, const DeepCollectionEquality().hash(_courses));

  @override
  String toString() {
    return 'GradeHistory(creditsRegistered: $creditsRegistered, creditsEarned: $creditsEarned, cgpa: $cgpa, courses: $courses)';
  }
}

/// @nodoc
abstract mixin class _$GradeHistoryCopyWith<$Res>
    implements $GradeHistoryCopyWith<$Res> {
  factory _$GradeHistoryCopyWith(
          _GradeHistory value, $Res Function(_GradeHistory) _then) =
      __$GradeHistoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String creditsRegistered,
      String creditsEarned,
      String cgpa,
      List<GradeCourseHistory> courses});
}

/// @nodoc
class __$GradeHistoryCopyWithImpl<$Res>
    implements _$GradeHistoryCopyWith<$Res> {
  __$GradeHistoryCopyWithImpl(this._self, this._then);

  final _GradeHistory _self;
  final $Res Function(_GradeHistory) _then;

  /// Create a copy of GradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? creditsRegistered = null,
    Object? creditsEarned = null,
    Object? cgpa = null,
    Object? courses = null,
  }) {
    return _then(_GradeHistory(
      creditsRegistered: null == creditsRegistered
          ? _self.creditsRegistered
          : creditsRegistered // ignore: cast_nullable_to_non_nullable
              as String,
      creditsEarned: null == creditsEarned
          ? _self.creditsEarned
          : creditsEarned // ignore: cast_nullable_to_non_nullable
              as String,
      cgpa: null == cgpa
          ? _self.cgpa
          : cgpa // ignore: cast_nullable_to_non_nullable
              as String,
      courses: null == courses
          ? _self._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<GradeCourseHistory>,
    ));
  }
}

// dart format on
