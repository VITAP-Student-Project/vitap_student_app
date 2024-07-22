//payment_page.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/api/payments_api.dart';

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

  void _showPaymentDetails(BuildContext context, Map<String, dynamic> receipt) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent.shade200.withOpacity(0.075),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Payment Completed!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Text(
                  "Your payment has been successfully done.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 325,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            Text('${receipt['amount']}'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment status",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 6),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 230, 118, 1)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Text("Paid",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            )
                          ],
                        ),
                        Text(
                          '- - - - - - - - - - - - - - - - - - - - - - -',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w200),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ref number",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            Text('${receipt['receipt_number']}'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Campus code",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            Text('${receipt['campus_code']}'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment time",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            Text('${receipt['date']}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: () {},
                  height: 60,
                  minWidth: 325,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_download_outlined),
                      SizedBox(
                        width: 7,
                      ),
                      const Text('Download PDF'),
                    ],
                  ),
                  color: Colors.greenAccent.shade400,
                  textColor: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Receipts'),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                value: 0,
              ),
            ],
            onSelected: (value) {
              fetchPaymentDetails();
            },
          )
        ],
      ),
      body: _paymentReceipts.isNotEmpty
          ? ListView.builder(
              itemCount: _paymentReceipts.length,
              itemBuilder: (context, index) {
                final key = _paymentReceipts.keys.elementAt(index);
                final receipt = _paymentReceipts[key];
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: ListTile(
                        leading: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.moneyBill1,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          '${receipt['receipt_number']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(
                          '${receipt['amount']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showPaymentDetails(context, receipt);
                        },
                      ),
                    ),
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
