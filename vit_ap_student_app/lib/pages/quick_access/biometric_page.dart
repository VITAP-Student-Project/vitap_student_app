import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../utils/provider/biometric_provider.dart';

class BiometricPage extends ConsumerStatefulWidget {
  const BiometricPage({super.key});

  @override
  ConsumerState<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends ConsumerState<BiometricPage> {
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
        children: [
          ElevatedButton(
            onLongPress: () {},
            onPressed: () => _selectDate(context),
            child: Text(
              'Select date',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Selected date: $formattedDate",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: _getBiometricLog,
            child: Text(
              'Get Biometric Log',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Expanded(
            child: _biometricLogFuture == null
                ? const Center(child: Text('Press the button to fetch data'))
                : FutureBuilder<Map<String, dynamic>>(
                    future: _biometricLogFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('${snapshot.data}'));
                      } else {
                        Map<String, dynamic> biometricLog = snapshot.data!;
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
                                    borderRadius: BorderRadius.circular(9)),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  subtitle: Text(
                                    formattedDate,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),
                                  subtitleTextStyle:
                                      const TextStyle(color: Colors.black54),
                                  trailing: Text(
                                    '${logEntry["time"]}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
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
