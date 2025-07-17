// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Marks {
  String get serialNumber;
  String get courseCode;
  String get courseTitle;
  String get courseType;
  String get faculity;
  String get slot;
  List<MarksRecordEach> get details;

  /// Create a copy of Marks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MarksCopyWith<Marks> get copyWith =>
      _$MarksCopyWithImpl<Marks>(this as Marks, _$identity);

  /// Serializes this Marks to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Marks &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.faculity, faculity) ||
                other.faculity == faculity) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            const DeepCollectionEquality().equals(other.details, details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serialNumber,
      courseCode,
      courseTitle,
      courseType,
      faculity,
      slot,
      const DeepCollectionEquality().hash(details));

  @override
  String toString() {
    return 'Marks(serialNumber: $serialNumber, courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, faculity: $faculity, slot: $slot, details: $details)';
  }
}

/// @nodoc
abstract mixin class $MarksCopyWith<$Res> {
  factory $MarksCopyWith(Marks value, $Res Function(Marks) _then) =
      _$MarksCopyWithImpl;
  @useResult
  $Res call(
      {String serialNumber,
      String courseCode,
      String courseTitle,
      String courseType,
      String faculity,
      String slot,
      List<MarksRecordEach> details});
}

/// @nodoc
class _$MarksCopyWithImpl<$Res> implements $MarksCopyWith<$Res> {
  _$MarksCopyWithImpl(this._self, this._then);

  final Marks _self;
  final $Res Function(Marks) _then;

  /// Create a copy of Marks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serialNumber = null,
    Object? courseCode = null,
    Object? courseTitle = null,
    Object? courseType = null,
    Object? faculity = null,
    Object? slot = null,
    Object? details = null,
  }) {
    return _then(_self.copyWith(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _self.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      faculity: null == faculity
          ? _self.faculity
          : faculity // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as List<MarksRecordEach>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Marks].
extension MarksPatterns on Marks {
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
    TResult Function(_Marks value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Marks() when $default != null:
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
    TResult Function(_Marks value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Marks():
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
    TResult? Function(_Marks value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Marks() when $default != null:
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
            String serialNumber,
            String courseCode,
            String courseTitle,
            String courseType,
            String faculity,
            String slot,
            List<MarksRecordEach> details)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Marks() when $default != null:
        return $default(_that.serialNumber, _that.courseCode, _that.courseTitle,
            _that.courseType, _that.faculity, _that.slot, _that.details);
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
            String serialNumber,
            String courseCode,
            String courseTitle,
            String courseType,
            String faculity,
            String slot,
            List<MarksRecordEach> details)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Marks():
        return $default(_that.serialNumber, _that.courseCode, _that.courseTitle,
            _that.courseType, _that.faculity, _that.slot, _that.details);
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
            String serialNumber,
            String courseCode,
            String courseTitle,
            String courseType,
            String faculity,
            String slot,
            List<MarksRecordEach> details)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Marks() when $default != null:
        return $default(_that.serialNumber, _that.courseCode, _that.courseTitle,
            _that.courseType, _that.faculity, _that.slot, _that.details);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Marks implements Marks {
  const _Marks(
      {required this.serialNumber,
      required this.courseCode,
      required this.courseTitle,
      required this.courseType,
      required this.faculity,
      required this.slot,
      required final List<MarksRecordEach> details})
      : _details = details;
  factory _Marks.fromJson(Map<String, dynamic> json) => _$MarksFromJson(json);

  @override
  final String serialNumber;
  @override
  final String courseCode;
  @override
  final String courseTitle;
  @override
  final String courseType;
  @override
  final String faculity;
  @override
  final String slot;
  final List<MarksRecordEach> _details;
  @override
  List<MarksRecordEach> get details {
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_details);
  }

  /// Create a copy of Marks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MarksCopyWith<_Marks> get copyWith =>
      __$MarksCopyWithImpl<_Marks>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MarksToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Marks &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.faculity, faculity) ||
                other.faculity == faculity) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serialNumber,
      courseCode,
      courseTitle,
      courseType,
      faculity,
      slot,
      const DeepCollectionEquality().hash(_details));

  @override
  String toString() {
    return 'Marks(serialNumber: $serialNumber, courseCode: $courseCode, courseTitle: $courseTitle, courseType: $courseType, faculity: $faculity, slot: $slot, details: $details)';
  }
}

