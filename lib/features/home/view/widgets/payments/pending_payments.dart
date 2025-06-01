import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/features/home/model/pending_payment.dart';

class PendingPayments extends StatelessWidget {
  final List<PendingPayment> pendingPayments;
  const PendingPayments({super.key, required this.pendingPayments});

  @override
  Widget build(BuildContext context) {
    return pendingPayments.isEmpty
        ? EmptyContentView(
            primaryText: 'No pending payments 🎉',
            secondaryText: "No payments are due at this time.",
          )
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: pendingPayments.length,
            itemBuilder: (context, index) {
              final payment = pendingPayments[index];
              return PaymentCard(payment: payment);
            },
          );
  }
}

class PaymentCard extends StatelessWidget {
  final PendingPayment payment;
  const PaymentCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final dueDate = DateFormat.yMMMd().format(payment.endDate);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fees Head
            Text(
              payment.feesHeads,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Amount details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AmountLabel(title: "Amount", value: payment.amount),
                _AmountLabel(title: "Fine", value: payment.fine),
                _AmountLabel(title: "Total", value: payment.totalAmount),
              ],
            ),

            const SizedBox(height: 12),

            // Due date and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Iconsax.calendar_1_copy, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "Due: $dueDate",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    payment.paymentStatus.toUpperCase(),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountLabel extends StatelessWidget {
  final String title;
  final String value;
  const _AmountLabel({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          "₹$value",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
