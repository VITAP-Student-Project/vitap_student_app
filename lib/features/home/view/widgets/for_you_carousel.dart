import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';
import 'package:vit_ap_student_app/features/home/view/pages/for_you_view_all_page.dart';
import 'package:vit_ap_student_app/features/home/view/pages/tile_detail_page.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/for_you_card.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/for_you_viewmodel.dart';

class ForYouCarousel extends ConsumerWidget {
  const ForYouCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredItems = ref.watch(featuredItemsProvider);
    final itemsAsync = ref.watch(forYouViewModelProvider);
    final likedItems = ref.watch(likedItemsSessionProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 2.0, top: 12.0),
              child: Text(
                "For You",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForYouViewAllPage(),
                  ),
                );
              },
              label: const Text("View All"),
              icon: const Icon(Iconsax.arrow_right_1_copy),
              iconAlignment: IconAlignment.end,
            )
          ],
        ),
        itemsAsync.when(
          data: (_) => featuredItems.isEmpty
              ? _buildEmptyState(context)
              : SizedBox(
                  height: 375,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredItems.length,
                    itemBuilder: (context, index) {
                      final item = featuredItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ForYouCard(
                          item: item,
                          isLiked: likedItems.contains(item.id),
                          showLikes: false,
                          onTap: () => _navigateToDetail(context, item),
                          onLike: () => ref
                              .read(forYouViewModelProvider.notifier)
                              .likeItem(item.id),
                        ),
                      );
                    },
                  ),
                ),
          loading: () => const SizedBox(
            height: 375,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => _buildErrorState(context, ref, error.toString()),
        ),
      ],
    );
  }

  void _navigateToDetail(BuildContext context, ForYouItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TileDetailPage(
          title: item.title,
          author: item.author,
          description: item.description,
          url: item.url,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.box_1,
              size: 48,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 8),
            Text(
              'No featured tools yet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.warning_2,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 8),
            Text(
              'Failed to load tools',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () {
                ref.read(forYouViewModelProvider.notifier).refresh();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
