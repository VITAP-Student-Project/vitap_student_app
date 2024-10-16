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
    final int currentDayIndex = DateTime.now().weekday % 7;
    _tabController =
        TabController(length: 7, vsync: this, initialIndex: currentDayIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(String label) {
    return Container(
      height: 40,
      width: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _tabController.index == _tabController.indexIsChanging
            ? Colors.orange.shade700
            : Colors.orange.shade300.withOpacity(0.2),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Tab(
          child: Text(
        label,
        style: TextStyle(),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height,
        maxHeight: MediaQuery.sizeOf(context).height + 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            dividerColor: Theme.of(context).colorScheme.surface,
            labelPadding: const EdgeInsets.all(0),
            splashBorderRadius: BorderRadius.circular(14),
            labelStyle: const TextStyle(fontSize: 18),
            unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
            labelColor: Theme.of(context).colorScheme.surface,
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.orange.shade700,
              borderRadius: BorderRadius.circular(9),
            ),
            splashFactory: InkRipple.splashFactory,
            overlayColor: WidgetStateColor.resolveWith(
                (states) => Colors.orange.shade100),
            tabs: [
              _buildTab("S"),
              _buildTab("M"),
              _buildTab("T"),
              _buildTab("W"),
              _buildTab("T"),
              _buildTab("F"),
              _buildTab("S"),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: _tabController,
              children: const [
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
          SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }
}