/// @nodoc
abstract mixin class _$MarksCopyWith<$Res> implements $MarksCopyWith<$Res> {
  factory _$MarksCopyWith(_Marks value, $Res Function(_Marks) _then) =
      __$MarksCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serialNumber,
      String courseCode,
      String courseTitle,
      String courseType,
      String faculity,
      String slot,
      List<MarksRecordEach> details});
}

/// @nodoc
class __$MarksCopyWithImpl<$Res> implements _$MarksCopyWith<$Res> {
  __$MarksCopyWithImpl(this._self, this._then);

  final _Marks _self;
  final $Res Function(_Marks) _then;

  /// Create a copy of Marks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serialNumber = null,
    Object? courseCode = null,
    Object? courseTitle = null,
    Object? courseType = null,
    Object? faculity = null,
    Object? slot = null,
    Object? details = null,
  }) {
    return _then(_Marks(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _self.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _self.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _self.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      faculity: null == faculity
          ? _self.faculity
          : faculity // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _self._details
          : details // ignore: cast_nullable_to_non_nullable
              as List<MarksRecordEach>,
    ));
  }
}

/// @nodoc
mixin _$MarksRecordEach {
  String get serialNumber;
  String get markTitle;
  String get maxMark;
  String get weightage;
  String get status;
  String get scoredMark;
  String get weightageMark;
  String get remark;

  /// Create a copy of MarksRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MarksRecordEachCopyWith<MarksRecordEach> get copyWith =>
      _$MarksRecordEachCopyWithImpl<MarksRecordEach>(
          this as MarksRecordEach, _$identity);

  /// Serializes this MarksRecordEach to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MarksRecordEach &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.markTitle, markTitle) ||
                other.markTitle == markTitle) &&
            (identical(other.maxMark, maxMark) || other.maxMark == maxMark) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scoredMark, scoredMark) ||
                other.scoredMark == scoredMark) &&
            (identical(other.weightageMark, weightageMark) ||
                other.weightageMark == weightageMark) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serialNumber, markTitle, maxMark,
      weightage, status, scoredMark, weightageMark, remark);

  @override
  String toString() {
    return 'MarksRecordEach(serialNumber: $serialNumber, markTitle: $markTitle, maxMark: $maxMark, weightage: $weightage, status: $status, scoredMark: $scoredMark, weightageMark: $weightageMark, remark: $remark)';
  }
}

/// @nodoc
abstract mixin class $MarksRecordEachCopyWith<$Res> {
  factory $MarksRecordEachCopyWith(
          MarksRecordEach value, $Res Function(MarksRecordEach) _then) =
      _$MarksRecordEachCopyWithImpl;
  @useResult
  $Res call(
      {String serialNumber,
      String markTitle,
      String maxMark,
      String weightage,
      String status,
      String scoredMark,
      String weightageMark,
      String remark});
}

