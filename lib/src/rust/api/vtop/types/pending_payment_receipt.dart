// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.11.1.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
import 'package:meta/meta.dart' as meta;
part 'pending_payment_receipt.freezed.dart';
part 'pending_payment_receipt.g.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `fmt`

@freezed
@meta.immutable
sealed class PendingPaymentReceipt with _$PendingPaymentReceipt {
  const factory PendingPaymentReceipt({
    required String sNo,
    required String fprefno,
    required String feesHeads,
    required String endDate,
    required String amount,
    required String fine,
    required String totalAmount,
    required String paymentStatus,
  }) = _PendingPaymentReceipt;

  factory PendingPaymentReceipt.fromJson(Map<String, dynamic> json) =>
      _$PendingPaymentReceiptFromJson(json);
}
