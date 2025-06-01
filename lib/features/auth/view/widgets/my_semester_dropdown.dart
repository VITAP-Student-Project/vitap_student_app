import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/constants/semester_sub_ids.dart';

class MySemesterDropDownWidget extends StatefulWidget {
  final void Function(String?) onSelected;
  final String? initialValue;

  const MySemesterDropDownWidget(
      {super.key,
      required this.onSelected,
      this.initialValue = "Select Semester"});

  @override
  State<MySemesterDropDownWidget> createState() =>
      _MySemesterDropDownWidgetState();
}

class _MySemesterDropDownWidgetState extends State<MySemesterDropDownWidget> {
  String _semSubID = 'Select Semester';
  late List<String> _semSubIDList;

  @override
  void initState() {
    super.initState();
    _semSubIDList = ['Select Semester', ...semSubID.keys];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) {
      _semSubID = semSubID.entries
          .firstWhere(
            (entry) => entry.value == widget.initialValue,
            orElse: () => const MapEntry('Select Semester', ''),
          )
          .key;
    }
    return DropdownButtonFormField<String>(
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width - 80,
          maxHeight: 100,
        ),
        labelText: "Semester",
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value == 'Select Semester') {
          return "Please select a semester";
        }
        return null;
      },
      value: _semSubID,
      items: _semSubIDList
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          _semSubID = val!;
        });
        widget.onSelected(val == 'Select Semester' ? null : semSubID[val]);
      },
    );
  }
}
