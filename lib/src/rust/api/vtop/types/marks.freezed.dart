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
mixin _$MarksRecord {
  String get serial;
  String get coursecode;
  String get coursetitle;
  String get coursetype;
  String get faculity;
  String get slot;
  List<MarksRecordEach> get marks;

  /// Create a copy of MarksRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MarksRecordCopyWith<MarksRecord> get copyWith =>
      _$MarksRecordCopyWithImpl<MarksRecord>(this as MarksRecord, _$identity);

  /// Serializes this MarksRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MarksRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.coursecode, coursecode) ||
                other.coursecode == coursecode) &&
            (identical(other.coursetitle, coursetitle) ||
                other.coursetitle == coursetitle) &&
            (identical(other.coursetype, coursetype) ||
                other.coursetype == coursetype) &&
            (identical(other.faculity, faculity) ||
                other.faculity == faculity) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            const DeepCollectionEquality().equals(other.marks, marks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serial, coursecode, coursetitle,
      coursetype, faculity, slot, const DeepCollectionEquality().hash(marks));

  @override
  String toString() {
    return 'MarksRecord(serial: $serial, coursecode: $coursecode, coursetitle: $coursetitle, coursetype: $coursetype, faculity: $faculity, slot: $slot, marks: $marks)';
  }
}

/// @nodoc
abstract mixin class $MarksRecordCopyWith<$Res> {
  factory $MarksRecordCopyWith(
          MarksRecord value, $Res Function(MarksRecord) _then) =
      _$MarksRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String coursecode,
      String coursetitle,
      String coursetype,
      String faculity,
      String slot,
      List<MarksRecordEach> marks});
}

/// @nodoc
class _$MarksRecordCopyWithImpl<$Res> implements $MarksRecordCopyWith<$Res> {
  _$MarksRecordCopyWithImpl(this._self, this._then);

  final MarksRecord _self;
  final $Res Function(MarksRecord) _then;

  /// Create a copy of MarksRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serial = null,
    Object? coursecode = null,
    Object? coursetitle = null,
    Object? coursetype = null,
    Object? faculity = null,
    Object? slot = null,
    Object? marks = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      coursecode: null == coursecode
          ? _self.coursecode
          : coursecode // ignore: cast_nullable_to_non_nullable
              as String,
      coursetitle: null == coursetitle
          ? _self.coursetitle
          : coursetitle // ignore: cast_nullable_to_non_nullable
              as String,
      coursetype: null == coursetype
          ? _self.coursetype
          : coursetype // ignore: cast_nullable_to_non_nullable
              as String,
      faculity: null == faculity
          ? _self.faculity
          : faculity // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      marks: null == marks
          ? _self.marks
          : marks // ignore: cast_nullable_to_non_nullable
              as List<MarksRecordEach>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MarksRecord].
extension MarksRecordPatterns on MarksRecord {
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
    TResult Function(_MarksRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MarksRecord() when $default != null:
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
    TResult Function(_MarksRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecord():
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
    TResult? Function(_MarksRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecord() when $default != null:
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
            String coursecode,
            String coursetitle,
            String coursetype,
            String faculity,
            String slot,
            List<MarksRecordEach> marks)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MarksRecord() when $default != null:
        return $default(_that.serial, _that.coursecode, _that.coursetitle,
            _that.coursetype, _that.faculity, _that.slot, _that.marks);
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
            String coursecode,
            String coursetitle,
            String coursetype,
            String faculity,
            String slot,
            List<MarksRecordEach> marks)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecord():
        return $default(_that.serial, _that.coursecode, _that.coursetitle,
            _that.coursetype, _that.faculity, _that.slot, _that.marks);
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
            String coursecode,
            String coursetitle,
            String coursetype,
            String faculity,
            String slot,
            List<MarksRecordEach> marks)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecord() when $default != null:
        return $default(_that.serial, _that.coursecode, _that.coursetitle,
            _that.coursetype, _that.faculity, _that.slot, _that.marks);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MarksRecord implements MarksRecord {
  const _MarksRecord(
      {required this.serial,
      required this.coursecode,
      required this.coursetitle,
      required this.coursetype,
      required this.faculity,
      required this.slot,
      required final List<MarksRecordEach> marks})
      : _marks = marks;
  factory _MarksRecord.fromJson(Map<String, dynamic> json) =>
      _$MarksRecordFromJson(json);

  @override
  final String serial;
  @override
  final String coursecode;
  @override
  final String coursetitle;
  @override
  final String coursetype;
  @override
  final String faculity;
  @override
  final String slot;
  final List<MarksRecordEach> _marks;
  @override
  List<MarksRecordEach> get marks {
    if (_marks is EqualUnmodifiableListView) return _marks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_marks);
  }

