import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../utils/provider/providers.dart';

class OutingPage extends StatefulWidget {
  @override
  _OutingPageState createState() => _OutingPageState();
}

class _OutingPageState extends State<OutingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(String label, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 50,
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.orange.shade700
            : Colors.orange.shade300.withOpacity(0.2),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Outings'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: TabBar(
                dividerColor: Theme.of(context).colorScheme.surface,
                labelPadding: const EdgeInsets.all(0),
                splashBorderRadius: BorderRadius.circular(26),
                labelStyle: const TextStyle(fontSize: 18),
                unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                labelColor: Theme.of(context).colorScheme.surface,
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                ),
                splashFactory: InkRipple.splashFactory,
                overlayColor: WidgetStateColor.resolveWith(
                  (states) => Colors.orange.shade300.withOpacity(0.2),
                ),
                tabs: [
                  _buildTab('Weekend Outing', _tabController.index == 0),
                  _buildTab('General Outing', _tabController.index == 1),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  WeekendOutingTab(),
                  GeneralOutingTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekendOutingTab extends StatefulWidget {
  @override
  State<WeekendOutingTab> createState() => _WeekendOutingTabState();
}

class _WeekendOutingTabState extends State<WeekendOutingTab> {
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
  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration:
                      InputDecoration(labelText: 'Choose place of visit'),
                  items: _places
                      .map((place) => DropdownMenuItem(
                            value: place,
                            child: Text(place),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedPlace = value),
                  validator: (value) =>
                      value == null ? 'Please select a place' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Purpose Of Visit'),
                  onChanged: (value) => setState(() => _purposeOfVisit = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the purpose of visit'
                      : null,
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    DateTime now = DateTime.now();

                    // Set the last date as the next upcoming Sunday or Monday
                    DateTime lastDate = now.add(Duration(days: 7));
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
                        labelText: _selectedDate == null
                            ? 'Choose date'
                            : DateFormat('dd-MMM-yyyy').format(_selectedDate!),
                        hintText: _selectedDate == null
                            ? 'Select date'
                            : DateFormat('dd-MMM-yyyy').format(_selectedDate!),
                      ),
                      validator: (value) =>
                          _selectedDate == null ? 'Please select a date' : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Choose Time'),
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
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Summary'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Place: $_selectedPlace'),
                                Text('Purpose: $_purposeOfVisit'),
                                Text(
                                    'Date: ${DateFormat('dd-MMM-yyyy').format(_selectedDate!)}'),
                                Text('Time: $_selectedTimeSlot'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
    final postOuting = ref.read(generalOutingProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Place Of Visit'),
                  onChanged: (value) => setState(() => _placeOfVisit = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the place of visit'
                      : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Purpose Of Visit'),
                  onChanged: (value) => setState(() => _purposeOfVisit = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the purpose of visit'
                      : null,
                ),
                SizedBox(height: 16),
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
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _pickTime(context, true),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText:
                            _fromTime == null ? 'Choose from time' : _fromTime,
                        hintText: 'Select from time',
                      ),
                      validator: (value) => _fromTime == null
                          ? 'Please select a from time'
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
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
                        labelText: _selectedToDate == null
                            ? 'Choose to date'
                            : DateFormat('dd-MMM-yyyy')
                                .format(_selectedToDate!),
                        hintText: _selectedToDate == null
                            ? 'Select date'
                            : DateFormat('dd-MMM-yyyy')
                                .format(_selectedToDate!),
                      ),
                      validator: (value) => _selectedToDate == null
                          ? 'Please select a date'
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _pickTime(context, false),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: _toTime == null ? 'Choose to time' : _toTime,
                        hintText: 'Select to time',
                      ),
                      validator: (value) =>
                          _toTime == null ? 'Please select a to time' : null,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        postOuting(
                          context,
                          _placeOfVisit!,
                          _purposeOfVisit!,
                          DateFormat('dd-MMM-yyyy').format(_selectedFromDate!),
                          _fromTime!,
                          DateFormat('dd-MMM-yyyy').format(_selectedToDate!),
                          _toTime!,
                        );
                      }
                    },
                    child: Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
