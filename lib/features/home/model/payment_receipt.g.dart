// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentReceipt _$PaymentReceiptFromJson(Map<String, dynamic> json) =>
    PaymentReceipt(
      receiptNumber: json['receipt_number'] as String,
      date: json['date'] as String,
      amount: json['amount'] as String,
      campusCode: json['campus_code'] as String,
      paymentStatus: json['payment_status'] as String,
      receiptNo: json['receipt_no'] as String,
    );

Map<String, dynamic> _$PaymentReceiptToJson(PaymentReceipt instance) =>
    <String, dynamic>{
      'receipt_number': instance.receiptNumber,
      'date': instance.date,
      'amount': instance.amount,
      'campus_code': instance.campusCode,
      'payment_status': instance.paymentStatus,
      'receipt_no': instance.receiptNo,
    };
