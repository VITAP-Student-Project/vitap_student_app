import 'package:flutter/material.dart';
import 'my_schedule_widget.dart';

class DaysTabBar extends StatefulWidget {
  const DaysTabBar({super.key});

  @override
  State<DaysTabBar> createState() => _DaysTabBarState();
}

class _DaysTabBarState extends State<DaysTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TabBar(
            labelStyle: TextStyle(fontSize: 18),
            unselectedLabelColor: Colors.grey,
            labelColor: Theme.of(context).colorScheme.primary,
            controller: _tabController,
            tabs: [
              Tab(text: "S"),
              Tab(text: "M"),
              Tab(text: "T"),
              Tab(text: "W"),
              Tab(text: "T"),
              Tab(text: "F"),
              Tab(text: "S"),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              MySchedule(day: "Sunday"),
              MySchedule(day: "Monday"),
              MySchedule(day: "Tuesday"),
              MySchedule(day: "Wednesday"),
              MySchedule(day: "Thursday"),
              MySchedule(day: "Friday"),
              MySchedule(day: "Saturday"),
            ],
          ),
        ),
      ],
    );
  }
}
