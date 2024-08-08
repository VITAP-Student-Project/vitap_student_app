import 'package:flutter/material.dart';

class WifiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wifi'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Hostel Wifi'),
              Tab(text: 'University Wifi'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WeekendOutingTab(),
            GeneralOutingTab(),
          ],
        ),
      ),
    );
  }
}

class WeekendOutingTab extends StatefulWidget {
  @override
  State<WeekendOutingTab> createState() => _WeekendOutingTabState();
}

class _WeekendOutingTabState extends State<WeekendOutingTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Weekend Outing Content'),
    );
  }
}

class GeneralOutingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('General Outing Content'),
    );
  }
}
