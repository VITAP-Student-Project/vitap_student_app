import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiPage extends StatefulWidget {
  @override
  _WifiPageState createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<WiFiAccessPoint> accessPoints = [];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;

  void _startScan() async {
    final can = await WiFiScan.instance.canStartScan(askPermissions: true);
    switch (can) {
      case CanStartScan.yes:
        await WiFiScan.instance.startScan();
        break;
      case CanStartScan.notSupported:
      case CanStartScan.noLocationPermissionRequired:
      case CanStartScan.noLocationPermissionDenied:
      case CanStartScan.noLocationPermissionUpgradeAccuracy:
      case CanStartScan.noLocationServiceDisabled:
      case CanStartScan.failed:
    }
  }

  void _startListeningToScannedResults() async {
    final can =
        await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        // Listen to the onScannedResultsAvailable stream
        subscription =
            WiFiScan.instance.onScannedResultsAvailable.listen((results) {
          // Filter results to include only networks with "hostel" in the SSID
          setState(() {
            accessPoints = results
                .where((ap) =>
                    ap.ssid.toLowerCase().contains('hostel') && ap.level >= -50)
                .toList();
          });
        });
        break;
      case CanGetScannedResults.notSupported:
      case CanGetScannedResults.noLocationPermissionRequired:
      case CanGetScannedResults.noLocationPermissionDenied:
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
      case CanGetScannedResults.noLocationServiceDisabled:
    }
  }

  // Function to connect to a specific Wi-Fi network
  Future<void> _connectToWifi(String ssid) async {
    try {
      bool isConnected =
          await WiFiForIoTPlugin.connect(ssid, security: NetworkSecurity.NONE);
      if (isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connected to $ssid')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to $ssid')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
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
                    connectToWifi: _connectToWifi,
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
  final Future<void> Function(String ssid) connectToWifi;

  HostelWifiTab({required this.accessPoints, required this.connectToWifi});

  @override
  State<HostelWifiTab> createState() => _HostelWifiTabState();
}

class _HostelWifiTabState extends State<HostelWifiTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.accessPoints.length,
      itemBuilder: (context, index) {
        final accessPoint = widget.accessPoints[index];
        return ListTile(
          title: Text(accessPoint.ssid),
          subtitle: Text('Signal Strength: ${accessPoint.level} dBm'),
          trailing: (accessPoint.ssid == 'HOSTEL' ||
                  accessPoint.ssid == 'VITAP-HOSTEL')
              ? ElevatedButton(
                  onPressed: () {
                    widget.connectToWifi(accessPoint.ssid);
                  },
                  child: Text('Connect'),
                )
              : null,
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
