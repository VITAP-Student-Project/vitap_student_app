import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/announcement_container.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/for_you_carousel.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/grade_history_carousel.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/home_app_bar.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/home_greeting.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/quick_access/quick_access.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/upcoming_classes_carousel.dart';
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
    AnalyticsService.logScreen('HomePage');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          const HomeAppBar(),
          SliverToBoxAdapter(
            child: HomeGreeting(
              username: user?.profile.target?.studentName ?? "NaN",
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AnnouncementContainer(),
            ),
          ),
          SliverToBoxAdapter(
            child: GradeHistoryCarousel(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 2.0, top: 4.0),
              child: Text(
                "Today",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: UpcomingClassesCarousel(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 2.0, top: 12.0),
              child: Text(
                "Weather",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WeatherContainer(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 2.0, top: 12.0),
              child: Text(
                "Quick Access",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuickAccess(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 2.0, top: 12.0),
              child: Text(
                "For You",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ForYouCarousel(),
            ),
          ),
        ],
      ),
    );
  }
}
