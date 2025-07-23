import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/wifi/hostel_wifi_tab.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/wifi/university_wifi_tab.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  WifiPageState createState() => WifiPageState();
}

class WifiPageState extends State<WifiPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  Widget _buildTab(String label, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 50,
      width: 125,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.orange.shade700
            : Colors.orange.shade300.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Theme.of(context).colorScheme.surface
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
          title: Text(
            'Wi-Fi',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              child: TabBar(
                dividerColor: Theme.of(context).colorScheme.surface,
                labelPadding: const EdgeInsets.all(0),
                splashBorderRadius: BorderRadius.circular(30),
                labelStyle: const TextStyle(fontSize: 18),
                unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                labelColor: Theme.of(context).colorScheme.surface,
                controller: _tabController,
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                ),
                splashFactory: InkRipple.splashFactory,
                overlayColor: WidgetStateColor.resolveWith(
                    (states) => Colors.orange.shade300.withOpacity(0.2)),
                tabs: [
                  _buildTab('Hostel Wi-Fi', _tabController.index == 0),
                  _buildTab('University Wi-Fi', _tabController.index == 1),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HostelWifiTab(),
                  UniversityWifiTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
