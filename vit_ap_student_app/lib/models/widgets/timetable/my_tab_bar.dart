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
            unselectedLabelColor: Colors.black54,
            labelColor: Colors.black,
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Classes",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  MySchedule(),
                ],
              ),
              Text(
                "Classes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                "Classes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                "Classes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                "Classes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                "Classes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                "Classes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
