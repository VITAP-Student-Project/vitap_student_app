import 'package:flutter/material.dart';

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

  final Map<String, String> SemsubID = {
    'WINTER SEM(2023-24) FRESHERS': 'AP2023247',
    'WIN SEM (2023-24)': 'AP2023246',
    'INTRA SEM (2023-24': 'AP2023245',
    'Preference Purpose (2023-24': 'AP2022233',
    'FALL SEM (2023-24) Freshers': 'AP2023243',
    'FALL SEM (2023-24) Regular': 'AP2023242',
    'FAST TRACK FALL II(2023-24)': 'AP2023244',
    'SHORT SUMMER SEMESTER II (2022-23)': 'AP20222310',
    'FAST TRACK FALL (2023-24': 'AP2023241',
    'SHORT SUMMER SEMESTER I (2022-23)': 'AP2022239',
    'LONG SUMMER SEMESTER (2022-23)': 'AP2022238',
    'WIN SEM (2022-23) Freshers': 'AP2022237',
    'WIN SEM (2022-23)': 'AP2022236',
    'INTRA SEM (2022-23': 'AP2022235',
    'FALL SEM (2022-23) Freshers': 'AP2022234',
    'FALL SEM (2022-23)': 'AP2022232',
    'FAST TRACK FALL (2022-23)': 'AP2022231',
    'Short-Summer Semester 2021-22': 'AP2021227',
    'Long-Summer Semester 2021-22': 'AP2021228',
    'INTRA SEM (2021-22)': 'AP2021229',
    'WIN SEM (2021-22) EAPCET': 'AP2021226',
    'WIN SEM (2021-22)': 'AP2021225',
    'FALL SEM (2021-22) EAPCET': 'AP2021223',
    'FALL SEM (2021-22': 'AP2021222',
    'SUMMER SEM1 (2020-21)': 'AP2020217',
    'FAST TRACK FALL SEM (2021-22)': 'AP2021221',
    'WIN SEM (2020-21)': 'AP2020215',
    'INTRA SEM (2020-21)': 'AP2020213',
    'FALL SEM (2020-21)': 'AP2020211',
    'SUMMER SEM1 (2019-20)': 'AP2019207',
    'WIN SEM  (2019-20)': 'AP2019205',
    'FALL SEM (2019-20)': 'AP2019201',
    'SUMMER SEM2 (2018-19)': 'AP2018198',
    'SUMMER SEM1 (2018-19)': 'AP2018197',
    'LONG SEM (2018-19)': 'AP2018199',
    'WIN SEM (2018-19)': 'AP2018195',
    'FALL SEM (2018-19)': 'AP2018191',
    'SUMMER SEM2 (2017-18)': 'AMR2018198',
    'SUMMER SEM1 (2017-18)': 'AMR2018197',
    'WIN SEM (2017-18)': 'AMR2017182',
    'FALL SEM (2017-18)': 'AMR2017181',
    'TESTING': 'AP20101101'
  };

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
