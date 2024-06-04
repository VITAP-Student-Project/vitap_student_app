import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../utils/api/attendence_api.dart';
import '../features/bottom_navigation_bar.dart';

class MyAttendencePage extends StatefulWidget {
  const MyAttendencePage({super.key});

  @override
  State<MyAttendencePage> createState() => _MyAttendencePageState();
}

class _MyAttendencePageState extends State<MyAttendencePage> {
  @override
  Widget build(BuildContext context) {
    final double val = 75;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyBNB()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          iconSize: 20,
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                value: 0,
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                fetchAttendence("23BCE7625", "@t6echafuweCo", "AP2023247");
              }
            },
          )
        ],
        centerTitle: true,
        title: Text("My Attendence"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(value: val),
                  PieChartSectionData(value: 100 - val),
                ],
              ),
              swapAnimationDuration: Duration(milliseconds: 750), // Optional
              swapAnimationCurve: Curves.easeInOutQuart, // Optional
            ),
          )
        ],
      ),
    );
  }
}
