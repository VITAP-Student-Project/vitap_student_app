import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';

class ExamCard extends StatelessWidget {
  final Subject exam;
  final VoidCallback? onTap;

  const ExamCard({
    super.key,
    required this.exam,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Parse date for better UX
    final isToday = _isToday(exam.date);
    final isUpcoming = _isUpcoming(exam.date);

    return Card(
      elevation: 2,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isToday
                ? Border.all(color: colorScheme.primary, width: 2)
                : null,
            gradient: isToday
                ? LinearGradient(
                    colors: [
                      colorScheme.primaryContainer.withOpacity(0.1),
                      colorScheme.surface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with date and status
              Row(
                children: [
                  Expanded(
                    child: _DateTimeChip(
                      date: exam.date,
                      session: exam.session,
                      isToday: isToday,
                      colorScheme: colorScheme,
                    ),
                  ),
                  if (isToday) _TodayBadge(colorScheme: colorScheme),
                  if (isUpcoming && !isToday)
                    _UpcomingBadge(colorScheme: colorScheme),
                ],
              ),

              const SizedBox(height: 16),

              // Course information
              Text(
                exam.courseTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              Text(
                exam.courseCode,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              // Exam details in organized sections
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _DetailSection(
                      icon: Icons.access_time,
                      title: 'Time',
                      content: exam.examTime,
                      colorScheme: colorScheme,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DetailSection(
                      icon: Icons.location_on,
                      title: 'Venue',
                      content: exam.venue,
                      colorScheme: colorScheme,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _DetailSection(
                      icon: Icons.event_seat,
                      title: 'Seat Location',
                      content: exam.seatLocation.trim(),
                      colorScheme: colorScheme,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DetailSection(
                      icon: Icons.numbers,
                      title: 'Seat Number',
                      content: exam.seatNumber.trim(),
                      colorScheme: colorScheme,
                    ),
                  ),
                ],
              ),

              if (exam.reportingTime.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Reporting: ${exam.reportingTime}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  bool _isToday(String dateStr) {
    try {
      final examDate = DateTime.parse(dateStr);
      final today = DateTime.now();
      return examDate.year == today.year &&
          examDate.month == today.month &&
          examDate.day == today.day;
    } catch (e) {
      return false;
    }
  }

  bool _isUpcoming(String dateStr) {
    try {
      final examDate = DateTime.parse(dateStr);
      final today = DateTime.now();
      return examDate.isAfter(today) && examDate.difference(today).inDays <= 7;
    } catch (e) {
      return false;
    }
  }
}

class _DateTimeChip extends StatelessWidget {
  final String date;
  final String session;
  final bool isToday;
  final ColorScheme colorScheme;

  const _DateTimeChip({
    required this.date,
    required this.session,
    required this.isToday,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isToday
            ? colorScheme.primary.withOpacity(0.1)
            : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$date • $session',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isToday ? colorScheme.primary : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _TodayBadge extends StatelessWidget {
  final ColorScheme colorScheme;

  const _TodayBadge({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'TODAY',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class _UpcomingBadge extends StatelessWidget {
  final ColorScheme colorScheme;

  const _UpcomingBadge({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'UPCOMING',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: colorScheme.onTertiary,
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final ColorScheme colorScheme;

  const _DetailSection({
    required this.icon,
    required this.title,
    required this.content,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
