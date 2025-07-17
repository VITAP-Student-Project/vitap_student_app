import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/exam_list.dart';

class ExamScheduleTabView extends StatelessWidget {
  final TabController tabController;
  final List<ExamSchedule> examSchedule;

  const ExamScheduleTabView({
    super.key,
    required this.tabController,
    required this.examSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        ExamList(examSchedule: examSchedule, examType: 'CAT1'),
        ExamList(examSchedule: examSchedule, examType: 'CAT2'),
        ExamList(examSchedule: examSchedule, examType: 'FAT'),
      ],
    );
  }
}
