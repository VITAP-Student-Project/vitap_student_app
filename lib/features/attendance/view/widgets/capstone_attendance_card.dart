import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/models/capstone_attendance.dart';
import 'package:vit_ap_student_app/features/attendance/view/widgets/attendance_percentage_text.dart';
import 'package:vit_ap_student_app/features/attendance/view/widgets/capstone_attendance_sheet.dart';

/// The capstone/SDP card, shown in its own tab beside Theory and Lab.
///
/// It gets a tab of its own because a capstone is not a course type: it would
/// match neither the Theory nor the Lab filter and be dropped from both.
class CapstoneAttendanceCard extends StatelessWidget {
  final CapstoneAttendance capstone;

  const CapstoneAttendanceCard({super.key, required this.capstone});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final percentage = capstone.percentageValue;
    // "Capstone" and "SDP" already read as titles; anything else VTOP sends is
    // shown as-is rather than being second-guessed.
    final title = capstone.title.isEmpty ? 'Capstone / SDP' : capstone.title;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ListTile(
        tileColor: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (percentage != null)
              AttendancePercentageText(attendancePercentage: percentage)
            else
              Text(
                'No percentage',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            CapstoneTallyRow(capstone: capstone),
          ],
        ),
        onTap: () => showCapstoneAttendanceSheet(context, capstone),
      ),
    );
  }
}

/// Present / on duty / absent, kept as three separate counts.
///
/// Folding on duty into "attended" is what the day tally is not: VTOP counts it
/// separately, and a student needs to see it separately.
class CapstoneTallyRow extends StatelessWidget {
  final CapstoneAttendance capstone;

  const CapstoneTallyRow({super.key, required this.capstone});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _CapstoneTallyChip(
          label: 'Present',
          value: capstone.present,
          color: colorScheme.primary,
        ),
        _CapstoneTallyChip(
          label: 'On duty',
          value: capstone.onDuty,
          color: colorScheme.tertiary,
        ),
        _CapstoneTallyChip(
          label: 'Absent',
          value: capstone.absent,
          color: colorScheme.error,
        ),
      ],
    );
  }
}

class _CapstoneTallyChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _CapstoneTallyChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ${value.isEmpty ? '-' : value}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
