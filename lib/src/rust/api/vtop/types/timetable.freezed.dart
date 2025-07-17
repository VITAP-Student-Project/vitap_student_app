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
mixin _$Timetable {
  List<TimetableClass> get monday;
  List<TimetableClass> get tuesday;
  List<TimetableClass> get wednesday;
  List<TimetableClass> get thursday;
  List<TimetableClass> get friday;
  List<TimetableClass> get saturday;
  List<TimetableClass> get sunday;

  /// Create a copy of Timetable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimetableCopyWith<Timetable> get copyWith =>
      _$TimetableCopyWithImpl<Timetable>(this as Timetable, _$identity);

  /// Serializes this Timetable to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Timetable &&
            const DeepCollectionEquality().equals(other.monday, monday) &&
            const DeepCollectionEquality().equals(other.tuesday, tuesday) &&
            const DeepCollectionEquality().equals(other.wednesday, wednesday) &&
            const DeepCollectionEquality().equals(other.thursday, thursday) &&
            const DeepCollectionEquality().equals(other.friday, friday) &&
            const DeepCollectionEquality().equals(other.saturday, saturday) &&
            const DeepCollectionEquality().equals(other.sunday, sunday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(monday),
      const DeepCollectionEquality().hash(tuesday),
      const DeepCollectionEquality().hash(wednesday),
      const DeepCollectionEquality().hash(thursday),
      const DeepCollectionEquality().hash(friday),
      const DeepCollectionEquality().hash(saturday),
      const DeepCollectionEquality().hash(sunday));

  @override
  String toString() {
    return 'Timetable(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }
}

/// @nodoc
abstract mixin class $TimetableCopyWith<$Res> {
  factory $TimetableCopyWith(Timetable value, $Res Function(Timetable) _then) =
      _$TimetableCopyWithImpl;
  @useResult
  $Res call(
      {List<TimetableClass> monday,
      List<TimetableClass> tuesday,
      List<TimetableClass> wednesday,
      List<TimetableClass> thursday,
      List<TimetableClass> friday,
      List<TimetableClass> saturday,
      List<TimetableClass> sunday});
}

/// @nodoc
class _$TimetableCopyWithImpl<$Res> implements $TimetableCopyWith<$Res> {
  _$TimetableCopyWithImpl(this._self, this._then);

  final Timetable _self;
  final $Res Function(Timetable) _then;

  /// Create a copy of Timetable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monday = null,
    Object? tuesday = null,
    Object? wednesday = null,
    Object? thursday = null,
    Object? friday = null,
    Object? saturday = null,
    Object? sunday = null,
  }) {
    return _then(_self.copyWith(
      monday: null == monday
          ? _self.monday
          : monday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      tuesday: null == tuesday
          ? _self.tuesday
          : tuesday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      wednesday: null == wednesday
          ? _self.wednesday
          : wednesday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      thursday: null == thursday
          ? _self.thursday
          : thursday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      friday: null == friday
          ? _self.friday
          : friday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      saturday: null == saturday
          ? _self.saturday
          : saturday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      sunday: null == sunday
          ? _self.sunday
          : sunday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Timetable].
extension TimetablePatterns on Timetable {
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
    TResult Function(_Timetable value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Timetable() when $default != null:
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
    TResult Function(_Timetable value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timetable():
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
    TResult? Function(_Timetable value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timetable() when $default != null:
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
            List<TimetableClass> monday,
            List<TimetableClass> tuesday,
            List<TimetableClass> wednesday,
            List<TimetableClass> thursday,
            List<TimetableClass> friday,
            List<TimetableClass> saturday,
            List<TimetableClass> sunday)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Timetable() when $default != null:
        return $default(_that.monday, _that.tuesday, _that.wednesday,
            _that.thursday, _that.friday, _that.saturday, _that.sunday);
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
            List<TimetableClass> monday,
            List<TimetableClass> tuesday,
            List<TimetableClass> wednesday,
            List<TimetableClass> thursday,
            List<TimetableClass> friday,
            List<TimetableClass> saturday,
            List<TimetableClass> sunday)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timetable():
        return $default(_that.monday, _that.tuesday, _that.wednesday,
            _that.thursday, _that.friday, _that.saturday, _that.sunday);
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
            List<TimetableClass> monday,
            List<TimetableClass> tuesday,
            List<TimetableClass> wednesday,
            List<TimetableClass> thursday,
            List<TimetableClass> friday,
            List<TimetableClass> saturday,
            List<TimetableClass> sunday)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timetable() when $default != null:
        return $default(_that.monday, _that.tuesday, _that.wednesday,
            _that.thursday, _that.friday, _that.saturday, _that.sunday);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Timetable implements Timetable {
  const _Timetable(
      {required final List<TimetableClass> monday,
      required final List<TimetableClass> tuesday,
      required final List<TimetableClass> wednesday,
      required final List<TimetableClass> thursday,
      required final List<TimetableClass> friday,
      required final List<TimetableClass> saturday,
      required final List<TimetableClass> sunday})
      : _monday = monday,
        _tuesday = tuesday,
        _wednesday = wednesday,
        _thursday = thursday,
        _friday = friday,
        _saturday = saturday,
        _sunday = sunday;
  factory _Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);

  final List<TimetableClass> _monday;
  @override
  List<TimetableClass> get monday {
    if (_monday is EqualUnmodifiableListView) return _monday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monday);
  }

  final List<TimetableClass> _tuesday;
  @override
  List<TimetableClass> get tuesday {
    if (_tuesday is EqualUnmodifiableListView) return _tuesday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tuesday);
  }

  final List<TimetableClass> _wednesday;
  @override
  List<TimetableClass> get wednesday {
    if (_wednesday is EqualUnmodifiableListView) return _wednesday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wednesday);
  }

  final List<TimetableClass> _thursday;
  @override
  List<TimetableClass> get thursday {
    if (_thursday is EqualUnmodifiableListView) return _thursday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_thursday);
  }

  final List<TimetableClass> _friday;
  @override
  List<TimetableClass> get friday {
    if (_friday is EqualUnmodifiableListView) return _friday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friday);
  }

  final List<TimetableClass> _saturday;
  @override
  List<TimetableClass> get saturday {
    if (_saturday is EqualUnmodifiableListView) return _saturday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_saturday);
  }

  final List<TimetableClass> _sunday;
  @override
  List<TimetableClass> get sunday {
    if (_sunday is EqualUnmodifiableListView) return _sunday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sunday);
  }

  /// Create a copy of Timetable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimetableCopyWith<_Timetable> get copyWith =>
      __$TimetableCopyWithImpl<_Timetable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimetableToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Timetable &&
            const DeepCollectionEquality().equals(other._monday, _monday) &&
            const DeepCollectionEquality().equals(other._tuesday, _tuesday) &&
            const DeepCollectionEquality()
                .equals(other._wednesday, _wednesday) &&
            const DeepCollectionEquality().equals(other._thursday, _thursday) &&
            const DeepCollectionEquality().equals(other._friday, _friday) &&
            const DeepCollectionEquality().equals(other._saturday, _saturday) &&
            const DeepCollectionEquality().equals(other._sunday, _sunday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_monday),
      const DeepCollectionEquality().hash(_tuesday),
      const DeepCollectionEquality().hash(_wednesday),
      const DeepCollectionEquality().hash(_thursday),
      const DeepCollectionEquality().hash(_friday),
      const DeepCollectionEquality().hash(_saturday),
      const DeepCollectionEquality().hash(_sunday));

  @override
  String toString() {
    return 'Timetable(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }
}

