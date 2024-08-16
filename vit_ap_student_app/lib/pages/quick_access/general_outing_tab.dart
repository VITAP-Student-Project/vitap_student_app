import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vit_ap_student_app/pages/quick_access/general_outing_history_page.dart';

import '../../utils/provider/providers.dart';

class GeneralOutingTab extends ConsumerStatefulWidget {
  const GeneralOutingTab({super.key});
  @override
  _GeneralOutingTabState createState() => _GeneralOutingTabState();
}

class _GeneralOutingTabState extends ConsumerState<GeneralOutingTab> {
  String? _fromTime;
  String? _toTime;
  String? _placeOfVisit;
  String? _purposeOfVisit;
  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickTime(BuildContext context, bool isFromTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      int hour = pickedTime.hour;
      int minute = pickedTime.minute;

      if ((hour > 6 || (hour == 6 && minute >= 0)) &&
          (hour < 22 || (hour == 22 && minute == 0))) {
        final now = DateTime.now();
        final dateTime = DateTime(
            now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
        final formattedTime = DateFormat('HH:mm').format(dateTime);

        setState(() {
          if (isFromTime) {
            _fromTime = formattedTime;
          } else {
            _toTime = formattedTime;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a time between 06:00 AM and 10:00PM'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postGeneralOuting = ref.read(generalOutingProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Place of visit",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    labelStyle: TextStyle(
                      fontSize: 16,
                    ),
                    labelText: 'Place Of Visit',
                  ),
                  onChanged: (value) => setState(() => _placeOfVisit = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the place of visit'
                      : null,
                ),
                SizedBox(height: 12),
                Text(
                  "Purpose of visit",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    labelStyle: TextStyle(
                      fontSize: 16,
                    ),
                    labelText: 'Purpose Of Visit',
                  ),
                  onChanged: (value) => setState(() => _purposeOfVisit = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the purpose of visit'
                      : null,
                ),
                SizedBox(height: 12),
                Text(
                  "From date",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime now = DateTime.now();

                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: now,
                      lastDate: now.add(
                        Duration(days: 720),
                      ),
                    );

                    if (pickedDate != null) {
                      setState(() => _selectedFromDate = pickedDate);
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month_outlined),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        labelText: _selectedFromDate == null
                            ? 'Choose from date'
                            : DateFormat('dd-MMM-yyyy')
                                .format(_selectedFromDate!),
                        hintText: _selectedFromDate == null
                            ? 'Select _selectedfromDate'
                            : DateFormat('dd-MMM-yyyy')
                                .format(_selectedFromDate!),
                      ),
                      validator: (value) => _selectedFromDate == null
                          ? 'Please select a date'
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "From time",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                GestureDetector(
                  onTap: () => _pickTime(context, true),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.access_alarms),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        labelText:
                            _fromTime == null ? 'Choose from time' : _fromTime,
                      ),
                      validator: (value) => _fromTime == null
                          ? 'Please select a from time'
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "To date",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime now = DateTime.now();

                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: now,
                      lastDate: now.add(
                        Duration(days: 720),
                      ),
                    );

                    if (pickedDate != null) {
                      setState(() => _selectedToDate = pickedDate);
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month_outlined),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        labelText: _selectedToDate == null
                            ? 'Choose to date'
                            : DateFormat('dd-MMM-yyyy')
                                .format(_selectedToDate!),
                      ),
                      validator: (value) => _selectedToDate == null
                          ? 'Please select a date'
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "To time",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                GestureDetector(
                  onTap: () => _pickTime(context, false),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.access_alarms),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        labelText: _toTime == null ? 'Choose to time' : _toTime,
                      ),
                      validator: (value) =>
                          _toTime == null ? 'Please select a to time' : null,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                              type: PageTransitionType.rightToLeftWithFade,
                              child: GeneralOutingHistoryPage(),
                            ),
                          );
                        },
                        child: Text(
                          "View outing history",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.blue,
                        ),
                        iconAlignment: IconAlignment.end,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            postGeneralOuting(
                              context,
                              _placeOfVisit!,
                              _purposeOfVisit!,
                              DateFormat('dd-MMM-yyyy')
                                  .format(_selectedFromDate!),
                              _fromTime!,
                              DateFormat('dd-MMM-yyyy')
                                  .format(_selectedToDate!),
                              _toTime!,
                            );
                          }
                        },
                        label: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
