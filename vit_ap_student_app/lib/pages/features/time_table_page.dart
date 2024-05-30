import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/widgets/my_tab_bar.dart';

class TimeTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dayNumber = DateFormat('d').format(now);
    String dayName = DateFormat('E').format(now);
    String monthYear = DateFormat('MMM yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Timetable"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: DaysTabBar(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
