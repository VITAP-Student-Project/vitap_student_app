// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_outing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneralOutingRecord {
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

  /// Create a copy of GeneralOutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeneralOutingRecordCopyWith<GeneralOutingRecord> get copyWith =>
      _$GeneralOutingRecordCopyWithImpl<GeneralOutingRecord>(
          this as GeneralOutingRecord, _$identity);

  /// Serializes this GeneralOutingRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeneralOutingRecord &&
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
    return 'GeneralOutingRecord(serial: $serial, registrationNumber: $registrationNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, fromDate: $fromDate, fromTime: $fromTime, toDate: $toDate, toTime: $toTime, status: $status, canDownload: $canDownload, leaveId: $leaveId)';
  }
}

/// @nodoc
abstract mixin class $GeneralOutingRecordCopyWith<$Res> {
  factory $GeneralOutingRecordCopyWith(
          GeneralOutingRecord value, $Res Function(GeneralOutingRecord) _then) =
      _$GeneralOutingRecordCopyWithImpl;
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
class _$GeneralOutingRecordCopyWithImpl<$Res>
    implements $GeneralOutingRecordCopyWith<$Res> {
  _$GeneralOutingRecordCopyWithImpl(this._self, this._then);

  final GeneralOutingRecord _self;
  final $Res Function(GeneralOutingRecord) _then;

  /// Create a copy of GeneralOutingRecord
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

/// Adds pattern-matching-related methods to [GeneralOutingRecord].
extension GeneralOutingRecordPatterns on GeneralOutingRecord {
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
    TResult Function(_GeneralOutingRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeneralOutingRecord() when $default != null:
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
    TResult Function(_GeneralOutingRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralOutingRecord():
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
    TResult? Function(_GeneralOutingRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralOutingRecord() when $default != null:
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
      case _GeneralOutingRecord() when $default != null:
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
      case _GeneralOutingRecord():
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
      case _GeneralOutingRecord() when $default != null:
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
class _GeneralOutingRecord implements GeneralOutingRecord {
  const _GeneralOutingRecord(
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
  factory _GeneralOutingRecord.fromJson(Map<String, dynamic> json) =>
      _$GeneralOutingRecordFromJson(json);

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

  /// Create a copy of GeneralOutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeneralOutingRecordCopyWith<_GeneralOutingRecord> get copyWith =>
      __$GeneralOutingRecordCopyWithImpl<_GeneralOutingRecord>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeneralOutingRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeneralOutingRecord &&
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
    return 'GeneralOutingRecord(serial: $serial, registrationNumber: $registrationNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, fromDate: $fromDate, fromTime: $fromTime, toDate: $toDate, toTime: $toTime, status: $status, canDownload: $canDownload, leaveId: $leaveId)';
  }
}

/// @nodoc
abstract mixin class _$GeneralOutingRecordCopyWith<$Res>
    implements $GeneralOutingRecordCopyWith<$Res> {
  factory _$GeneralOutingRecordCopyWith(_GeneralOutingRecord value,
          $Res Function(_GeneralOutingRecord) _then) =
      __$GeneralOutingRecordCopyWithImpl;
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
class __$GeneralOutingRecordCopyWithImpl<$Res>
    implements _$GeneralOutingRecordCopyWith<$Res> {
  __$GeneralOutingRecordCopyWithImpl(this._self, this._then);

  final _GeneralOutingRecord _self;
  final $Res Function(_GeneralOutingRecord) _then;

  /// Create a copy of GeneralOutingRecord
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
    return _then(_GeneralOutingRecord(
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

// dart format on
