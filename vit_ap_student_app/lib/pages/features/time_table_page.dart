import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/widgets/timetable/my_tab_bar.dart';
import '../../utils/api/timetable_api.dart';
import 'bottom_navigation_bar.dart';

class TimeTablePage extends StatefulWidget {
  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBNB()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              iconSize: 20,
            ),
            actions: [
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    value: 0,
                  ),
                ],
                onSelected: (value) {
                  if (value == 0) {
                    fetchTimetable("23BCE7625", "@t6echafuweCo", "AP2023247");
                  }
                },
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