/// @nodoc
abstract mixin class _$TimetableCopyWith<$Res>
    implements $TimetableCopyWith<$Res> {
  factory _$TimetableCopyWith(
          _Timetable value, $Res Function(_Timetable) _then) =
      __$TimetableCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<TimetableClass> monday,
      List<TimetableClass> tuesday,
      List<TimetableClass> wednesday,
      List<TimetableClass> thursday,
      List<TimetableClass> friday,
      List<TimetableClass> saturday,
      List<TimetableClass> sunday});
}

/// @nodoc
class __$TimetableCopyWithImpl<$Res> implements _$TimetableCopyWith<$Res> {
  __$TimetableCopyWithImpl(this._self, this._then);

  final _Timetable _self;
  final $Res Function(_Timetable) _then;

  /// Create a copy of Timetable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? monday = null,
    Object? tuesday = null,
    Object? wednesday = null,
    Object? thursday = null,
    Object? friday = null,
    Object? saturday = null,
    Object? sunday = null,
  }) {
    return _then(_Timetable(
      monday: null == monday
          ? _self._monday
          : monday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      tuesday: null == tuesday
          ? _self._tuesday
          : tuesday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      wednesday: null == wednesday
          ? _self._wednesday
          : wednesday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      thursday: null == thursday
          ? _self._thursday
          : thursday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      friday: null == friday
          ? _self._friday
          : friday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      saturday: null == saturday
          ? _self._saturday
          : saturday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
      sunday: null == sunday
          ? _self._sunday
          : sunday // ignore: cast_nullable_to_non_nullable
              as List<TimetableClass>,
    ));
  }
}

/// @nodoc
mixin _$TimetableClass {
  String get startTime;
  String get endTime;
  String get courseName;
  String get slot;
  String get venue;
  String get faculty;
  String get courseCode;
  String get courseType;

  /// Create a copy of TimetableClass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimetableClassCopyWith<TimetableClass> get copyWith =>
      _$TimetableClassCopyWithImpl<TimetableClass>(
          this as TimetableClass, _$identity);

  /// Serializes this TimetableClass to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimetableClass &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime, courseName,
      slot, venue, faculty, courseCode, courseType);

  @override
  String toString() {
    return 'TimetableClass(startTime: $startTime, endTime: $endTime, courseName: $courseName, slot: $slot, venue: $venue, faculty: $faculty, courseCode: $courseCode, courseType: $courseType)';
  }
}

