// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hostel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HostelLeaveData {
  List<LeaveRecord> get records;
  BigInt get updateTime;

  /// Create a copy of HostelLeaveData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HostelLeaveDataCopyWith<HostelLeaveData> get copyWith =>
      _$HostelLeaveDataCopyWithImpl<HostelLeaveData>(
          this as HostelLeaveData, _$identity);

  /// Serializes this HostelLeaveData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HostelLeaveData &&
            const DeepCollectionEquality().equals(other.records, records) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(records), updateTime);

  @override
  String toString() {
    return 'HostelLeaveData(records: $records, updateTime: $updateTime)';
  }
}

/// @nodoc
abstract mixin class $HostelLeaveDataCopyWith<$Res> {
  factory $HostelLeaveDataCopyWith(
          HostelLeaveData value, $Res Function(HostelLeaveData) _then) =
      _$HostelLeaveDataCopyWithImpl;
  @useResult
  $Res call({List<LeaveRecord> records, BigInt updateTime});
}

/// @nodoc
class _$HostelLeaveDataCopyWithImpl<$Res>
    implements $HostelLeaveDataCopyWith<$Res> {
  _$HostelLeaveDataCopyWithImpl(this._self, this._then);

  final HostelLeaveData _self;
  final $Res Function(HostelLeaveData) _then;

  /// Create a copy of HostelLeaveData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
    Object? updateTime = null,
  }) {
    return _then(_self.copyWith(
      records: null == records
          ? _self.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<LeaveRecord>,
      updateTime: null == updateTime
          ? _self.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// Adds pattern-matching-related methods to [HostelLeaveData].
extension HostelLeaveDataPatterns on HostelLeaveData {
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
    TResult Function(_HostelLeaveData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HostelLeaveData() when $default != null:
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
    TResult Function(_HostelLeaveData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelLeaveData():
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
    TResult? Function(_HostelLeaveData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelLeaveData() when $default != null:
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
    TResult Function(List<LeaveRecord> records, BigInt updateTime)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HostelLeaveData() when $default != null:
        return $default(_that.records, _that.updateTime);
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
    TResult Function(List<LeaveRecord> records, BigInt updateTime) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelLeaveData():
        return $default(_that.records, _that.updateTime);
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
    TResult? Function(List<LeaveRecord> records, BigInt updateTime)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelLeaveData() when $default != null:
        return $default(_that.records, _that.updateTime);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HostelLeaveData implements HostelLeaveData {
  const _HostelLeaveData(
      {required final List<LeaveRecord> records, required this.updateTime})
      : _records = records;
  factory _HostelLeaveData.fromJson(Map<String, dynamic> json) =>
      _$HostelLeaveDataFromJson(json);

  final List<LeaveRecord> _records;
  @override
  List<LeaveRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  final BigInt updateTime;

  /// Create a copy of HostelLeaveData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HostelLeaveDataCopyWith<_HostelLeaveData> get copyWith =>
      __$HostelLeaveDataCopyWithImpl<_HostelLeaveData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HostelLeaveDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HostelLeaveData &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_records), updateTime);

  @override
  String toString() {
    return 'HostelLeaveData(records: $records, updateTime: $updateTime)';
  }
}

/// @nodoc
abstract mixin class _$HostelLeaveDataCopyWith<$Res>
    implements $HostelLeaveDataCopyWith<$Res> {
  factory _$HostelLeaveDataCopyWith(
          _HostelLeaveData value, $Res Function(_HostelLeaveData) _then) =
      __$HostelLeaveDataCopyWithImpl;
  @override
  @useResult
  $Res call({List<LeaveRecord> records, BigInt updateTime});
}

/// @nodoc
class __$HostelLeaveDataCopyWithImpl<$Res>
    implements _$HostelLeaveDataCopyWith<$Res> {
  __$HostelLeaveDataCopyWithImpl(this._self, this._then);

  final _HostelLeaveData _self;
  final $Res Function(_HostelLeaveData) _then;

  /// Create a copy of HostelLeaveData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? records = null,
    Object? updateTime = null,
  }) {
    return _then(_HostelLeaveData(
      records: null == records
          ? _self._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<LeaveRecord>,
      updateTime: null == updateTime
          ? _self.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
mixin _$HostelOutingData {
  List<OutingRecord> get records;
  BigInt get updateTime;

  /// Create a copy of HostelOutingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HostelOutingDataCopyWith<HostelOutingData> get copyWith =>
      _$HostelOutingDataCopyWithImpl<HostelOutingData>(
          this as HostelOutingData, _$identity);

  /// Serializes this HostelOutingData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HostelOutingData &&
            const DeepCollectionEquality().equals(other.records, records) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(records), updateTime);

  @override
  String toString() {
    return 'HostelOutingData(records: $records, updateTime: $updateTime)';
  }
}

/// @nodoc
abstract mixin class $HostelOutingDataCopyWith<$Res> {
  factory $HostelOutingDataCopyWith(
          HostelOutingData value, $Res Function(HostelOutingData) _then) =
      _$HostelOutingDataCopyWithImpl;
  @useResult
  $Res call({List<OutingRecord> records, BigInt updateTime});
}

/// @nodoc
class _$HostelOutingDataCopyWithImpl<$Res>
    implements $HostelOutingDataCopyWith<$Res> {
  _$HostelOutingDataCopyWithImpl(this._self, this._then);

  final HostelOutingData _self;
  final $Res Function(HostelOutingData) _then;

  /// Create a copy of HostelOutingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
    Object? updateTime = null,
  }) {
    return _then(_self.copyWith(
      records: null == records
          ? _self.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<OutingRecord>,
      updateTime: null == updateTime
          ? _self.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// Adds pattern-matching-related methods to [HostelOutingData].
extension HostelOutingDataPatterns on HostelOutingData {
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
    TResult Function(_HostelOutingData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HostelOutingData() when $default != null:
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
    TResult Function(_HostelOutingData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelOutingData():
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
    TResult? Function(_HostelOutingData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelOutingData() when $default != null:
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
    TResult Function(List<OutingRecord> records, BigInt updateTime)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HostelOutingData() when $default != null:
        return $default(_that.records, _that.updateTime);
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
    TResult Function(List<OutingRecord> records, BigInt updateTime) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelOutingData():
        return $default(_that.records, _that.updateTime);
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
    TResult? Function(List<OutingRecord> records, BigInt updateTime)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HostelOutingData() when $default != null:
        return $default(_that.records, _that.updateTime);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HostelOutingData implements HostelOutingData {
  const _HostelOutingData(
      {required final List<OutingRecord> records, required this.updateTime})
      : _records = records;
  factory _HostelOutingData.fromJson(Map<String, dynamic> json) =>
      _$HostelOutingDataFromJson(json);

  final List<OutingRecord> _records;
  @override
  List<OutingRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  final BigInt updateTime;

  /// Create a copy of HostelOutingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HostelOutingDataCopyWith<_HostelOutingData> get copyWith =>
      __$HostelOutingDataCopyWithImpl<_HostelOutingData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HostelOutingDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HostelOutingData &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_records), updateTime);

  @override
  String toString() {
    return 'HostelOutingData(records: $records, updateTime: $updateTime)';
  }
}

/// @nodoc
abstract mixin class _$HostelOutingDataCopyWith<$Res>
    implements $HostelOutingDataCopyWith<$Res> {
  factory _$HostelOutingDataCopyWith(
          _HostelOutingData value, $Res Function(_HostelOutingData) _then) =
      __$HostelOutingDataCopyWithImpl;
  @override
  @useResult
  $Res call({List<OutingRecord> records, BigInt updateTime});
}

/// @nodoc
class __$HostelOutingDataCopyWithImpl<$Res>
    implements _$HostelOutingDataCopyWith<$Res> {
  __$HostelOutingDataCopyWithImpl(this._self, this._then);

  final _HostelOutingData _self;
  final $Res Function(_HostelOutingData) _then;

  /// Create a copy of HostelOutingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? records = null,
    Object? updateTime = null,
  }) {
    return _then(_HostelOutingData(
      records: null == records
          ? _self._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<OutingRecord>,
      updateTime: null == updateTime
          ? _self.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
mixin _$LeaveRecord {
  String get serial;
  String get registrationNumber;
  String get placeOfVisit;
  String get purposeOfVisit;
  String get fromDate;
  String get fromTime;
  String get toDate;
  String get toTime;
  String get status;
  bool get canDownload;
  String get leaveId;

  /// Create a copy of LeaveRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveRecordCopyWith<LeaveRecord> get copyWith =>
      _$LeaveRecordCopyWithImpl<LeaveRecord>(this as LeaveRecord, _$identity);

  /// Serializes this LeaveRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.placeOfVisit, placeOfVisit) ||
                other.placeOfVisit == placeOfVisit) &&
            (identical(other.purposeOfVisit, purposeOfVisit) ||
                other.purposeOfVisit == purposeOfVisit) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.fromTime, fromTime) ||
                other.fromTime == fromTime) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.toTime, toTime) || other.toTime == toTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.canDownload, canDownload) ||
                other.canDownload == canDownload) &&
            (identical(other.leaveId, leaveId) || other.leaveId == leaveId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      registrationNumber,
      placeOfVisit,
      purposeOfVisit,
      fromDate,
      fromTime,
      toDate,
      toTime,
      status,
      canDownload,
      leaveId);

  @override
  String toString() {
    return 'LeaveRecord(serial: $serial, registrationNumber: $registrationNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, fromDate: $fromDate, fromTime: $fromTime, toDate: $toDate, toTime: $toTime, status: $status, canDownload: $canDownload, leaveId: $leaveId)';
  }
}

/// @nodoc
abstract mixin class $LeaveRecordCopyWith<$Res> {
  factory $LeaveRecordCopyWith(
          LeaveRecord value, $Res Function(LeaveRecord) _then) =
      _$LeaveRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String registrationNumber,
      String placeOfVisit,
      String purposeOfVisit,
      String fromDate,
      String fromTime,
      String toDate,
      String toTime,
      String status,
      bool canDownload,
      String leaveId});
}

/// @nodoc
class _$LeaveRecordCopyWithImpl<$Res> implements $LeaveRecordCopyWith<$Res> {
  _$LeaveRecordCopyWithImpl(this._self, this._then);

  final LeaveRecord _self;
  final $Res Function(LeaveRecord) _then;

  /// Create a copy of LeaveRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serial = null,
    Object? registrationNumber = null,
    Object? placeOfVisit = null,
    Object? purposeOfVisit = null,
    Object? fromDate = null,
    Object? fromTime = null,
    Object? toDate = null,
    Object? toTime = null,
    Object? status = null,
    Object? canDownload = null,
    Object? leaveId = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      registrationNumber: null == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfVisit: null == placeOfVisit
          ? _self.placeOfVisit
          : placeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      purposeOfVisit: null == purposeOfVisit
          ? _self.purposeOfVisit
          : purposeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: null == fromDate
          ? _self.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      fromTime: null == fromTime
          ? _self.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _self.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      toTime: null == toTime
          ? _self.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      canDownload: null == canDownload
          ? _self.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
      leaveId: null == leaveId
          ? _self.leaveId
          : leaveId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaveRecord].
extension LeaveRecordPatterns on LeaveRecord {
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
    TResult Function(_LeaveRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveRecord() when $default != null:
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
    TResult Function(_LeaveRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRecord():
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
    TResult? Function(_LeaveRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRecord() when $default != null:
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
            String registrationNumber,
            String placeOfVisit,
            String purposeOfVisit,
            String fromDate,
            String fromTime,
            String toDate,
            String toTime,
            String status,
            bool canDownload,
            String leaveId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveRecord() when $default != null:
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.fromDate,
            _that.fromTime,
            _that.toDate,
            _that.toTime,
            _that.status,
            _that.canDownload,
            _that.leaveId);
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
            String registrationNumber,
            String placeOfVisit,
            String purposeOfVisit,
            String fromDate,
            String fromTime,
            String toDate,
            String toTime,
            String status,
            bool canDownload,
            String leaveId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRecord():
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.fromDate,
            _that.fromTime,
            _that.toDate,
            _that.toTime,
            _that.status,
            _that.canDownload,
            _that.leaveId);
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
            String registrationNumber,
            String placeOfVisit,
            String purposeOfVisit,
            String fromDate,
            String fromTime,
            String toDate,
            String toTime,
            String status,
            bool canDownload,
            String leaveId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRecord() when $default != null:
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.fromDate,
            _that.fromTime,
            _that.toDate,
            _that.toTime,
            _that.status,
            _that.canDownload,
            _that.leaveId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveRecord implements LeaveRecord {
  const _LeaveRecord(
      {required this.serial,
      required this.registrationNumber,
      required this.placeOfVisit,
      required this.purposeOfVisit,
      required this.fromDate,
      required this.fromTime,
      required this.toDate,
      required this.toTime,
      required this.status,
      required this.canDownload,
      required this.leaveId});
  factory _LeaveRecord.fromJson(Map<String, dynamic> json) =>
      _$LeaveRecordFromJson(json);

  @override
  final String serial;
  @override
  final String registrationNumber;
  @override
  final String placeOfVisit;
  @override
  final String purposeOfVisit;
  @override
  final String fromDate;
  @override
  final String fromTime;
  @override
  final String toDate;
  @override
  final String toTime;
  @override
  final String status;
  @override
  final bool canDownload;
  @override
  final String leaveId;

  /// Create a copy of LeaveRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveRecordCopyWith<_LeaveRecord> get copyWith =>
      __$LeaveRecordCopyWithImpl<_LeaveRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.placeOfVisit, placeOfVisit) ||
                other.placeOfVisit == placeOfVisit) &&
            (identical(other.purposeOfVisit, purposeOfVisit) ||
                other.purposeOfVisit == purposeOfVisit) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.fromTime, fromTime) ||
                other.fromTime == fromTime) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.toTime, toTime) || other.toTime == toTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.canDownload, canDownload) ||
                other.canDownload == canDownload) &&
            (identical(other.leaveId, leaveId) || other.leaveId == leaveId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      registrationNumber,
      placeOfVisit,
      purposeOfVisit,
      fromDate,
      fromTime,
      toDate,
      toTime,
      status,
      canDownload,
      leaveId);

  @override
  String toString() {
    return 'LeaveRecord(serial: $serial, registrationNumber: $registrationNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, fromDate: $fromDate, fromTime: $fromTime, toDate: $toDate, toTime: $toTime, status: $status, canDownload: $canDownload, leaveId: $leaveId)';
  }
}

