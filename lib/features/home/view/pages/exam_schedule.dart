import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/exam_schedule_tab_bar.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/exam_schedule_tab_view.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/exam_schedule_viewmodel.dart';

class ExamSchedulePage extends ConsumerStatefulWidget {
  const ExamSchedulePage({super.key});

  @override
  ConsumerState<ExamSchedulePage> createState() => _MyExamScheduleState();
}

class _MyExamScheduleState extends ConsumerState<ExamSchedulePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    AnalyticsService.logScreen('ExamSchedulePage');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> refreshExamSchedule() async {
    await ref
        .read(examScheduleViewModelProvider.notifier)
        .refreshExamSchedule();
    await AnalyticsService.logEvent('refresh_exam_schedule');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);

    final examSchedule = user?.examSchedule;

    final isLoading = ref.watch(
        examScheduleViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      examScheduleViewModelProvider,
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
      appBar: AppBar(
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
                refreshExamSchedule();
              }
            },
          ),
        ],
        title: const Text('Exam Schedule'),
        bottom: ExamScheduleTabBar(tabController: _tabController),
      ),
      body: user == null
          ? ErrorContentView(
              error: "User not found!",
            )
          : isLoading
              ? Loader()
              : ExamScheduleTabView(
                  tabController: _tabController,
                  examSchedule: examSchedule?.toList() ?? [],
                ),
    );
  }
}