  /// Create a copy of MarksRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MarksRecordCopyWith<_MarksRecord> get copyWith =>
      __$MarksRecordCopyWithImpl<_MarksRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MarksRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MarksRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.coursecode, coursecode) ||
                other.coursecode == coursecode) &&
            (identical(other.coursetitle, coursetitle) ||
                other.coursetitle == coursetitle) &&
            (identical(other.coursetype, coursetype) ||
                other.coursetype == coursetype) &&
            (identical(other.faculity, faculity) ||
                other.faculity == faculity) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            const DeepCollectionEquality().equals(other._marks, _marks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serial, coursecode, coursetitle,
      coursetype, faculity, slot, const DeepCollectionEquality().hash(_marks));

  @override
  String toString() {
    return 'MarksRecord(serial: $serial, coursecode: $coursecode, coursetitle: $coursetitle, coursetype: $coursetype, faculity: $faculity, slot: $slot, marks: $marks)';
  }
}

/// @nodoc
abstract mixin class _$MarksRecordCopyWith<$Res>
    implements $MarksRecordCopyWith<$Res> {
  factory _$MarksRecordCopyWith(
          _MarksRecord value, $Res Function(_MarksRecord) _then) =
      __$MarksRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serial,
      String coursecode,
      String coursetitle,
      String coursetype,
      String faculity,
      String slot,
      List<MarksRecordEach> marks});
}

/// @nodoc
class __$MarksRecordCopyWithImpl<$Res> implements _$MarksRecordCopyWith<$Res> {
  __$MarksRecordCopyWithImpl(this._self, this._then);

  final _MarksRecord _self;
  final $Res Function(_MarksRecord) _then;

  /// Create a copy of MarksRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serial = null,
    Object? coursecode = null,
    Object? coursetitle = null,
    Object? coursetype = null,
    Object? faculity = null,
    Object? slot = null,
    Object? marks = null,
  }) {
    return _then(_MarksRecord(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      coursecode: null == coursecode
          ? _self.coursecode
          : coursecode // ignore: cast_nullable_to_non_nullable
              as String,
      coursetitle: null == coursetitle
          ? _self.coursetitle
          : coursetitle // ignore: cast_nullable_to_non_nullable
              as String,
      coursetype: null == coursetype
          ? _self.coursetype
          : coursetype // ignore: cast_nullable_to_non_nullable
              as String,
      faculity: null == faculity
          ? _self.faculity
          : faculity // ignore: cast_nullable_to_non_nullable
              as String,
      slot: null == slot
          ? _self.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      marks: null == marks
          ? _self._marks
          : marks // ignore: cast_nullable_to_non_nullable
              as List<MarksRecordEach>,
    ));
  }
}

/// @nodoc
mixin _$MarksRecordEach {
  String get serial;
  String get markstitle;
  String get maxmarks;
  String get weightage;
  String get status;
  String get scoredmark;
  String get weightagemark;
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
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.markstitle, markstitle) ||
                other.markstitle == markstitle) &&
            (identical(other.maxmarks, maxmarks) ||
                other.maxmarks == maxmarks) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scoredmark, scoredmark) ||
                other.scoredmark == scoredmark) &&
            (identical(other.weightagemark, weightagemark) ||
                other.weightagemark == weightagemark) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serial, markstitle, maxmarks,
      weightage, status, scoredmark, weightagemark, remark);

  @override
  String toString() {
    return 'MarksRecordEach(serial: $serial, markstitle: $markstitle, maxmarks: $maxmarks, weightage: $weightage, status: $status, scoredmark: $scoredmark, weightagemark: $weightagemark, remark: $remark)';
  }
}

