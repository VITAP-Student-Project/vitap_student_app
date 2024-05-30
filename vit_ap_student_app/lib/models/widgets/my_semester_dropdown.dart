import 'package:flutter/material.dart';

import '../../utils/text_turncation.dart';

class MySemesterDropDownWidget extends StatefulWidget {
  const MySemesterDropDownWidget({super.key});

  @override
  State<MySemesterDropDownWidget> createState() =>
      _MySemesterDropDownWidgetState();
}

class _MySemesterDropDownWidgetState extends State<MySemesterDropDownWidget> {
  _myFormState() {
    _semSubID = _semSubIDList[0];
  }

  final List _semSubIDList = [
    'WINTER SEM(2023-24) FRESHERS',
    'WIN SEM (2023-24)',
    'INTRA SEM (2023-24',
    'Preference Purpose (2023-24',
    'FALL SEM (2023-24) Freshers',
    'FALL SEM (2023-24) Regular',
    'FAST TRACK FALL II(2023-24)',
    'SHORT SUMMER SEMESTER II (2022-23)',
    'FAST TRACK FALL (2023-24',
    'SHORT SUMMER SEMESTER I (2022-23)',
    'LONG SUMMER SEMESTER (2022-23)',
    'WIN SEM (2022-23) Freshers',
    'WIN SEM (2022-23)',
    'INTRA SEM (2022-23',
    'FALL SEM (2022-23) Freshers',
    'FALL SEM (2022-23)',
    'FAST TRACK FALL (2022-23)',
    'Short-Summer Semester 2021-22',
    'Long-Summer Semester 2021-22',
    'INTRA SEM (2021-22)',
    'WIN SEM (2021-22) EAPCET',
    'WIN SEM (2021-22)',
    'FALL SEM (2021-22) EAPCET',
    'FALL SEM (2021-22',
    'SUMMER SEM1 (2020-21)',
    'FAST TRACK FALL SEM (2021-22)',
    'WIN SEM (2020-21)',
    'INTRA SEM (2020-21)',
    'FALL SEM (2020-21)',
    'SUMMER SEM1 (2019-20)',
    'WIN SEM  (2019-20)',
    'FALL SEM (2019-20)',
    'SUMMER SEM2 (2018-19)',
    'SUMMER SEM1 (2018-19)',
    'LONG SEM (2018-19)',
    'WIN SEM (2018-19)',
    'FALL SEM (2018-19)',
    'SUMMER SEM2 (2017-18)',
    'SUMMER SEM1 (2017-18)',
    'WIN SEM (2017-18)',
    'FALL SEM (2017-18)',
    'Select Semester',
  ];
  String _semSubID = 'Select Semester';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 320, // Set the width of the container
        height: 60,
        child: DropdownButtonFormField(
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          decoration: InputDecoration(
              labelText: "Semester", border: OutlineInputBorder()),
          value: _semSubID,
          items: _semSubIDList
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          onChanged: ((val) {
            setState(() {
              _semSubID = val as String;
            });
          }),
        ),
      ),
    );
  }
}