/// @nodoc
class _$MarksRecordEachCopyWithImpl<$Res>
    implements $MarksRecordEachCopyWith<$Res> {
  _$MarksRecordEachCopyWithImpl(this._self, this._then);

  final MarksRecordEach _self;
  final $Res Function(MarksRecordEach) _then;

  /// Create a copy of MarksRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serialNumber = null,
    Object? markTitle = null,
    Object? maxMark = null,
    Object? weightage = null,
    Object? status = null,
    Object? scoredMark = null,
    Object? weightageMark = null,
    Object? remark = null,
  }) {
    return _then(_self.copyWith(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      markTitle: null == markTitle
          ? _self.markTitle
          : markTitle // ignore: cast_nullable_to_non_nullable
              as String,
      maxMark: null == maxMark
          ? _self.maxMark
          : maxMark // ignore: cast_nullable_to_non_nullable
              as String,
      weightage: null == weightage
          ? _self.weightage
          : weightage // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scoredMark: null == scoredMark
          ? _self.scoredMark
          : scoredMark // ignore: cast_nullable_to_non_nullable
              as String,
      weightageMark: null == weightageMark
          ? _self.weightageMark
          : weightageMark // ignore: cast_nullable_to_non_nullable
              as String,
      remark: null == remark
          ? _self.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MarksRecordEach].
extension MarksRecordEachPatterns on MarksRecordEach {
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
    TResult Function(_MarksRecordEach value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach() when $default != null:
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
    TResult Function(_MarksRecordEach value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach():
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
    TResult? Function(_MarksRecordEach value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach() when $default != null:
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
            String serialNumber,
            String markTitle,
            String maxMark,
            String weightage,
            String status,
            String scoredMark,
            String weightageMark,
            String remark)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach() when $default != null:
        return $default(
            _that.serialNumber,
            _that.markTitle,
            _that.maxMark,
            _that.weightage,
            _that.status,
            _that.scoredMark,
            _that.weightageMark,
            _that.remark);
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
            String serialNumber,
            String markTitle,
            String maxMark,
            String weightage,
            String status,
            String scoredMark,
            String weightageMark,
            String remark)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach():
        return $default(
            _that.serialNumber,
            _that.markTitle,
            _that.maxMark,
            _that.weightage,
            _that.status,
            _that.scoredMark,
            _that.weightageMark,
            _that.remark);
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
            String serialNumber,
            String markTitle,
            String maxMark,
            String weightage,
            String status,
            String scoredMark,
            String weightageMark,
            String remark)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach() when $default != null:
        return $default(
            _that.serialNumber,
            _that.markTitle,
            _that.maxMark,
            _that.weightage,
            _that.status,
            _that.scoredMark,
            _that.weightageMark,
            _that.remark);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MarksRecordEach implements MarksRecordEach {
  const _MarksRecordEach(
      {required this.serialNumber,
      required this.markTitle,
      required this.maxMark,
      required this.weightage,
      required this.status,
      required this.scoredMark,
      required this.weightageMark,
      required this.remark});
  factory _MarksRecordEach.fromJson(Map<String, dynamic> json) =>
      _$MarksRecordEachFromJson(json);

  @override
  final String serialNumber;
  @override
  final String markTitle;
  @override
  final String maxMark;
  @override
  final String weightage;
  @override
  final String status;
  @override
  final String scoredMark;
  @override
  final String weightageMark;
  @override
  final String remark;

  /// Create a copy of MarksRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MarksRecordEachCopyWith<_MarksRecordEach> get copyWith =>
      __$MarksRecordEachCopyWithImpl<_MarksRecordEach>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MarksRecordEachToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MarksRecordEach &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.markTitle, markTitle) ||
                other.markTitle == markTitle) &&
            (identical(other.maxMark, maxMark) || other.maxMark == maxMark) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scoredMark, scoredMark) ||
                other.scoredMark == scoredMark) &&
            (identical(other.weightageMark, weightageMark) ||
                other.weightageMark == weightageMark) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serialNumber, markTitle, maxMark,
      weightage, status, scoredMark, weightageMark, remark);

  @override
  String toString() {
    return 'MarksRecordEach(serialNumber: $serialNumber, markTitle: $markTitle, maxMark: $maxMark, weightage: $weightage, status: $status, scoredMark: $scoredMark, weightageMark: $weightageMark, remark: $remark)';
  }
}

/// @nodoc
abstract mixin class _$MarksRecordEachCopyWith<$Res>
    implements $MarksRecordEachCopyWith<$Res> {
  factory _$MarksRecordEachCopyWith(
          _MarksRecordEach value, $Res Function(_MarksRecordEach) _then) =
      __$MarksRecordEachCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serialNumber,
      String markTitle,
      String maxMark,
      String weightage,
      String status,
      String scoredMark,
      String weightageMark,
      String remark});
}

/// @nodoc
class __$MarksRecordEachCopyWithImpl<$Res>
    implements _$MarksRecordEachCopyWith<$Res> {
  __$MarksRecordEachCopyWithImpl(this._self, this._then);

  final _MarksRecordEach _self;
  final $Res Function(_MarksRecordEach) _then;

  /// Create a copy of MarksRecordEach
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serialNumber = null,
    Object? markTitle = null,
    Object? maxMark = null,
    Object? weightage = null,
    Object? status = null,
    Object? scoredMark = null,
    Object? weightageMark = null,
    Object? remark = null,
  }) {
    return _then(_MarksRecordEach(
      serialNumber: null == serialNumber
          ? _self.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      markTitle: null == markTitle
          ? _self.markTitle
          : markTitle // ignore: cast_nullable_to_non_nullable
              as String,
      maxMark: null == maxMark
          ? _self.maxMark
          : maxMark // ignore: cast_nullable_to_non_nullable
              as String,
      weightage: null == weightage
          ? _self.weightage
          : weightage // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scoredMark: null == scoredMark
          ? _self.scoredMark
          : scoredMark // ignore: cast_nullable_to_non_nullable
              as String,
      weightageMark: null == weightageMark
          ? _self.weightageMark
          : weightageMark // ignore: cast_nullable_to_non_nullable
              as String,
      remark: null == remark
          ? _self.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
