import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../utils/api/apis.dart';
import '../../utils/text_newline.dart';

class MyAttendancePage extends StatefulWidget {
  const MyAttendancePage({super.key});

  @override
  _MyAttendancePageState createState() => _MyAttendancePageState();
}

class _MyAttendancePageState extends State<MyAttendancePage> {
  final AttendanceService _attendanceService = AttendanceService();
  late Future<Map<String, dynamic>> attendanceData;
  DateTime? lastSynced;

  @override
  void initState() {
    super.initState();
    loadLastSynced();
    attendanceData = _attendanceService.getStoredAttendanceData();
  }

  Future<void> loadLastSynced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSyncedString = prefs.getString('lastSynced');
    if (lastSyncedString != null) {
      setState(() {
        lastSynced = DateTime.parse(lastSyncedString);
      });
    }
  }

  Future<void> saveLastSynced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSynced', lastSynced!.toIso8601String());
  }

  Future<void> refreshAttendanceData() async {
    attendanceData = _attendanceService.fetchAndStoreAttendanceData();
    setState(() {
      lastSynced = DateTime.now();
    });
    saveLastSynced();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 75,
            backgroundColor: Theme.of(context).colorScheme.background,
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
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Attendance",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (lastSynced != null)
                      Text(
                        "Last Synced: ${DateFormat('d MMM, hh:mm a').format(lastSynced!)} 💾 (${timeago.format(lastSynced!)})",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: attendanceData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
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
                          height: 125,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      addNewlines(
                                          attendance['course_name'], 25),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Chip(
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Colors.white70,
                                      label: Text(
                                        attendance['course_code'],
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 35,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      '${attendance['attendance_percentage']}%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
                          frameRate: const FrameRate(60),
                          width: 150,
                        ),
                        const Text('Unknown error occurred'),
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
