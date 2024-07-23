import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class MySemesterDropDownWidget extends StatefulWidget {
  final void Function(String?) onSelected;

  const MySemesterDropDownWidget({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

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
    _semSubIDList = ['Select Semester', ...SemsubID.keys.toList()];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 320,
        height: 60,
        child: DropdownButtonFormField<String>(
          dropdownColor: Theme.of(context).colorScheme.secondary,
          focusColor: Theme.of(context).colorScheme.primary,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          decoration: InputDecoration(
            labelText: "Semester",
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          value: _semSubID,
          items: _semSubIDList
              .map(
                (e) => DropdownMenuItem<String>(
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              _semSubID = val!;
            });
            widget.onSelected(val == 'Select Semester' ? null : SemsubID[val]);
          },
        ),
      ),
    );
  }
}
