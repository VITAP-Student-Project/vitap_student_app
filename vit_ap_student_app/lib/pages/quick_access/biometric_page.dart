import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../utils/provider/providers.dart';

class BiometricPage extends ConsumerStatefulWidget {
  const BiometricPage({super.key});

  @override
  ConsumerState<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends ConsumerState<BiometricPage> {
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<Map<String, dynamic>>? _biometricLogFuture;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2025),
        helpText: "Please select a date");
    if (_picked != null) {
      setState(() {
        selectedDate = _picked;
      });
    }
  }

  void _getBiometricLog() {
    final String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    setState(() {
      _biometricLogFuture =
          ref.read(biometricLogProvider(formattedDate).future);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Biometric Log",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Text(
              "Pick a date",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Container(
                width: 250,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    controller: dateController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
                        size: 26,
                      ),
                      border: InputBorder.none,
                      hintText: formattedDate,
                      hintStyle: TextStyle(
                        letterSpacing: 2,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_month_outlined),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: TextButton(
                  onPressed: _getBiometricLog,
                  child: Text(
                    'Go',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Expanded(
            child: _biometricLogFuture == null
                ? const Center(child: Text('Pick a date and press Go'))
                : FutureBuilder<Map<String, dynamic>>(
                    future: _biometricLogFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!['biometric_log'].isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                "assets/images/lottie/404_balloon.json",
                                width: 250,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'No records found for the specified date',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        Map<String, dynamic> biometricLog =
                            snapshot.data!['biometric_log'];
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: biometricLog.length,
                          itemBuilder: (context, index) {
                            String key = biometricLog.keys.elementAt(index);
                            var logEntry = biometricLog[key];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: ListTile(
                                  onLongPress: () {},
                                  leading: logEntry.toString().contains("MH") ||
                                          logEntry.toString().contains("LH")
                                      ? Icon(
                                          Icons.maps_home_work_outlined,
                                          color: Colors.blue.shade400,
                                        )
                                      : Icon(
                                          Icons.school_outlined,
                                          color: Colors.orange.shade500,
                                        ),
                                  title: Text(
                                    '${logEntry["location"]}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  subtitle: Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  subtitleTextStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  trailing: Text(
                                    '${logEntry["time"]}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
