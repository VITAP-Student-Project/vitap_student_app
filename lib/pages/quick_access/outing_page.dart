import 'package:flutter/material.dart';
import 'general_outing_tab.dart';
import 'weekend_outing_tab.dart';

class OutingPage extends StatefulWidget {
  @override
  _OutingPageState createState() => _OutingPageState();
}

class _OutingPageState extends State<OutingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(String label, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 50,
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.orange.shade700
            : Colors.orange.shade300.withOpacity(0.2),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Outings'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: TabBar(
                dividerColor: Theme.of(context).colorScheme.surface,
                labelPadding: const EdgeInsets.all(0),
                splashBorderRadius: BorderRadius.circular(26),
                labelStyle: const TextStyle(fontSize: 18),
                unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                labelColor: Theme.of(context).colorScheme.surface,
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                ),
                splashFactory: InkRipple.splashFactory,
                overlayColor: WidgetStateColor.resolveWith(
                  (states) => Colors.orange.shade300.withOpacity(0.2),
                ),
                tabs: [
                  _buildTab('Weekend Outing', _tabController.index == 0),
                  _buildTab('General Outing', _tabController.index == 1),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  WeekendOutingTab(),
                  GeneralOutingTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
