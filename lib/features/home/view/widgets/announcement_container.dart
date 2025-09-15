import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/features/home/model/announcement.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/announcement_viewmodel.dart';

class AnnouncementContainer extends ConsumerWidget {
  const AnnouncementContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcementAsyncValue = ref.watch(announcementViewModelProvider);

    return announcementAsyncValue?.when(
          loading: () => const SizedBox.shrink(), // Hide loading indicator
          error: (err, stack) => const SizedBox.shrink(), // Hide on error
          data: (announcements) {
            if (announcements.isEmpty) {
              return const SizedBox.shrink(); // Hide if no announcements
            }

            // Show only the first 3 most important announcements
            final displayAnnouncements = announcements.take(3).toList();

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.surfaceContainerLow,
                    Theme.of(context)
                        .colorScheme
                        .surfaceContainerLow
                        .withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Iconsax.info_circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Important Announcements',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ),
                        if (announcements.length > 3)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '+${announcements.length - 3}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Announcements List
                  ...displayAnnouncements.asMap().entries.map((entry) {
                    final index = entry.key;
                    final announcement = entry.value;
                    final isLast = index == displayAnnouncements.length - 1;

                    return Container(
                      margin: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: isLast ? 16 : 0,
                      ),
                      child: Column(
                        children: [
                          if (index != 0)
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.3),
                            ),
                          AnnouncementTile(announcement: announcement),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ) ??
        const SizedBox.shrink();
  }
}

class AnnouncementTile extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementTile({
    super.key,
    required this.announcement,
  });

  Color _getImportanceColor(BuildContext context, String importance) {
    switch (importance.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.blue;
      case 'low':
        return Colors.green;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'academic':
        return Iconsax.book;
      case 'facility':
        return Iconsax.building;
      case 'maintenance':
        return Iconsax.setting_2;
      case 'system':
        return Iconsax.monitor;
      case 'general':
        return Iconsax.info_circle;
      default:
        return Iconsax.info_circle;
    }
  }

  String _getRelativeTime(String dateTimeString) {
    final createdAt = DateTime.parse(dateTimeString);
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final importanceColor =
        _getImportanceColor(context, announcement.importance);
    final typeIcon = _getTypeIcon(announcement.type);
    final relativeTime = _getRelativeTime(announcement.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type icon with importance color
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: importanceColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              typeIcon,
              color: importanceColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and time
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        announcement.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      relativeTime,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Message
                Text(
                  announcement.message,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                        height: 1.3,
                      ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                // Action button if available
                if (announcement.actionUrl != null &&
                    announcement.actionText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () => _launchUrl(announcement.actionUrl!),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: importanceColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: importanceColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              announcement.actionText!,
                              style: TextStyle(
                                color: importanceColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Iconsax.arrow_right_3,
                              color: importanceColor,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
