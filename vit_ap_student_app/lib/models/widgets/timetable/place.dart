import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/models/widgets/timetable/my_tab_bar.dart';
import '../../../pages/features/bottom_navigation_bar.dart';
import '../../../utils/api/attendence_api.dart';
import '../../../utils/api/timetable_api.dart';

class MyAttendancePage extends StatefulWidget {
  const MyAttendancePage({Key? key}) : super(key: key);

  @override
  _MyAttendancePageState createState() => _MyAttendancePageState();
}

class _MyAttendancePageState extends State<MyAttendancePage> {
  static const username = '23BCE7625';
  static const password = '@t6echafuweCo';
  static const semSubID = 'AP2023247';

  final AttendanceService _attendanceService = AttendanceService();
  late Future<Map<String, dynamic>> attendanceData;

  @override
  void initState() {
    super.initState();
    attendanceData = _attendanceService.getStoredAttendanceData();
  }

  Future<void> refreshAttendanceData() async {
    attendanceData = _attendanceService.fetchAndStoreAttendanceData(
        username, password, semSubID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 90,
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBNB()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.secondary,
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
                    value: 0,
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 0) {
                    refreshAttendanceData();
                  }
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Attendance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<Map<String, dynamic>>(
              future: attendanceData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  if (data.isEmpty) {
                    return Center(child: Text('No attendance data found.'));
                  }
                  final keys = data.keys.toList();

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: keys.length,
                          itemBuilder: (context, index) {
                            final key = keys[index];
                            final attendance = data[key];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 150,
                                child: ListTile(
                                  title: Text(attendance['CourseName']),
                                  subtitle: Text(
                                    '${attendance['CourseCode']}\n'
                                    '${attendance['CourseType']}\n'
                                    '${attendance['AttendancePercentage']}% (${attendance['AttendedClasses']}/${attendance['TotalClasses']})',
                                  ),
                                  trailing: Container(
                                    width: 75,
                                    height: 75,
                                    child: PieChart(
                                      swapAnimationDuration:
                                          Duration(milliseconds: 750),
                                      swapAnimationCurve: Curves.easeInOutQuint,
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            titlePositionPercentageOffset: -4,
                                            radius: 5,
                                            color: Colors.green,
                                            value: double.parse(
                                              attendance[
                                                  'AttendancePercentage'],
                                            ),
                                          ),
                                          PieChartSectionData(
                                            showTitle: false,
                                            titlePositionPercentageOffset: -4,
                                            radius: 5,
                                            color: Colors.red,
                                            value: 100 -
                                                (double.parse(
                                                  attendance[
                                                      'AttendancePercentage'],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text('Unknown error occurred'));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
