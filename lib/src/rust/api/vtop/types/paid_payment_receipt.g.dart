// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_payment_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaidPaymentReceipt _$PaidPaymentReceiptFromJson(Map<String, dynamic> json) =>
    _PaidPaymentReceipt(
      receiptNumber: json['receiptNumber'] as String,
      date: json['date'] as String,
      amount: json['amount'] as String,
      campusCode: json['campusCode'] as String,
      paymentStatus: json['paymentStatus'] as String,
      receiptNo: json['receiptNo'] as String,
    );

Map<String, dynamic> _$PaidPaymentReceiptToJson(_PaidPaymentReceipt instance) =>
    <String, dynamic>{
      'receiptNumber': instance.receiptNumber,
      'date': instance.date,
      'amount': instance.amount,
      'campusCode': instance.campusCode,
      'paymentStatus': instance.paymentStatus,
      'receiptNo': instance.receiptNo,
    };
