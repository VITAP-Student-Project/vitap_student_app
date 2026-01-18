import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/for_you_viewmodel.dart';

class ForYouCard extends StatelessWidget {
  final ForYouItem item;
  final bool isLiked;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final bool showLikes;

  const ForYouCard({
    super.key,
    required this.item,
    required this.isLiked,
    required this.onTap,
    required this.onLike,
    this.showLikes = true,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate card width based on screen size
    // This ensures cards adapt to different screen sizes
    final screenWidth = MediaQuery.of(context).size.width;
    // Leave 16px padding on each side and 12px spacing between cards
    // Fit as many cards as possible with min width of 160
    final availableWidth = screenWidth - 16; // 8px padding on each side
    final cardWidth = availableWidth < 360
        ? (availableWidth - 12) / 2 // 2 cards for small screens
        : availableWidth < 540
            ? (availableWidth - 12) / 2 // 2 cards for medium screens
            : (availableWidth - 24) / 3; // 3 cards for large screens

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        width: cardWidth.clamp(150.0, 220.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Container(
                height: cardWidth.clamp(150.0, 220.0) - 25,
                width: cardWidth.clamp(150.0, 220.0) - 25,
                color: Colors.green.shade100,
                child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Iconsax.image,
                            size: 48,
                            color: Colors.green.shade300,
                          ),
                        ),
                      )
                    : Center(
                        child: Icon(
                          Iconsax.image,
                          size: 48,
                          color: Colors.green.shade300,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: item.type == 'event'
                          ? Colors.yellowAccent.shade700.withOpacity(0.20)
                          : item.type == 'resource'
                              ? Colors.greenAccent.shade200.withOpacity(0.20)
                              : Colors.blueAccent.shade200.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        item.type,
                        style: TextStyle(
                          fontSize: 12,
                          color: item.type == 'event'
                              ? Colors.yellow.shade700
                              : item.type == 'resource'
                                  ? Colors.green.shade700
                                  : Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (showLikes)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: onLike,
                          child: Icon(
                            isLiked ? Iconsax.heart : Iconsax.heart_copy,
                            size: 18,
                            color: isLiked
                                ? Colors.red
                                : Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatLikesCount(item.likes),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "by ${item.author}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Know more',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
