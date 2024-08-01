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
        print(_paymentReceipts);
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
                const SizedBox(
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
                const SizedBox(
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
                            Text(
                              '₹ ${receipt['amount']}',
                              style: const TextStyle(),
                            ),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 6),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 230, 118, 1)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Text('${receipt['payment_status']}',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            )
                          ],
                        ),
                        const Text(
                          '- - - - - - - - - - - - - - - - - - - - - - -',
                          style: TextStyle(
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
                  color: Colors.greenAccent.shade400,
                  textColor: Theme.of(context).colorScheme.secondary,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_download_outlined),
                      SizedBox(
                        width: 7,
                      ),
                      Text('Download PDF'),
                      
                    ],
                  ),
                ),
                SizedBox(height: 15,),
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
        title: const Text('Payments'),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
            onSelected: (value) {
              fetchPaymentDetails();
            },
          )
        ],
      ),
      body: _paymentReceipts.isNotEmpty
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${_paymentReceipts['payment_dues'] ?? 'Unable to fetch payment dues at the moment!'}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _paymentReceipts['payment_receipts'].length,
                      itemBuilder: (context, index) {
                        final key = _paymentReceipts['payment_receipts']
                            .keys
                            .elementAt(index);
                        final receipt =
                            _paymentReceipts['payment_receipts'][key];

                        IconData leadingIcon;
                        switch (receipt['details']?['payment_details']?[0]
                                ['payment_mode'] ??
                            'wallet') {
                          case 'wallet':
                            leadingIcon = FontAwesomeIcons.wallet;
                            break;
                          case 'credit_card':
                            leadingIcon = FontAwesomeIcons.creditCard;
                            break;
                          case 'bank':
                            leadingIcon = FontAwesomeIcons.buildingColumns;
                            break;
                          default:
                            leadingIcon = FontAwesomeIcons.moneyCheckDollar;
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade200,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  leadingIcon,
                                  color: Colors.black,
                                ),
                              ),
                              title: Text(
                                '${receipt['details']?['fee']?[0]?['description'].replaceAll('_', ' ') ?? 'Unknown payment'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              subtitle: Text(
                                '₹ ${receipt['amount']}/-',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                _showPaymentDetails(context, receipt);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
