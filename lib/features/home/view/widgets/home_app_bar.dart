import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/providers/bottom_nav_provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      elevation: 0,
      automaticallyImplyLeading: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.2,
        centerTitle: true,
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(builder: (context, ref, child) {
              return GestureDetector(
                onTap: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 3;
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/images/pfp/default.png',
                  ),
                ),
              );
            }),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Consumer(builder: (context, ref, child) {
                      return IconButton(
                        icon: const Icon(
                          Iconsax.document_copy,
                          size: 20,
                        ),
                        splashRadius: 30,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          ref.read(bottomNavIndexProvider.notifier).state = 2;
                        },
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Iconsax.notification_copy,
                        size: 20,
                      ),
                      splashRadius: 30,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
