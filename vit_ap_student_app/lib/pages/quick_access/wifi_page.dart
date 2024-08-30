import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiPage extends StatefulWidget {
  @override
  _WifiPageState createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // initialize accessPoints and subscription
  List<WiFiAccessPoint> accessPoints = [];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;

  void _startScan() async {
    // check platform support and necessary requirements
    final can = await WiFiScan.instance.canStartScan(askPermissions: true);
    switch (can) {
      case CanStartScan.yes:
        // start full scan async-ly
        final isScanning = await WiFiScan.instance.startScan();
        //...
        break;
      // ... handle other cases of CanStartScan values
      case CanStartScan.notSupported:
      // TODO: Handle this case.
      case CanStartScan.noLocationPermissionRequired:
      // TODO: Handle this case.
      case CanStartScan.noLocationPermissionDenied:
      // TODO: Handle this case.
      case CanStartScan.noLocationPermissionUpgradeAccuracy:
      // TODO: Handle this case.
      case CanStartScan.noLocationServiceDisabled:
      // TODO: Handle this case.
      case CanStartScan.failed:
      // TODO: Handle this case.
    }
  }

  void _startListeningToScannedResults() async {
    // check platform support and necessary requirements
    final can =
        await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        // listen to onScannedResultsAvailable stream
        subscription =
            WiFiScan.instance.onScannedResultsAvailable.listen((results) {
          // update accessPoints
          setState(() => accessPoints = results);
        });
        // ...
        break;
      // ... handle other cases of CanGetScannedResults values
      case CanGetScannedResults.notSupported:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionRequired:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionDenied:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
      // TODO: Handle this case.
      case CanGetScannedResults.noLocationServiceDisabled:
      // TODO: Handle this case.
    }
  }

// make sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
    subscription?.cancel();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startScan();
    _startListeningToScannedResults();
    _tabController = TabController(length: 2, vsync: this);

    // Listen to tab changes and rebuild UI
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
          title: Text('Wi-Fi'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
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
                  HostelWifiTab(
                    accessPoints: accessPoints,
                  ),
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

class HostelWifiTab extends StatefulWidget {
  final List<WiFiAccessPoint> accessPoints;

  HostelWifiTab({required this.accessPoints});

  @override
  State<HostelWifiTab> createState() => _HostelWifiTabState();
}

class _HostelWifiTabState extends State<HostelWifiTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.accessPoints.length,
      itemBuilder: (context, index) {
        final accessPoint = widget.accessPoints[index];
        return ListTile(
          title: Text(accessPoint.ssid),
          subtitle: Text('Signal Strength: ${accessPoint.level} dBm'),
        );
      },
    );
  }
}

class UniversityWifiTab extends StatefulWidget {
  @override
  State<UniversityWifiTab> createState() => _UniversityWifiTabState();
}

class _UniversityWifiTabState extends State<UniversityWifiTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('University Wi-Fi'),
    );
  }
}
