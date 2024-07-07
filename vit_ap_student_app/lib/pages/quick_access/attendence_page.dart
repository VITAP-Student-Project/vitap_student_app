import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../pages/features/bottom_navigation_bar.dart';
import '../../../utils/api/attendence_api.dart';
import '../../utils/text_newline.dart';

class MyAttendancePage extends StatefulWidget {
  const MyAttendancePage({super.key});

  @override
  _MyAttendancePageState createState() => _MyAttendancePageState();
}

class _MyAttendancePageState extends State<MyAttendancePage> {
  static const username = '23BCE7625';
  static const password = 'v+v2no@tOw';
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 65,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBNB()),
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
              title: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Text(
                  "My Attendance",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: attendanceData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                if (data.isEmpty) {
                  return SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Lottie.asset(
                              'assets/images/lottie/404_astronaut.json',
                              frameRate: const FrameRate(60),
                              width: 250,
                            ),
                          ),
                          const Text(
                            'Oops!',
                            style: TextStyle(fontSize: 32),
                          ),
                          const Text(
                            'Page not found',
                            style: TextStyle(fontSize: 32),
                          ),
                          const Text(
                            'The page you are looking for does not exist or some other error occurred',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final keys = data.keys.toList();
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final key = keys[index];
                      final attendance = data[key];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 150,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      addNewlines(attendance['CourseName'], 20),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      attendance['CourseCode'],
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '${attendance['AttendedClasses']}/${attendance['TotalClasses']} classes attended',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: SizedBox(
                                          width: 75,
                                          height: 75,
                                          child: PieChart(
                                            swapAnimationDuration:
                                                const Duration(
                                                    milliseconds: 750),
                                            swapAnimationCurve:
                                                Curves.easeInOutQuint,
                                            PieChartData(
                                              startDegreeOffset: -90,
                                              sections: [
                                                PieChartSectionData(
                                                  showTitle: false,
                                                  radius: 10,
                                                  color: Colors.black87,
                                                  value: 100 -
                                                      double.parse(attendance[
                                                          'AttendancePercentage']),
                                                ),
                                                PieChartSectionData(
                                                  titlePositionPercentageOffset:
                                                      -2.9,
                                                  radius: 10,
                                                  color: Colors.green,
                                                  value: double.parse(
                                                    attendance[
                                                        'AttendancePercentage'],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: keys.length,
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          'assets/images/lottie/not_found_ghost.json',
                          frameRate: FrameRate(60),
                          width: 150,
                        ),
                        Text('Unknown error occurred'),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
