// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SemesterData {
  List<SemesterInfo> get semesters;
  BigInt get updateTime;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SemesterDataCopyWith<SemesterData> get copyWith =>
      _$SemesterDataCopyWithImpl<SemesterData>(
          this as SemesterData, _$identity);

  /// Serializes this SemesterData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SemesterData &&
            const DeepCollectionEquality().equals(other.semesters, semesters) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(semesters), updateTime);

  @override
  String toString() {
    return 'SemesterData(semesters: $semesters, updateTime: $updateTime)';
  }
}

/// @nodoc
abstract mixin class $SemesterDataCopyWith<$Res> {
  factory $SemesterDataCopyWith(
          SemesterData value, $Res Function(SemesterData) _then) =
      _$SemesterDataCopyWithImpl;
  @useResult
  $Res call({List<SemesterInfo> semesters, BigInt updateTime});
}

/// @nodoc
class _$SemesterDataCopyWithImpl<$Res> implements $SemesterDataCopyWith<$Res> {
  _$SemesterDataCopyWithImpl(this._self, this._then);

  final SemesterData _self;
  final $Res Function(SemesterData) _then;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? semesters = null,
    Object? updateTime = null,
  }) {
    return _then(_self.copyWith(
      semesters: null == semesters
          ? _self.semesters
          : semesters // ignore: cast_nullable_to_non_nullable
              as List<SemesterInfo>,
      updateTime: null == updateTime
          ? _self.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// Adds pattern-matching-related methods to [SemesterData].
extension SemesterDataPatterns on SemesterData {
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
    TResult Function(_SemesterData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
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
    TResult Function(_SemesterData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData():
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
    TResult? Function(_SemesterData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
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
    TResult Function(List<SemesterInfo> semesters, BigInt updateTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
        return $default(_that.semesters, _that.updateTime);
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
    TResult Function(List<SemesterInfo> semesters, BigInt updateTime) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData():
        return $default(_that.semesters, _that.updateTime);
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
    TResult? Function(List<SemesterInfo> semesters, BigInt updateTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
        return $default(_that.semesters, _that.updateTime);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SemesterData implements SemesterData {
  const _SemesterData(
      {required final List<SemesterInfo> semesters, required this.updateTime})
      : _semesters = semesters;
  factory _SemesterData.fromJson(Map<String, dynamic> json) =>
      _$SemesterDataFromJson(json);

  final List<SemesterInfo> _semesters;
  @override
  List<SemesterInfo> get semesters {
    if (_semesters is EqualUnmodifiableListView) return _semesters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_semesters);
  }

  @override
  final BigInt updateTime;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SemesterDataCopyWith<_SemesterData> get copyWith =>
      __$SemesterDataCopyWithImpl<_SemesterData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SemesterDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SemesterData &&
            const DeepCollectionEquality()
                .equals(other._semesters, _semesters) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_semesters), updateTime);

  @override
  String toString() {
    return 'SemesterData(semesters: $semesters, updateTime: $updateTime)';
  }
}

/// @nodoc
abstract mixin class _$SemesterDataCopyWith<$Res>
    implements $SemesterDataCopyWith<$Res> {
  factory _$SemesterDataCopyWith(
          _SemesterData value, $Res Function(_SemesterData) _then) =
      __$SemesterDataCopyWithImpl;
  @override
  @useResult
  $Res call({List<SemesterInfo> semesters, BigInt updateTime});
}

/// @nodoc
class __$SemesterDataCopyWithImpl<$Res>
    implements _$SemesterDataCopyWith<$Res> {
  __$SemesterDataCopyWithImpl(this._self, this._then);

  final _SemesterData _self;
  final $Res Function(_SemesterData) _then;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? semesters = null,
    Object? updateTime = null,
  }) {
    return _then(_SemesterData(
      semesters: null == semesters
          ? _self._semesters
          : semesters // ignore: cast_nullable_to_non_nullable
              as List<SemesterInfo>,
      updateTime: null == updateTime
          ? _self.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
mixin _$SemesterInfo {
  String get id;
  String get name;

  /// Create a copy of SemesterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SemesterInfoCopyWith<SemesterInfo> get copyWith =>
      _$SemesterInfoCopyWithImpl<SemesterInfo>(
          this as SemesterInfo, _$identity);

  /// Serializes this SemesterInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SemesterInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'SemesterInfo(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $SemesterInfoCopyWith<$Res> {
  factory $SemesterInfoCopyWith(
          SemesterInfo value, $Res Function(SemesterInfo) _then) =
      _$SemesterInfoCopyWithImpl;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$SemesterInfoCopyWithImpl<$Res> implements $SemesterInfoCopyWith<$Res> {
  _$SemesterInfoCopyWithImpl(this._self, this._then);

  final SemesterInfo _self;
  final $Res Function(SemesterInfo) _then;

  /// Create a copy of SemesterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SemesterInfo].
extension SemesterInfoPatterns on SemesterInfo {
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
    TResult Function(_SemesterInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SemesterInfo() when $default != null:
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
    TResult Function(_SemesterInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterInfo():
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
    TResult? Function(_SemesterInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterInfo() when $default != null:
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
    TResult Function(String id, String name)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SemesterInfo() when $default != null:
        return $default(_that.id, _that.name);
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
    TResult Function(String id, String name) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterInfo():
        return $default(_that.id, _that.name);
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
    TResult? Function(String id, String name)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterInfo() when $default != null:
        return $default(_that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SemesterInfo implements SemesterInfo {
  const _SemesterInfo({required this.id, required this.name});
  factory _SemesterInfo.fromJson(Map<String, dynamic> json) =>
      _$SemesterInfoFromJson(json);

  @override
  final String id;
  @override
  final String name;

  /// Create a copy of SemesterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SemesterInfoCopyWith<_SemesterInfo> get copyWith =>
      __$SemesterInfoCopyWithImpl<_SemesterInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SemesterInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SemesterInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'SemesterInfo(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$SemesterInfoCopyWith<$Res>
    implements $SemesterInfoCopyWith<$Res> {
  factory _$SemesterInfoCopyWith(
          _SemesterInfo value, $Res Function(_SemesterInfo) _then) =
      __$SemesterInfoCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$SemesterInfoCopyWithImpl<$Res>
    implements _$SemesterInfoCopyWith<$Res> {
  __$SemesterInfoCopyWithImpl(this._self, this._then);

  final _SemesterInfo _self;
  final $Res Function(_SemesterInfo) _then;

  /// Create a copy of SemesterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_SemesterInfo(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
