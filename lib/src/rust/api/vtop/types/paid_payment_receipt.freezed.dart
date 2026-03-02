// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paid_payment_receipt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaidPaymentReceipt {

 String get receiptNumber; String get date; String get amount; String get campusCode; String get paymentStatus; String get receiptNo;
/// Create a copy of PaidPaymentReceipt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaidPaymentReceiptCopyWith<PaidPaymentReceipt> get copyWith => _$PaidPaymentReceiptCopyWithImpl<PaidPaymentReceipt>(this as PaidPaymentReceipt, _$identity);

  /// Serializes this PaidPaymentReceipt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaidPaymentReceipt&&(identical(other.receiptNumber, receiptNumber) || other.receiptNumber == receiptNumber)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.receiptNo, receiptNo) || other.receiptNo == receiptNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,receiptNumber,date,amount,campusCode,paymentStatus,receiptNo);

@override
String toString() {
  return 'PaidPaymentReceipt(receiptNumber: $receiptNumber, date: $date, amount: $amount, campusCode: $campusCode, paymentStatus: $paymentStatus, receiptNo: $receiptNo)';
}


}

/// @nodoc
abstract mixin class $PaidPaymentReceiptCopyWith<$Res>  {
  factory $PaidPaymentReceiptCopyWith(PaidPaymentReceipt value, $Res Function(PaidPaymentReceipt) _then) = _$PaidPaymentReceiptCopyWithImpl;
@useResult
$Res call({
 String receiptNumber, String date, String amount, String campusCode, String paymentStatus, String receiptNo
});




}
/// @nodoc
class _$PaidPaymentReceiptCopyWithImpl<$Res>
    implements $PaidPaymentReceiptCopyWith<$Res> {
  _$PaidPaymentReceiptCopyWithImpl(this._self, this._then);

  final PaidPaymentReceipt _self;
  final $Res Function(PaidPaymentReceipt) _then;

/// Create a copy of PaidPaymentReceipt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? receiptNumber = null,Object? date = null,Object? amount = null,Object? campusCode = null,Object? paymentStatus = null,Object? receiptNo = null,}) {
  return _then(_self.copyWith(
receiptNumber: null == receiptNumber ? _self.receiptNumber : receiptNumber // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,receiptNo: null == receiptNo ? _self.receiptNo : receiptNo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaidPaymentReceipt].
extension PaidPaymentReceiptPatterns on PaidPaymentReceipt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaidPaymentReceipt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaidPaymentReceipt() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaidPaymentReceipt value)  $default,){
final _that = this;
switch (_that) {
case _PaidPaymentReceipt():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaidPaymentReceipt value)?  $default,){
final _that = this;
switch (_that) {
case _PaidPaymentReceipt() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String receiptNumber,  String date,  String amount,  String campusCode,  String paymentStatus,  String receiptNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaidPaymentReceipt() when $default != null:
return $default(_that.receiptNumber,_that.date,_that.amount,_that.campusCode,_that.paymentStatus,_that.receiptNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String receiptNumber,  String date,  String amount,  String campusCode,  String paymentStatus,  String receiptNo)  $default,) {final _that = this;
switch (_that) {
case _PaidPaymentReceipt():
return $default(_that.receiptNumber,_that.date,_that.amount,_that.campusCode,_that.paymentStatus,_that.receiptNo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String receiptNumber,  String date,  String amount,  String campusCode,  String paymentStatus,  String receiptNo)?  $default,) {final _that = this;
switch (_that) {
case _PaidPaymentReceipt() when $default != null:
return $default(_that.receiptNumber,_that.date,_that.amount,_that.campusCode,_that.paymentStatus,_that.receiptNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaidPaymentReceipt implements PaidPaymentReceipt {
  const _PaidPaymentReceipt({required this.receiptNumber, required this.date, required this.amount, required this.campusCode, required this.paymentStatus, required this.receiptNo});
  factory _PaidPaymentReceipt.fromJson(Map<String, dynamic> json) => _$PaidPaymentReceiptFromJson(json);

@override final  String receiptNumber;
@override final  String date;
@override final  String amount;
@override final  String campusCode;
@override final  String paymentStatus;
@override final  String receiptNo;

/// Create a copy of PaidPaymentReceipt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaidPaymentReceiptCopyWith<_PaidPaymentReceipt> get copyWith => __$PaidPaymentReceiptCopyWithImpl<_PaidPaymentReceipt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaidPaymentReceiptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaidPaymentReceipt&&(identical(other.receiptNumber, receiptNumber) || other.receiptNumber == receiptNumber)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.receiptNo, receiptNo) || other.receiptNo == receiptNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,receiptNumber,date,amount,campusCode,paymentStatus,receiptNo);

@override
String toString() {
  return 'PaidPaymentReceipt(receiptNumber: $receiptNumber, date: $date, amount: $amount, campusCode: $campusCode, paymentStatus: $paymentStatus, receiptNo: $receiptNo)';
}


}

/// @nodoc
abstract mixin class _$PaidPaymentReceiptCopyWith<$Res> implements $PaidPaymentReceiptCopyWith<$Res> {
  factory _$PaidPaymentReceiptCopyWith(_PaidPaymentReceipt value, $Res Function(_PaidPaymentReceipt) _then) = __$PaidPaymentReceiptCopyWithImpl;
@override @useResult
$Res call({
 String receiptNumber, String date, String amount, String campusCode, String paymentStatus, String receiptNo
});




}
/// @nodoc
class __$PaidPaymentReceiptCopyWithImpl<$Res>
    implements _$PaidPaymentReceiptCopyWith<$Res> {
  __$PaidPaymentReceiptCopyWithImpl(this._self, this._then);

  final _PaidPaymentReceipt _self;
  final $Res Function(_PaidPaymentReceipt) _then;

/// Create a copy of PaidPaymentReceipt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? receiptNumber = null,Object? date = null,Object? amount = null,Object? campusCode = null,Object? paymentStatus = null,Object? receiptNo = null,}) {
  return _then(_PaidPaymentReceipt(
receiptNumber: null == receiptNumber ? _self.receiptNumber : receiptNumber // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,receiptNo: null == receiptNo ? _self.receiptNo : receiptNo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