/// @nodoc
abstract mixin class $TimetableClassCopyWith<$Res> {
  factory $TimetableClassCopyWith(
          TimetableClass value, $Res Function(TimetableClass) _then) =
      _$TimetableClassCopyWithImpl;
  @useResult
  $Res call(
      {String startTime,
      String endTime,
      String courseName,
      String slot,
      String venue,
      String faculty,
      String courseCode,
      String courseType});
}

/// @nodoc
class _$TimetableClassCopyWithImpl<$Res>
    implements $TimetableClassCopyWith<$Res> {
  _$TimetableClassCopyWithImpl(this._self, this._then);

  final TimetableClass _self;
  final $Res Function(TimetableClass) _then;

  /// Create a copy of TimetableClass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? courseName = null,
    Object? slot = null,
    Object? venue = null,
    Object? faculty = null,
    Object? courseCode = null,
    Object? courseType = null,
  }) {
    return _then(_self.copyWith(
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _self.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _self.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      faculty: null == faculty
          ? _self.faculty
          : faculty // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimetableClass].
extension TimetableClassPatterns on TimetableClass {
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
    TResult Function(_TimetableClass value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimetableClass() when $default != null:
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
    TResult Function(_TimetableClass value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableClass():
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
    TResult? Function(_TimetableClass value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableClass() when $default != null:
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
            String startTime,
            String endTime,
            String courseName,
            String slot,
            String venue,
            String faculty,
            String courseCode,
            String courseType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimetableClass() when $default != null:
        return $default(
            _that.startTime,
            _that.endTime,
            _that.courseName,
            _that.slot,
            _that.venue,
            _that.faculty,
            _that.courseCode,
            _that.courseType);
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
            String startTime,
            String endTime,
            String courseName,
            String slot,
            String venue,
            String faculty,
            String courseCode,
            String courseType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableClass():
        return $default(
            _that.startTime,
            _that.endTime,
            _that.courseName,
            _that.slot,
            _that.venue,
            _that.faculty,
            _that.courseCode,
            _that.courseType);
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
            String startTime,
            String endTime,
            String courseName,
            String slot,
            String venue,
            String faculty,
            String courseCode,
            String courseType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimetableClass() when $default != null:
        return $default(
            _that.startTime,
            _that.endTime,
            _that.courseName,
            _that.slot,
            _that.venue,
            _that.faculty,
            _that.courseCode,
            _that.courseType);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimetableClass implements TimetableClass {
  const _TimetableClass(
      {required this.startTime,
      required this.endTime,
      required this.courseName,
      required this.slot,
      required this.venue,
      required this.faculty,
      required this.courseCode,
      required this.courseType});
  factory _TimetableClass.fromJson(Map<String, dynamic> json) =>
      _$TimetableClassFromJson(json);

  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String courseName;
  @override
  final String slot;
  @override
  final String venue;
  @override
  final String faculty;
  @override
  final String courseCode;
  @override
  final String courseType;

  /// Create a copy of TimetableClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimetableClassCopyWith<_TimetableClass> get copyWith =>
      __$TimetableClassCopyWithImpl<_TimetableClass>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimetableClassToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimetableClass &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime, courseName,
      slot, venue, faculty, courseCode, courseType);

  @override
  String toString() {
    return 'TimetableClass(startTime: $startTime, endTime: $endTime, courseName: $courseName, slot: $slot, venue: $venue, faculty: $faculty, courseCode: $courseCode, courseType: $courseType)';
  }
}

/// @nodoc
abstract mixin class _$TimetableClassCopyWith<$Res>
    implements $TimetableClassCopyWith<$Res> {
  factory _$TimetableClassCopyWith(
          _TimetableClass value, $Res Function(_TimetableClass) _then) =
      __$TimetableClassCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String startTime,
      String endTime,
      String courseName,
      String slot,
      String venue,
      String faculty,
      String courseCode,
      String courseType});
}

/// @nodoc
class __$TimetableClassCopyWithImpl<$Res>
    implements _$TimetableClassCopyWith<$Res> {
  __$TimetableClassCopyWithImpl(this._self, this._then);

  final _TimetableClass _self;
  final $Res Function(_TimetableClass) _then;

  /// Create a copy of TimetableClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? courseName = null,
    Object? slot = null,
    Object? venue = null,
    Object? faculty = null,
    Object? courseCode = null,
    Object? courseType = null,
  }) {
    return _then(_TimetableClass(
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _self.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _self.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      faculty: null == faculty
          ? _self.faculty
          : faculty // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
