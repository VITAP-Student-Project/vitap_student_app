import 'package:flutter/material.dart';

class AttendancePercentageText extends StatelessWidget {
  final double attendancePercentage;
  final double betweenAttendancePercentage;

  const AttendancePercentageText({
    super.key,
    required this.attendancePercentage,
    required this.betweenAttendancePercentage,
  });

  @override
  Widget build(BuildContext context) {
    // Use the highest value between attendancePercentage and betweenAttendancePercentage
    final percentageToCheck = attendancePercentage > betweenAttendancePercentage
        ? attendancePercentage
        : betweenAttendancePercentage;

    final isLowAttendance = percentageToCheck < 75;
    final deficit = isLowAttendance ? (75 - percentageToCheck).ceil() : 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${percentageToCheck.toStringAsFixed(0)}%",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLowAttendance
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary,
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isLowAttendance) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 6),
            child: Text(
              "-$deficit",
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