/// @nodoc
abstract mixin class _$LeaveRecordCopyWith<$Res>
    implements $LeaveRecordCopyWith<$Res> {
  factory _$LeaveRecordCopyWith(
          _LeaveRecord value, $Res Function(_LeaveRecord) _then) =
      __$LeaveRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serial,
      String registrationNumber,
      String placeOfVisit,
      String purposeOfVisit,
      String fromDate,
      String fromTime,
      String toDate,
      String toTime,
      String status,
      bool canDownload,
      String leaveId});
}

/// @nodoc
class __$LeaveRecordCopyWithImpl<$Res> implements _$LeaveRecordCopyWith<$Res> {
  __$LeaveRecordCopyWithImpl(this._self, this._then);

  final _LeaveRecord _self;
  final $Res Function(_LeaveRecord) _then;

  /// Create a copy of LeaveRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serial = null,
    Object? registrationNumber = null,
    Object? placeOfVisit = null,
    Object? purposeOfVisit = null,
    Object? fromDate = null,
    Object? fromTime = null,
    Object? toDate = null,
    Object? toTime = null,
    Object? status = null,
    Object? canDownload = null,
    Object? leaveId = null,
  }) {
    return _then(_LeaveRecord(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      registrationNumber: null == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfVisit: null == placeOfVisit
          ? _self.placeOfVisit
          : placeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      purposeOfVisit: null == purposeOfVisit
          ? _self.purposeOfVisit
          : purposeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: null == fromDate
          ? _self.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      fromTime: null == fromTime
          ? _self.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _self.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      toTime: null == toTime
          ? _self.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      canDownload: null == canDownload
          ? _self.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
      leaveId: null == leaveId
          ? _self.leaveId
          : leaveId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$OutingRecord {
  String get serial;
  String get registrationNumber;
  String get hostelBlock;
  String get roomNumber;
  String get placeOfVisit;
  String get purposeOfVisit;
  String get time;
  String get contactNumber;
  String get parentContactNumber;
  String get date;
  String get bookingId;
  String get status;
  bool get canDownload;

  /// Create a copy of OutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutingRecordCopyWith<OutingRecord> get copyWith =>
      _$OutingRecordCopyWithImpl<OutingRecord>(
          this as OutingRecord, _$identity);

  /// Serializes this OutingRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OutingRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.hostelBlock, hostelBlock) ||
                other.hostelBlock == hostelBlock) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.placeOfVisit, placeOfVisit) ||
                other.placeOfVisit == placeOfVisit) &&
            (identical(other.purposeOfVisit, purposeOfVisit) ||
                other.purposeOfVisit == purposeOfVisit) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.parentContactNumber, parentContactNumber) ||
                other.parentContactNumber == parentContactNumber) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.canDownload, canDownload) ||
                other.canDownload == canDownload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      registrationNumber,
      hostelBlock,
      roomNumber,
      placeOfVisit,
      purposeOfVisit,
      time,
      contactNumber,
      parentContactNumber,
      date,
      bookingId,
      status,
      canDownload);

  @override
  String toString() {
    return 'OutingRecord(serial: $serial, registrationNumber: $registrationNumber, hostelBlock: $hostelBlock, roomNumber: $roomNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, time: $time, contactNumber: $contactNumber, parentContactNumber: $parentContactNumber, date: $date, bookingId: $bookingId, status: $status, canDownload: $canDownload)';
  }
}

