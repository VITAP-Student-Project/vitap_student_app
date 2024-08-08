import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';
import 'package:permission_handler/permission_handler.dart';

class WifiBottomSheet extends StatefulWidget {
  @override
  State<WifiBottomSheet> createState() => _WifiBottomSheetState();
}

Future<bool> requestWifiPermissions() async {
  var status = await Permission.locationWhenInUse.status;
  if (status.isDenied) {
    status = await Permission.locationWhenInUse.request();
  }
  if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}

@override
void initState() {
  requestWifiPermissions();
}

class _WifiBottomSheetState extends State<WifiBottomSheet> {
  WiFiHunterResult wiFiHunterResult = WiFiHunterResult();

  Future<void> huntWiFis() async {
    try {
      wiFiHunterResult = (await WiFiHunter.huntWiFiNetworks)!;
    } on PlatformException catch (exception) {
      print(exception.toString());
    }

    for (var i = 0; i < wiFiHunterResult.results.length;) {
      print('Wifi Name : ${wiFiHunterResult.results[i].ssid}');
      print('Wifi Level : ${wiFiHunterResult.results[i].level}');
    }

    if (!mounted) return;
  }

  String getSignalStrengthDescription(int level) {
    if (level >= -50) {
      return 'Excellent';
    } else if (level >= -60) {
      return 'Good';
    } else if (level >= -70) {
      return 'Fair';
    } else if (level >= -80) {
      return 'Poor';
    } else {
      return 'Very Poor';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.wifi_rounded),
              Text(
                "Wi-Fi",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Divider(
              thickness: 0.4,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              "Campus Wi-Fi Made Easy",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              "Effortlessly connect to any Wi-Fi network on campus with just a single click. Say goodbye to complicated setups and enjoy seamless internet access wherever you are on campus.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75.0),
            child: Divider(
              thickness: 0.2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.local_hotel_outlined),
                label: Text('Hostel'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.school_outlined),
                label: Text('Hostel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
