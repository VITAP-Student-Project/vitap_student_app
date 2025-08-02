import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/home/view/pages/outing/general_outing_tab.dart';
import 'package:vit_ap_student_app/features/home/view/pages/outing/weekend_outing_tab.dart';

class OutingPage extends ConsumerStatefulWidget {
  const OutingPage({super.key});

  @override
  ConsumerState<OutingPage> createState() => _OutingPageState();
}

class _OutingPageState extends ConsumerState<OutingPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    AnalyticsService.logScreen('OutingPage');

    // Track tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final tabNames = ['General Outing', 'Weekend Outing'];
        AnalyticsService.logEvent('outing_tab_changed', {
          'tab': tabNames[_tabController.index],
          'tab_index': _tabController.index,
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: false,
            pinned: true,
            elevation: 0,
            title: Text(
              "Outing",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            bottom: TabBar(
              dividerColor: Theme.of(context).colorScheme.surface,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.calendar_1, size: 20),
                      const SizedBox(width: 8),
                      Text('General'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.calendar_2, size: 20),
                      const SizedBox(width: 8),
                      Text('Weekend'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TabBarView(
            controller: _tabController,
            children: const [
              GeneralOutingTab(),
              WeekendOutingTab(),
            ],
          ),
        ),
      ),
    );
  }
}