/// @nodoc
abstract mixin class $OutingRecordCopyWith<$Res> {
  factory $OutingRecordCopyWith(
          OutingRecord value, $Res Function(OutingRecord) _then) =
      _$OutingRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String registrationNumber,
      String hostelBlock,
      String roomNumber,
      String placeOfVisit,
      String purposeOfVisit,
      String time,
      String contactNumber,
      String parentContactNumber,
      String date,
      String bookingId,
      String status,
      bool canDownload});
}

/// @nodoc
class _$OutingRecordCopyWithImpl<$Res> implements $OutingRecordCopyWith<$Res> {
  _$OutingRecordCopyWithImpl(this._self, this._then);

  final OutingRecord _self;
  final $Res Function(OutingRecord) _then;

  /// Create a copy of OutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serial = null,
    Object? registrationNumber = null,
    Object? hostelBlock = null,
    Object? roomNumber = null,
    Object? placeOfVisit = null,
    Object? purposeOfVisit = null,
    Object? time = null,
    Object? contactNumber = null,
    Object? parentContactNumber = null,
    Object? date = null,
    Object? bookingId = null,
    Object? status = null,
    Object? canDownload = null,
  }) {
    return _then(_self.copyWith(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      registrationNumber: null == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      hostelBlock: null == hostelBlock
          ? _self.hostelBlock
          : hostelBlock // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _self.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfVisit: null == placeOfVisit
          ? _self.placeOfVisit
          : placeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      purposeOfVisit: null == purposeOfVisit
          ? _self.purposeOfVisit
          : purposeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _self.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      parentContactNumber: null == parentContactNumber
          ? _self.parentContactNumber
          : parentContactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _self.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      canDownload: null == canDownload
          ? _self.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [OutingRecord].
extension OutingRecordPatterns on OutingRecord {
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
    TResult Function(_OutingRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutingRecord() when $default != null:
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
    TResult Function(_OutingRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingRecord():
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
    TResult? Function(_OutingRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingRecord() when $default != null:
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
            String registrationNumber,
            String hostelBlock,
            String roomNumber,
            String placeOfVisit,
            String purposeOfVisit,
            String time,
            String contactNumber,
            String parentContactNumber,
            String date,
            String bookingId,
            String status,
            bool canDownload)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutingRecord() when $default != null:
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.hostelBlock,
            _that.roomNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.time,
            _that.contactNumber,
            _that.parentContactNumber,
            _that.date,
            _that.bookingId,
            _that.status,
            _that.canDownload);
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
            String registrationNumber,
            String hostelBlock,
            String roomNumber,
            String placeOfVisit,
            String purposeOfVisit,
            String time,
            String contactNumber,
            String parentContactNumber,
            String date,
            String bookingId,
            String status,
            bool canDownload)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingRecord():
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.hostelBlock,
            _that.roomNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.time,
            _that.contactNumber,
            _that.parentContactNumber,
            _that.date,
            _that.bookingId,
            _that.status,
            _that.canDownload);
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
            String registrationNumber,
            String hostelBlock,
            String roomNumber,
            String placeOfVisit,
            String purposeOfVisit,
            String time,
            String contactNumber,
            String parentContactNumber,
            String date,
            String bookingId,
            String status,
            bool canDownload)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutingRecord() when $default != null:
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.hostelBlock,
            _that.roomNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.time,
            _that.contactNumber,
            _that.parentContactNumber,
            _that.date,
            _that.bookingId,
            _that.status,
            _that.canDownload);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OutingRecord implements OutingRecord {
  const _OutingRecord(
      {required this.serial,
      required this.registrationNumber,
      required this.hostelBlock,
      required this.roomNumber,
      required this.placeOfVisit,
      required this.purposeOfVisit,
      required this.time,
      required this.contactNumber,
      required this.parentContactNumber,
      required this.date,
      required this.bookingId,
      required this.status,
      required this.canDownload});
  factory _OutingRecord.fromJson(Map<String, dynamic> json) =>
      _$OutingRecordFromJson(json);

  @override
  final String serial;
  @override
  final String registrationNumber;
  @override
  final String hostelBlock;
  @override
  final String roomNumber;
  @override
  final String placeOfVisit;
  @override
  final String purposeOfVisit;
  @override
  final String time;
  @override
  final String contactNumber;
  @override
  final String parentContactNumber;
  @override
  final String date;
  @override
  final String bookingId;
  @override
  final String status;
  @override
  final bool canDownload;

  /// Create a copy of OutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutingRecordCopyWith<_OutingRecord> get copyWith =>
      __$OutingRecordCopyWithImpl<_OutingRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OutingRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OutingRecord &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.hostelBlock, hostelBlock) ||
                other.hostelBlock == hostelBlock) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.placeOfVisit, placeOfVisit) ||
                other.placeOfVisit == placeOfVisit) &&
            (identical(other.purposeOfVisit, purposeOfVisit) ||
                other.purposeOfVisit == purposeOfVisit) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.parentContactNumber, parentContactNumber) ||
                other.parentContactNumber == parentContactNumber) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.canDownload, canDownload) ||
                other.canDownload == canDownload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serial,
      registrationNumber,
      hostelBlock,
      roomNumber,
      placeOfVisit,
      purposeOfVisit,
      time,
      contactNumber,
      parentContactNumber,
      date,
      bookingId,
      status,
      canDownload);

  @override
  String toString() {
    return 'OutingRecord(serial: $serial, registrationNumber: $registrationNumber, hostelBlock: $hostelBlock, roomNumber: $roomNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, time: $time, contactNumber: $contactNumber, parentContactNumber: $parentContactNumber, date: $date, bookingId: $bookingId, status: $status, canDownload: $canDownload)';
  }
}

