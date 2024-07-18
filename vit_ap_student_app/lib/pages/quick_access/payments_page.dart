import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyPaymentsPage extends StatefulWidget {
  const MyPaymentsPage({super.key});

  @override
  State<MyPaymentsPage> createState() => _MyPaymentsPageState();
}

class _MyPaymentsPageState extends State<MyPaymentsPage> {
  Map<String, dynamic> _paymentReceipts = {};

  @override
  void initState() {
    super.initState();
    _loadPaymentDetails();
  }

  Future<void> _loadPaymentDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final paymentString = prefs.getString('payments') ?? '';
    if (paymentString.isNotEmpty) {
      setState(() {
        _paymentReceipts = json.decode(paymentString);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Receipts'),
      ),
      body: _paymentReceipts.isNotEmpty
          ? ListView.builder(
              itemCount: _paymentReceipts.length,
              itemBuilder: (context, index) {
                final key = _paymentReceipts.keys.elementAt(index);
                final receipt = _paymentReceipts[key];
                return ListTile(
                  title: Text('Receipt Number: ${receipt['receipt_number']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount: ${receipt['amount']}'),
                      Text('Campus Code: ${receipt['campus_code']}'),
                      Text('Date: ${receipt['date']}'),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
