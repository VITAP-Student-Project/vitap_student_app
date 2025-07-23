import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/attendance/view/widgets/attendance_bottom_sheet.dart';
import 'package:vit_ap_student_app/features/attendance/viewmodel/attendance_viewmodel.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key});

  @override
  AttendancePageState createState() => AttendancePageState();
}

class AttendancePageState extends ConsumerState<AttendancePage> {
  DateTime? lastSynced;

  @override
  void initState() {
    super.initState();
    loadLastSynced();
    AnalyticsService.logScreen('AttendancePage');
  }

  Future<void> loadLastSynced() async {
    final prefs = ref.read(userPreferencesNotifierProvider);
    DateTime? lastSyncedString = prefs.attendanceLastSync;
    if (lastSyncedString != null) {
      setState(() {
        lastSynced = lastSyncedString;
      });
    }
  }

  Future<void> saveLastSynced() async {
    final prefs = ref.read(userPreferencesNotifierProvider);
    await ref
        .read(userPreferencesNotifierProvider.notifier)
        .updatePreferences(prefs.copyWith(attendanceLastSync: lastSynced!));
  }

  Future<void> refreshAttendanceData() async {
    ref.read(attendanceViewModeProvider.notifier).refreshAttendance();
    await AnalyticsService.logEvent('refresh_attendance');
    lastSynced = DateTime.now();
    saveLastSynced();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);

    final isLoading = ref.watch(
        attendanceViewModeProvider.select((val) => val?.isLoading == true));

    ref.listen(
      attendanceViewModeProvider,
      (_, next) {
        next?.when(
          data: (data) {},
          loading: () {},
          error: (error, st) {
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
        );
      },
    );

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: false,
            automaticallyImplyLeading: true,
            expandedHeight: 75,
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Attendance",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 5),
                if (lastSynced != null)
                  Text(
                    "Last Synced: ${DateFormat('d MMM, hh:mm a').format(lastSynced!)} 💾 (${timeago.format(lastSynced!)})",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
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
              ),
            ],
          ),
          if (isLoading)
            SliverFillRemaining(
              child: Loader(),
            )
          else if (user == null)
            SliverFillRemaining(
                child: ErrorContentView(
              error: "User not found!.",
            ))
          else
            Builder(
              builder: (context) {
                final attendances = user.attendance.toList();
                log(attendances.toString());

                if (attendances.isEmpty) {
                  return SliverFillRemaining(
                    child: EmptyContentView(
                      primaryText: "Feels so empty",
                      secondaryText: "No attendance found",
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: attendances.length,
                    (context, index) {
                      final attendance = attendances[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Row(
                          children: [
                            Flexible(
                              child: ListTile(
                                tileColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerLow,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                    const SizedBox(height: 24),
                                    Text(
                                      attendance.courseName,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      attendance.courseCode,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w600,
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
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