/// @nodoc
abstract mixin class $MarksRecordEachCopyWith<$Res> {
  factory $MarksRecordEachCopyWith(
          MarksRecordEach value, $Res Function(MarksRecordEach) _then) =
      _$MarksRecordEachCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String markstitle,
      String maxmarks,
      String weightage,
      String status,
      String scoredmark,
      String weightagemark,
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
    Object? serial = null,
    Object? markstitle = null,
    Object? maxmarks = null,
    Object? weightage = null,
    Object? status = null,
    Object? scoredmark = null,
    Object? weightagemark = null,
    Object? remark = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      markstitle: null == markstitle
          ? _self.markstitle
          : markstitle // ignore: cast_nullable_to_non_nullable
              as String,
      maxmarks: null == maxmarks
          ? _self.maxmarks
          : maxmarks // ignore: cast_nullable_to_non_nullable
              as String,
      weightage: null == weightage
          ? _self.weightage
          : weightage // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scoredmark: null == scoredmark
          ? _self.scoredmark
          : scoredmark // ignore: cast_nullable_to_non_nullable
              as String,
      weightagemark: null == weightagemark
          ? _self.weightagemark
          : weightagemark // ignore: cast_nullable_to_non_nullable
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
            String serial,
            String markstitle,
            String maxmarks,
            String weightage,
            String status,
            String scoredmark,
            String weightagemark,
            String remark)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach() when $default != null:
        return $default(
            _that.serial,
            _that.markstitle,
            _that.maxmarks,
            _that.weightage,
            _that.status,
            _that.scoredmark,
            _that.weightagemark,
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
            String serial,
            String markstitle,
            String maxmarks,
            String weightage,
            String status,
            String scoredmark,
            String weightagemark,
            String remark)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach():
        return $default(
            _that.serial,
            _that.markstitle,
            _that.maxmarks,
            _that.weightage,
            _that.status,
            _that.scoredmark,
            _that.weightagemark,
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
            String serial,
            String markstitle,
            String maxmarks,
            String weightage,
            String status,
            String scoredmark,
            String weightagemark,
            String remark)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarksRecordEach() when $default != null:
        return $default(
            _that.serial,
            _that.markstitle,
            _that.maxmarks,
            _that.weightage,
            _that.status,
            _that.scoredmark,
            _that.weightagemark,
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
      {required this.serial,
      required this.markstitle,
      required this.maxmarks,
      required this.weightage,
      required this.status,
      required this.scoredmark,
      required this.weightagemark,
      required this.remark});
  factory _MarksRecordEach.fromJson(Map<String, dynamic> json) =>
      _$MarksRecordEachFromJson(json);

  @override
  final String serial;
  @override
  final String markstitle;
  @override
  final String maxmarks;
  @override
  final String weightage;
  @override
  final String status;
  @override
  final String scoredmark;
  @override
  final String weightagemark;
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
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.markstitle, markstitle) ||
                other.markstitle == markstitle) &&
            (identical(other.maxmarks, maxmarks) ||
                other.maxmarks == maxmarks) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scoredmark, scoredmark) ||
                other.scoredmark == scoredmark) &&
            (identical(other.weightagemark, weightagemark) ||
                other.weightagemark == weightagemark) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serial, markstitle, maxmarks,
      weightage, status, scoredmark, weightagemark, remark);

  @override
  String toString() {
    return 'MarksRecordEach(serial: $serial, markstitle: $markstitle, maxmarks: $maxmarks, weightage: $weightage, status: $status, scoredmark: $scoredmark, weightagemark: $weightagemark, remark: $remark)';
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
      {String serial,
      String markstitle,
      String maxmarks,
      String weightage,
      String status,
      String scoredmark,
      String weightagemark,
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
    Object? serial = null,
    Object? markstitle = null,
    Object? maxmarks = null,
    Object? weightage = null,
    Object? status = null,
    Object? scoredmark = null,
    Object? weightagemark = null,
    Object? remark = null,
  }) {
    return _then(_MarksRecordEach(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      markstitle: null == markstitle
          ? _self.markstitle
          : markstitle // ignore: cast_nullable_to_non_nullable
              as String,
      maxmarks: null == maxmarks
          ? _self.maxmarks
          : maxmarks // ignore: cast_nullable_to_non_nullable
              as String,
      weightage: null == weightage
          ? _self.weightage
          : weightage // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scoredmark: null == scoredmark
          ? _self.scoredmark
          : scoredmark // ignore: cast_nullable_to_non_nullable
              as String,
      weightagemark: null == weightagemark
          ? _self.weightagemark
          : weightagemark // ignore: cast_nullable_to_non_nullable
              as String,
      remark: null == remark
          ? _self.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
