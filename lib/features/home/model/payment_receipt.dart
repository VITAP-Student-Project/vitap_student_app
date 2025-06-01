import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'payment_receipt.g.dart';

List<PaymentReceipt> paymentReceiptFromJson(String str) =>
    List<PaymentReceipt>.from(
        json.decode(str).map((x) => PaymentReceipt.fromJson(x)));

String paymentReceiptToJson(List<PaymentReceipt> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class PaymentReceipt {
  @JsonKey(name: "receipt_number")
  final String receiptNumber;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "amount")
  final String amount;
  @JsonKey(name: "campus_code")
  final String campusCode;
  @JsonKey(name: "payment_status")
  final String paymentStatus;
  @JsonKey(name: "receipt_no")
  final String receiptNo;

  PaymentReceipt({
    required this.receiptNumber,
    required this.date,
    required this.amount,
    required this.campusCode,
    required this.paymentStatus,
    required this.receiptNo,
  });

  factory PaymentReceipt.fromJson(Map<String, dynamic> json) =>
      _$PaymentReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentReceiptToJson(this);
}
