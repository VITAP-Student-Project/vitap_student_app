import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vit_ap_student_app/core/common/widgets/common_date_picker.dart';
import 'package:vit_ap_student_app/core/constants/app_constants.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/view/pages/outing/weekend_outing_history_page.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/outing_submission_viewmodel.dart';

class WeekendOutingTab extends ConsumerStatefulWidget {
  const WeekendOutingTab({super.key});

  @override
  ConsumerState<WeekendOutingTab> createState() => _WeekendOutingTabState();
}

class _WeekendOutingTabState extends ConsumerState<WeekendOutingTab> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedPlace = AppConstants.outingPlaces.first;
  String? _selectedTimeSlot = AppConstants.outingTimeSlots.first;
  String? _purpose;
  String? _contactNumber;
  DateTime? _outingDate;

  Future<void> _submitWeekendOuting() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedPlace == null) {
      showSnackBar(context, 'Please select a place', SnackBarType.warning);
      return;
    }

    if (_selectedTimeSlot == null) {
      showSnackBar(context, 'Please select a time slot', SnackBarType.warning);
      return;
    }

    if (_outingDate == null) {
      showSnackBar(context, 'Please select a date', SnackBarType.warning);
      return;
    }

    if (_purpose == null || _contactNumber == null) {
      return;
    }

    await ref
        .read(weekendOutingSubmissionProvider.notifier)
        .submitWeekendOuting(
          outPlace: _selectedPlace!,
          purposeOfVisit: _purpose!,
          outingDate: DateFormat('dd-MMM-yyyy').format(_outingDate!),
          outTime: _selectedTimeSlot!,
          contactNumber: _contactNumber!,
        );
  }

  void _clearForm() {
    setState(() {
      _selectedPlace = AppConstants.outingPlaces.first;
      _selectedTimeSlot = AppConstants.outingTimeSlots.first;
      _outingDate = null;
      _purpose = null;
      _contactNumber = null;
    });
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      weekendOutingSubmissionProvider.select((val) => val?.isLoading == true),
    );

    ref.listen(
      weekendOutingSubmissionProvider,
      (_, next) {
        next?.when(
          data: (message) {
            showSnackBar(
              context,
              message,
              SnackBarType.success,
            );
            _clearForm();
          },
          loading: () {},
          error: (error, st) {
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
        );
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Place Dropdown
          Text(
            'Place of Visit',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownButtonFormField<String>(
            initialValue: _selectedPlace,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 0.0,
              ),
            ),
            items: AppConstants.outingPlaces.map((String place) {
              return DropdownMenuItem<String>(
                value: place,
                child: Text(place),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedPlace = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a place';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),

          // Time Slot Dropdown
          Text(
            'Time Slot',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownButtonFormField<String>(
            initialValue: _selectedTimeSlot,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 0.0,
              ),
            ),
            items: AppConstants.outingTimeSlots.map((String slot) {
              return DropdownMenuItem<String>(
                value: slot,
                child: Text(slot),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedTimeSlot = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a time slot';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),

          // Date Picker
          CommonDatePicker(
            label: 'Outing Date',
            selectedDate: _outingDate,
            onDateSelected: (date) {
              setState(() => _outingDate = date);
            },
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 7)),
            selectableDayPredicate: (DateTime date) {
              // Only allow Sunday (7) or Monday (1)
              return date.weekday == DateTime.sunday ||
                  date.weekday == DateTime.monday;
            },
            validator: (value) =>
                _outingDate == null ? 'Please select a date' : null,
          ),
          const SizedBox(height: 16),

          // Purpose
          Text(
            'Purpose of Visit',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter purpose',
              hintStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 0.0,
              ),
            ),
            onChanged: (value) => setState(() => _purpose = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter purpose';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),

          // Contact Number
          Text(
            'Contact Number',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter contact number',
              hintStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 0.0,
              ),
            ),
            keyboardType: TextInputType.phone,
            onChanged: (value) => setState(() => _contactNumber = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter contact number';
              }
              if (value.length != 10) {
                return 'Contact number must be 10 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Bottom Row: View History + Apply
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeekendOutingHistoryPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "View outing history",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : TextButton.icon(
                        icon: const Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.blue,
                        ),
                        iconAlignment: IconAlignment.end,
                        onPressed: _submitWeekendOuting,
                        label: const Text(
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
    );
  }
}
