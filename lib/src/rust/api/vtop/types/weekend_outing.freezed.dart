// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekend_outing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeekendOutingRecord {
  String get serial;
  String get registrationNumber;
  String get hostelBlock;
  String get roomNumber;
  String get placeOfVisit;
  String get purposeOfVisit;
  String get time;
  String get date;
  String get bookingId;
  String get status;
  bool get canDownload;

  /// Create a copy of WeekendOutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeekendOutingRecordCopyWith<WeekendOutingRecord> get copyWith =>
      _$WeekendOutingRecordCopyWithImpl<WeekendOutingRecord>(
          this as WeekendOutingRecord, _$identity);

  /// Serializes this WeekendOutingRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WeekendOutingRecord &&
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
      date,
      bookingId,
      status,
      canDownload);

  @override
  String toString() {
    return 'WeekendOutingRecord(serial: $serial, registrationNumber: $registrationNumber, hostelBlock: $hostelBlock, roomNumber: $roomNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, time: $time, date: $date, bookingId: $bookingId, status: $status, canDownload: $canDownload)';
  }
}

/// @nodoc
abstract mixin class $WeekendOutingRecordCopyWith<$Res> {
  factory $WeekendOutingRecordCopyWith(
          WeekendOutingRecord value, $Res Function(WeekendOutingRecord) _then) =
      _$WeekendOutingRecordCopyWithImpl;
  @useResult
  $Res call(
      {String serial,
      String registrationNumber,
      String hostelBlock,
      String roomNumber,
      String placeOfVisit,
      String purposeOfVisit,
      String time,
      String date,
      String bookingId,
      String status,
      bool canDownload});
}

/// @nodoc
class _$WeekendOutingRecordCopyWithImpl<$Res>
    implements $WeekendOutingRecordCopyWith<$Res> {
  _$WeekendOutingRecordCopyWithImpl(this._self, this._then);

  final WeekendOutingRecord _self;
  final $Res Function(WeekendOutingRecord) _then;

  /// Create a copy of WeekendOutingRecord
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

/// Adds pattern-matching-related methods to [WeekendOutingRecord].
extension WeekendOutingRecordPatterns on WeekendOutingRecord {
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
    TResult Function(_WeekendOutingRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeekendOutingRecord() when $default != null:
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
    TResult Function(_WeekendOutingRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekendOutingRecord():
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
    TResult? Function(_WeekendOutingRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekendOutingRecord() when $default != null:
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
            String date,
            String bookingId,
            String status,
            bool canDownload)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeekendOutingRecord() when $default != null:
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.hostelBlock,
            _that.roomNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.time,
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
            String date,
            String bookingId,
            String status,
            bool canDownload)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekendOutingRecord():
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.hostelBlock,
            _that.roomNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.time,
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
            String date,
            String bookingId,
            String status,
            bool canDownload)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekendOutingRecord() when $default != null:
        return $default(
            _that.serial,
            _that.registrationNumber,
            _that.hostelBlock,
            _that.roomNumber,
            _that.placeOfVisit,
            _that.purposeOfVisit,
            _that.time,
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
class _WeekendOutingRecord implements WeekendOutingRecord {
  const _WeekendOutingRecord(
      {required this.serial,
      required this.registrationNumber,
      required this.hostelBlock,
      required this.roomNumber,
      required this.placeOfVisit,
      required this.purposeOfVisit,
      required this.time,
      required this.date,
      required this.bookingId,
      required this.status,
      required this.canDownload});
  factory _WeekendOutingRecord.fromJson(Map<String, dynamic> json) =>
      _$WeekendOutingRecordFromJson(json);

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
  final String date;
  @override
  final String bookingId;
  @override
  final String status;
  @override
  final bool canDownload;

  /// Create a copy of WeekendOutingRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeekendOutingRecordCopyWith<_WeekendOutingRecord> get copyWith =>
      __$WeekendOutingRecordCopyWithImpl<_WeekendOutingRecord>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WeekendOutingRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeekendOutingRecord &&
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
      date,
      bookingId,
      status,
      canDownload);

  @override
  String toString() {
    return 'WeekendOutingRecord(serial: $serial, registrationNumber: $registrationNumber, hostelBlock: $hostelBlock, roomNumber: $roomNumber, placeOfVisit: $placeOfVisit, purposeOfVisit: $purposeOfVisit, time: $time, date: $date, bookingId: $bookingId, status: $status, canDownload: $canDownload)';
  }
}

/// @nodoc
abstract mixin class _$WeekendOutingRecordCopyWith<$Res>
    implements $WeekendOutingRecordCopyWith<$Res> {
  factory _$WeekendOutingRecordCopyWith(_WeekendOutingRecord value,
          $Res Function(_WeekendOutingRecord) _then) =
      __$WeekendOutingRecordCopyWithImpl;
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
      String date,
      String bookingId,
      String status,
      bool canDownload});
}

/// @nodoc
class __$WeekendOutingRecordCopyWithImpl<$Res>
    implements _$WeekendOutingRecordCopyWith<$Res> {
  __$WeekendOutingRecordCopyWithImpl(this._self, this._then);

  final _WeekendOutingRecord _self;
  final $Res Function(_WeekendOutingRecord) _then;

  /// Create a copy of WeekendOutingRecord
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
    Object? date = null,
    Object? bookingId = null,
    Object? status = null,
    Object? canDownload = null,
  }) {
    return _then(_WeekendOutingRecord(
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
