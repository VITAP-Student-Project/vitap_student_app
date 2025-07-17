// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_payment_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendingPaymentReceipt _$PendingPaymentReceiptFromJson(
        Map<String, dynamic> json) =>
    _PendingPaymentReceipt(
      sNo: json['sNo'] as String,
      fprefno: json['fprefno'] as String,
      feesHeads: json['feesHeads'] as String,
      endDate: json['endDate'] as String,
      amount: json['amount'] as String,
      fine: json['fine'] as String,
      totalAmount: json['totalAmount'] as String,
      paymentStatus: json['paymentStatus'] as String,
    );

Map<String, dynamic> _$PendingPaymentReceiptToJson(
        _PendingPaymentReceipt instance) =>
    <String, dynamic>{
      'sNo': instance.sNo,
      'fprefno': instance.fprefno,
      'feesHeads': instance.feesHeads,
      'endDate': instance.endDate,
      'amount': instance.amount,
      'fine': instance.fine,
      'totalAmount': instance.totalAmount,
      'paymentStatus': instance.paymentStatus,
    };
