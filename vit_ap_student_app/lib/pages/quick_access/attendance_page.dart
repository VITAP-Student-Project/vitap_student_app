import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vit_ap_student_app/utils/provider/student_provider.dart';
import '../../utils/model/attendance_model.dart';
import 'attendance_bottom_sheet.dart';

class MyAttendancePage extends ConsumerStatefulWidget {
  const MyAttendancePage({super.key});

  @override
  _MyAttendancePageState createState() => _MyAttendancePageState();
}

class _MyAttendancePageState extends ConsumerState<MyAttendancePage> {
  late Future<Map<String, dynamic>> attendanceData;
  DateTime? lastSynced;

  @override
  void initState() {
    super.initState();
    loadLastSynced();
  }

  Future<void> loadLastSynced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSyncedString = prefs.getString('lastSynced');
    if (lastSyncedString == null) {}
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
    log("Going to fetch new attendance");
    await ref.read(studentProvider.notifier).refreshAttendance();
    lastSynced = DateTime.now();

    saveLastSynced();
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);

    // Log the current state to debug
    log('Current attendance state: ${studentState.value?.attendance.toString()}');

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 75,
            backgroundColor: Theme.of(context).colorScheme.surface,
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
              ),
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
          studentState.when(
            loading: () => SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, _) {
              log(error.toString());
              return SliverFillRemaining(
                child: Center(
                  child: SelectableText('Error: ${error.toString()}'),
                ),
              );
            },
            data: (data) {
              final attendance = data.attendance;
              if (attendance.isEmpty) {
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
              final keys = attendance.keys.toList();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final key = keys[index];
                    final Attendance attendance = data.attendance[key]!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Row(
                        children: [
                          Flexible(
                            child: ListTile(
                              tileColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${attendance.attendancePercentage}%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  attendance.courseType.contains("Theory")
                                      ? Image.asset(
                                          "assets/images/icons/theory.png",
                                          height: 24,
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Image.asset(
                                            "assets/images/icons/lab.png",
                                            height: 24,
                                          ),
                                        ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    attendance.courseName,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    attendance.courseCode,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showAttendanceBottomSheet(
                                  context, attendance),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: keys.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
