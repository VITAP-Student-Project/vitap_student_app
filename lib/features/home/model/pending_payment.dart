import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'pending_payment.g.dart';

List<PendingPayment> pendingPaymentFromJson(String str) =>
    List<PendingPayment>.from(
        json.decode(str).map((x) => PendingPayment.fromJson(x)));

String pendingPaymentToJson(List<PendingPayment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class PendingPayment {
  @JsonKey(name: "s_no")
  final String sNo;
  @JsonKey(name: "fprefno")
  final String fprefno;
  @JsonKey(name: "fees_heads")
  final String feesHeads;
  @JsonKey(name: "end_date")
  final DateTime endDate;
  @JsonKey(name: "amount")
  final String amount;
  @JsonKey(name: "fine")
  final String fine;
  @JsonKey(name: "total_amount")
  final String totalAmount;
  @JsonKey(name: "payment_status")
  final String paymentStatus;

  PendingPayment({
    required this.sNo,
    required this.fprefno,
    required this.feesHeads,
    required this.endDate,
    required this.amount,
    required this.fine,
    required this.totalAmount,
    required this.paymentStatus,
  });

  factory PendingPayment.fromJson(Map<String, dynamic> json) =>
      _$PendingPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PendingPaymentToJson(this);
}
