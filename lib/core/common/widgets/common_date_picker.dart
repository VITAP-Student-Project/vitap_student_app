import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime?) onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool Function(DateTime)? selectableDayPredicate;
  final String? Function(String?)? validator;

  const CommonDatePicker({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.validator,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime start = firstDate ?? now;
    final DateTime end = lastDate ?? now.add(const Duration(days: 720));

    // Find a valid initial date
    DateTime initialDate = selectedDate ?? now;

    // If there's a predicate and the initial date doesn't satisfy it,
    // find the next valid date
    if (selectableDayPredicate != null &&
        !selectableDayPredicate!(initialDate)) {
      // Try to find the next valid date within the range
      DateTime candidate = initialDate;
      bool foundValidDate = false;

      // Search forward up to 30 days
      for (int i = 0; i < 30; i++) {
        candidate = initialDate.add(Duration(days: i));
        if (candidate.isAfter(end)) break;
        if (candidate.isAfter(start) || candidate.isAtSameMomentAs(start)) {
          if (selectableDayPredicate!(candidate)) {
            initialDate = candidate;
            foundValidDate = true;
            break;
          }
        }
      }

      // If no valid date found forward, try backward
      if (!foundValidDate) {
        for (int i = 1; i < 30; i++) {
          candidate = initialDate.subtract(Duration(days: i));
          if (candidate.isBefore(start)) break;
          if (selectableDayPredicate!(candidate)) {
            initialDate = candidate;
            foundValidDate = true;
            break;
          }
        }
      }

      // If still no valid date, use start date
      if (!foundValidDate) {
        initialDate = start;
      }
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: start,
      lastDate: end,
      selectableDayPredicate: selectableDayPredicate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.calendar_month_outlined),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                labelText: selectedDate == null
                    ? 'Select date'
                    : DateFormat('dd-MMM-yyyy').format(selectedDate!),
                hintText: selectedDate == null
                    ? 'Select date'
                    : DateFormat('dd-MMM-yyyy').format(selectedDate!),
              ),
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }
}
