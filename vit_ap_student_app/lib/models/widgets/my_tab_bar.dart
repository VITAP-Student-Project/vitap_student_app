import 'package:flutter/material.dart';

class DaysTabBar extends StatefulWidget {
  const DaysTabBar({super.key});

  @override
  State<DaysTabBar> createState() => _DaysTabBarState();
}

class _DaysTabBarState extends State<DaysTabBar> with SingleTickerProviderStateMixin {
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
              Center(child: Text("Sunday")),
              Center(child: Text("Monday")),
              Center(child: Text("Tuesday")),
              Center(child: Text("Wednesday")),
              Center(child: Text("Thursday")),
              Center(child: Text("Friday")),
              Center(child: Text("Saturday")),
            ],
          ),
        ),
      ],
    );
  }
}
