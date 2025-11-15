import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonTimePicker extends StatelessWidget {
  final String label;
  final String? selectedTime;
  final Function(String?) onTimeSelected;
  final TimeOfDay? initialTime;
  final bool Function(TimeOfDay)? timeValidator;
  final String? Function(String?)? validator;

  const CommonTimePicker({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onTimeSelected,
    this.initialTime,
    this.timeValidator,
    this.validator,
  });

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Validate time if validator is provided
      if (timeValidator != null && !timeValidator!(pickedTime)) {
        return;
      }

      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      final formattedTime = DateFormat('HH:mm').format(dateTime);
      onTimeSelected(formattedTime);
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
          onTap: () => _pickTime(context),
          child: AbsorbPointer(
            child: TextFormField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.access_alarms),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                labelText: selectedTime ?? 'Select time',
              ),
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }
}
