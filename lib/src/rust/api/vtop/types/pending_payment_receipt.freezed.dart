// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_payment_receipt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PendingPaymentReceipt {
  String get sNo;
  String get fprefno;
  String get feesHeads;
  String get endDate;
  String get amount;
  String get fine;
  String get totalAmount;
  String get paymentStatus;

  /// Create a copy of PendingPaymentReceipt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PendingPaymentReceiptCopyWith<PendingPaymentReceipt> get copyWith =>
      _$PendingPaymentReceiptCopyWithImpl<PendingPaymentReceipt>(
          this as PendingPaymentReceipt, _$identity);

  /// Serializes this PendingPaymentReceipt to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PendingPaymentReceipt &&
            (identical(other.sNo, sNo) || other.sNo == sNo) &&
            (identical(other.fprefno, fprefno) || other.fprefno == fprefno) &&
            (identical(other.feesHeads, feesHeads) ||
                other.feesHeads == feesHeads) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fine, fine) || other.fine == fine) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sNo, fprefno, feesHeads, endDate,
      amount, fine, totalAmount, paymentStatus);

  @override
  String toString() {
    return 'PendingPaymentReceipt(sNo: $sNo, fprefno: $fprefno, feesHeads: $feesHeads, endDate: $endDate, amount: $amount, fine: $fine, totalAmount: $totalAmount, paymentStatus: $paymentStatus)';
  }
}

/// @nodoc
abstract mixin class $PendingPaymentReceiptCopyWith<$Res> {
  factory $PendingPaymentReceiptCopyWith(PendingPaymentReceipt value,
          $Res Function(PendingPaymentReceipt) _then) =
      _$PendingPaymentReceiptCopyWithImpl;
  @useResult
  $Res call(
      {String sNo,
      String fprefno,
      String feesHeads,
      String endDate,
      String amount,
      String fine,
      String totalAmount,
      String paymentStatus});
}

