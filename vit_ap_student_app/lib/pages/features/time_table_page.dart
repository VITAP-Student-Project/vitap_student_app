import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/widgets/my_tab_bar.dart';
import '../../utils/api/timetable_api.dart';
import '../profile/account_page.dart';

class TimeTablePage extends StatefulWidget {
  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  @override
  initState() {
    super.initState();
    fetchTimetable("23BCE7625", "@t6echafuweCo");
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dayNumber = DateFormat('d').format(now);
    String dayName = DateFormat('E').format(now);
    String monthYear = DateFormat('MMM yyyy').format(now);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 90,
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              iconSize: 20,
            ),
            actions: [
              Icon(
                Icons.more_vert_rounded,
                size: 40,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Timetable",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "You have 3 classes Today",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 900,
                      width: MediaQuery.of(context).size.width,
                      child: DaysTabBar(),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
