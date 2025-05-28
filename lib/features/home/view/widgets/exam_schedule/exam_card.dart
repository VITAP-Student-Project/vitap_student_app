import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/exam_schedule/exam_detail_chip.dart';

class ExamCard extends StatelessWidget {
  final Subject exam;

  const ExamCard({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    exam.courseTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  exam.date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              children: [
                ExamDetailChip(label: 'Code', value: exam.courseCode),
                ExamDetailChip(label: 'Slot', value: exam.slot),
                ExamDetailChip(label: 'Time', value: exam.examTime),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              children: [
                ExamDetailChip(label: 'Session', value: exam.session),
                ExamDetailChip(label: 'Venue', value: exam.venue),
                ExamDetailChip(label: 'Seat', value: exam.seatNumber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
