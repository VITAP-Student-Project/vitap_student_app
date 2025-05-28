import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/empty_exam_schedule_page.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/exam_schedule_tab_bar.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/exam_schedule_tab_view.dart';

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> refreshExamSchedule() async {
    // await ref.read(studentProvider.notifier).refreshExamSchedule(ref);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);

    if (user == null) return const EmptyExamSchedulePage();

    final examSchedule = user.examSchedule;

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
      body: ExamScheduleTabView(
        tabController: _tabController,
        examSchedule: examSchedule.toList(),
      ),
    );
  }
}