/// @nodoc
class _$PendingPaymentReceiptCopyWithImpl<$Res>
    implements $PendingPaymentReceiptCopyWith<$Res> {
  _$PendingPaymentReceiptCopyWithImpl(this._self, this._then);

  final PendingPaymentReceipt _self;
  final $Res Function(PendingPaymentReceipt) _then;

  /// Create a copy of PendingPaymentReceipt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sNo = null,
    Object? fprefno = null,
    Object? feesHeads = null,
    Object? endDate = null,
    Object? amount = null,
    Object? fine = null,
    Object? totalAmount = null,
    Object? paymentStatus = null,
  }) {
    return _then(_self.copyWith(
      sNo: null == sNo
          ? _self.sNo
          : sNo // ignore: cast_nullable_to_non_nullable
              as String,
      fprefno: null == fprefno
          ? _self.fprefno
          : fprefno // ignore: cast_nullable_to_non_nullable
              as String,
      feesHeads: null == feesHeads
          ? _self.feesHeads
          : feesHeads // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      fine: null == fine
          ? _self.fine
          : fine // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [PendingPaymentReceipt].
extension PendingPaymentReceiptPatterns on PendingPaymentReceipt {
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
    TResult Function(_PendingPaymentReceipt value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PendingPaymentReceipt() when $default != null:
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
    TResult Function(_PendingPaymentReceipt value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PendingPaymentReceipt():
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
    TResult? Function(_PendingPaymentReceipt value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PendingPaymentReceipt() when $default != null:
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
            String sNo,
            String fprefno,
            String feesHeads,
            String endDate,
            String amount,
            String fine,
            String totalAmount,
            String paymentStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PendingPaymentReceipt() when $default != null:
        return $default(
            _that.sNo,
            _that.fprefno,
            _that.feesHeads,
            _that.endDate,
            _that.amount,
            _that.fine,
            _that.totalAmount,
            _that.paymentStatus);
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
            String sNo,
            String fprefno,
            String feesHeads,
            String endDate,
            String amount,
            String fine,
            String totalAmount,
            String paymentStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PendingPaymentReceipt():
        return $default(
            _that.sNo,
            _that.fprefno,
            _that.feesHeads,
            _that.endDate,
            _that.amount,
            _that.fine,
            _that.totalAmount,
            _that.paymentStatus);
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
            String sNo,
            String fprefno,
            String feesHeads,
            String endDate,
            String amount,
            String fine,
            String totalAmount,
            String paymentStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PendingPaymentReceipt() when $default != null:
        return $default(
            _that.sNo,
            _that.fprefno,
            _that.feesHeads,
            _that.endDate,
            _that.amount,
            _that.fine,
            _that.totalAmount,
            _that.paymentStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PendingPaymentReceipt implements PendingPaymentReceipt {
  const _PendingPaymentReceipt(
      {required this.sNo,
      required this.fprefno,
      required this.feesHeads,
      required this.endDate,
      required this.amount,
      required this.fine,
      required this.totalAmount,
      required this.paymentStatus});
  factory _PendingPaymentReceipt.fromJson(Map<String, dynamic> json) =>
      _$PendingPaymentReceiptFromJson(json);

  @override
  final String sNo;
  @override
  final String fprefno;
  @override
  final String feesHeads;
  @override
  final String endDate;
  @override
  final String amount;
  @override
  final String fine;
  @override
  final String totalAmount;
  @override
  final String paymentStatus;

  /// Create a copy of PendingPaymentReceipt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PendingPaymentReceiptCopyWith<_PendingPaymentReceipt> get copyWith =>
      __$PendingPaymentReceiptCopyWithImpl<_PendingPaymentReceipt>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PendingPaymentReceiptToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PendingPaymentReceipt &&
            (identical(other.sNo, sNo) || other.sNo == sNo) &&
            (identical(other.fprefno, fprefno) || other.fprefno == fprefno) &&
            (identical(other.feesHeads, feesHeads) ||
                other.feesHeads == feesHeads) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fine, fine) || other.fine == fine) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sNo, fprefno, feesHeads, endDate,
      amount, fine, totalAmount, paymentStatus);

  @override
  String toString() {
    return 'PendingPaymentReceipt(sNo: $sNo, fprefno: $fprefno, feesHeads: $feesHeads, endDate: $endDate, amount: $amount, fine: $fine, totalAmount: $totalAmount, paymentStatus: $paymentStatus)';
  }
}

/// @nodoc
abstract mixin class _$PendingPaymentReceiptCopyWith<$Res>
    implements $PendingPaymentReceiptCopyWith<$Res> {
  factory _$PendingPaymentReceiptCopyWith(_PendingPaymentReceipt value,
          $Res Function(_PendingPaymentReceipt) _then) =
      __$PendingPaymentReceiptCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String sNo,
      String fprefno,
      String feesHeads,
      String endDate,
      String amount,
      String fine,
      String totalAmount,
      String paymentStatus});
}

/// @nodoc
class __$PendingPaymentReceiptCopyWithImpl<$Res>
    implements _$PendingPaymentReceiptCopyWith<$Res> {
  __$PendingPaymentReceiptCopyWithImpl(this._self, this._then);

  final _PendingPaymentReceipt _self;
  final $Res Function(_PendingPaymentReceipt) _then;

  /// Create a copy of PendingPaymentReceipt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sNo = null,
    Object? fprefno = null,
    Object? feesHeads = null,
    Object? endDate = null,
    Object? amount = null,
    Object? fine = null,
    Object? totalAmount = null,
    Object? paymentStatus = null,
  }) {
    return _then(_PendingPaymentReceipt(
      sNo: null == sNo
          ? _self.sNo
          : sNo // ignore: cast_nullable_to_non_nullable
              as String,
      fprefno: null == fprefno
          ? _self.fprefno
          : fprefno // ignore: cast_nullable_to_non_nullable
              as String,
      feesHeads: null == feesHeads
          ? _self.feesHeads
          : feesHeads // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      fine: null == fine
          ? _self.fine
          : fine // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
