import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        final tabNames = ['Weekend Outing', 'General Outing'];
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

  Widget _buildTab(String label) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .secondaryContainer
            .withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Outing",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TabBar(
              controller: _tabController,
              dividerColor: Theme.of(context).colorScheme.surface,
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              splashBorderRadius: BorderRadius.circular(14),
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              unselectedLabelColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              labelColor: Theme.of(context).colorScheme.onSecondaryContainer,
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(9),
              ),
              splashFactory: InkRipple.splashFactory,
              overlayColor: WidgetStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.secondaryContainer,
              ),
              tabs: [
                _buildTab('Weekend'),
                _buildTab('General'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: _tabController,
                children: const [
                  WeekendOutingTab(),
                  GeneralOutingTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
