import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/section_header.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/home/view/pages/for_you_view_all_page.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/announcement_container.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/for_you_carousel.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/home_app_bar.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/home_greeting.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/quick_access/quick_access.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/today_class_count_badge.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/today_schedule_stack.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/weather_container.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(analyticsServiceProvider).logScreen('HomePage');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const HomeAppBar(),
          SliverToBoxAdapter(
            child: HomeGreeting(
              username: user?.profile.target?.studentName ?? 'NaN',
            ),
          ),
          const SliverToBoxAdapter(child: AnnouncementContainer()),
          const SliverToBoxAdapter(
            child: SectionHeader(
              label: 'Today',
              variant: SectionHeaderVariant.home,
              padding: SectionHeader.standalone,
              trailing: TodayClassCountBadge(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              // Aligned to the section header's 16pt gutter rather than the 8pt
              // the older sections still use, so the cards line up under "Today".
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TodayScheduleStack(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionHeader(
              label: 'Weather',
              variant: SectionHeaderVariant.home,
              padding: SectionHeader.standalone,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: WeatherContainer(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionHeader(
              label: 'Quick Access',
              variant: SectionHeaderVariant.home,
              padding: SectionHeader.standalone,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: QuickAccess(),
            ),
          ),

          SliverToBoxAdapter(
            child: SectionHeader(
              label: 'For You',
              variant: SectionHeaderVariant.home,
              padding: SectionHeader.standalone,
              trailing: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const ForYouViewAllPage(),
                    ),
                  );
                },
                label: const Text('View All'),
                icon: const Icon(Iconsax.arrow_right_1_copy),
                iconAlignment: IconAlignment.end,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ForYouCarousel(),
            ),
          ),
        ],
      ),
    );
  }
}
