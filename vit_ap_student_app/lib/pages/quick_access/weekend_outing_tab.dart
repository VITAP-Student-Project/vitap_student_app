import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/provider/providers.dart';
import 'weekend_outing_history_page.dart';

class WeekendOutingTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<WeekendOutingTab> createState() => _WeekendOutingTabState();
}

class _WeekendOutingTabState extends ConsumerState<WeekendOutingTab> {
  final List<String> _places = [
    'Vijayawada',
    'Guntur',
    'Tenali',
    'Eluru',
    'Others'
  ];
  final List<String> _timeSlots = [
    '9:30 AM - 3:30 PM',
    '10:30 AM - 4:30 PM',
    '11:30 AM - 5:30 PM',
    '12:30 PM - 6:30 PM'
  ];

  String? _selectedPlace;
  String? _selectedTimeSlot;
  String? _purposeOfVisit;
  String? _contactNumber;
  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final postWeekendOuting = ref.read(weekendOutingProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Place of visit",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      labelText: 'Choose place of visit',
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    items: _places
                        .map((place) => DropdownMenuItem(
                              value: place,
                              child: Text(place),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedPlace = value),
                    validator: (value) =>
                        value == null ? 'Please select a place' : null,
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
                      labelText: 'Enter purpose of visit',
                    ),
                    onChanged: (value) =>
                        setState(() => _purposeOfVisit = value),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the purpose of visit'
                        : null,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Date",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime now = DateTime.now();

                      // Set the last date as the next upcoming Sunday or Monday
                      DateTime lastDate = now.add(
                        Duration(days: 7),
                      );
                      DateTime initialDate = now;

                      // Find the next Sunday or Monday within the range
                      for (int i = 0; i < 7; i++) {
                        initialDate = now.add(Duration(days: i));
                        if (initialDate.weekday == DateTime.sunday ||
                            initialDate.weekday == DateTime.monday) {
                          break;
                        }
                      }

                      if (initialDate.isAfter(lastDate)) {
                        initialDate = lastDate;
                      }

                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: now,
                        lastDate: lastDate,
                        selectableDayPredicate: (date) =>
                            date.weekday == DateTime.sunday ||
                            date.weekday == DateTime.monday,
                      );

                      if (pickedDate != null) {
                        setState(() => _selectedDate = pickedDate);
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          labelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          labelText: _selectedDate == null
                              ? 'Choose date'
                              : DateFormat('dd-MMM-yyyy')
                                  .format(_selectedDate!),
                          hintText: _selectedDate == null
                              ? 'Select date'
                              : DateFormat('dd-MMM-yyyy')
                                  .format(_selectedDate!),
                        ),
                        validator: (value) => _selectedDate == null
                            ? 'Please select a date'
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Time",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      labelText: 'Choose Time',
                    ),
                    items: _timeSlots
                        .map((slot) => DropdownMenuItem(
                              value: slot,
                              child: Text(slot),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedTimeSlot = value),
                    validator: (value) =>
                        value == null ? 'Please select a time slot' : null,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Contact Number",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      labelText: 'Enter contact number',
                    ),
                    onChanged: (value) =>
                        setState(() => _contactNumber = value),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your contact number'
                        : null,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                                EdgeInsets.all(0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                type: PageTransitionType.rightToLeftWithFade,
                                child: WeekendOutingHistoryPage(),
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
                              postWeekendOuting(
                                  context,
                                  _selectedPlace!,
                                  _purposeOfVisit!,
                                  DateFormat('dd-MMM-yyyy')
                                      .format(_selectedDate!),
                                  _selectedTimeSlot!,
                                  _contactNumber!);
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
      ),
    );
  }
}