/// @nodoc
abstract mixin class _$OutingRecordCopyWith<$Res>
    implements $OutingRecordCopyWith<$Res> {
  factory _$OutingRecordCopyWith(
          _OutingRecord value, $Res Function(_OutingRecord) _then) =
      __$OutingRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serial,
      String registrationNumber,
      String hostelBlock,
      String roomNumber,
      String placeOfVisit,
      String purposeOfVisit,
      String time,
      String contactNumber,
      String parentContactNumber,
      String date,
      String bookingId,
      String status,
      bool canDownload});
}

/// @nodoc
class __$OutingRecordCopyWithImpl<$Res>
    implements _$OutingRecordCopyWith<$Res> {
  __$OutingRecordCopyWithImpl(this._self, this._then);

  final _OutingRecord _self;
  final $Res Function(_OutingRecord) _then;

  /// Create a copy of OutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serial = null,
    Object? registrationNumber = null,
    Object? hostelBlock = null,
    Object? roomNumber = null,
    Object? placeOfVisit = null,
    Object? purposeOfVisit = null,
    Object? time = null,
    Object? contactNumber = null,
    Object? parentContactNumber = null,
    Object? date = null,
    Object? bookingId = null,
    Object? status = null,
    Object? canDownload = null,
  }) {
    return _then(_OutingRecord(
      serial: null == serial
          ? _self.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      registrationNumber: null == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String,
      hostelBlock: null == hostelBlock
          ? _self.hostelBlock
          : hostelBlock // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _self.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfVisit: null == placeOfVisit
          ? _self.placeOfVisit
          : placeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      purposeOfVisit: null == purposeOfVisit
          ? _self.purposeOfVisit
          : purposeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _self.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      parentContactNumber: null == parentContactNumber
          ? _self.parentContactNumber
          : parentContactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _self.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      canDownload: null == canDownload
          ? _self.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
