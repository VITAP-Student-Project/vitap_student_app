import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/exam_card.dart';

class ExamList extends StatelessWidget {
  final List<ExamSchedule> examSchedule;
  final String examType;

  const ExamList({
    super.key,
    required this.examSchedule,
    required this.examType,
  });

  @override
  Widget build(BuildContext context) {
    final filteredSchedules = examSchedule
        .where((schedule) => schedule.examType == examType)
        .expand((schedule) => schedule.subjects)
        .toList();

    if (filteredSchedules.isEmpty) {
      return const EmptyContentView(
        primaryText: "No exams found",
        secondaryText: "Seems like exams are not schedule yet!",
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: filteredSchedules.length,
      itemBuilder: (context, index) {
        final exam = filteredSchedules[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ExamCard(exam: exam),
        );
      },
    );
  }
}
