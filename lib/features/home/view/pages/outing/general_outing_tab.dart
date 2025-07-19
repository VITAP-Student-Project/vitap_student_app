import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/outing_reports_viewmodel.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/outing/general_outing_card.dart';

class GeneralOutingTab extends ConsumerStatefulWidget {
  const GeneralOutingTab({super.key});

  @override
  ConsumerState<GeneralOutingTab> createState() => _GeneralOutingTabState();
}

class _GeneralOutingTabState extends ConsumerState<GeneralOutingTab> {
  DateTime? lastSynced;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    await ref
        .read(generalOutingReportsViewModelProvider.notifier)
        .fetchGeneralOutingReports();
  }

  Future<void> _refreshData() async {
    await AnalyticsService.logEvent('refresh_general_outing');
    setState(() {
      lastSynced = DateTime.now();
    });
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final outingReportsState = ref.watch(generalOutingReportsViewModelProvider);

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: CustomScrollView(
        slivers: [
          // Content based on state
          outingReportsState?.when(
                data: (reports) {
                  if (reports.isEmpty) {
                    return const SliverFillRemaining(
                      child: EmptyContentView(
                        primaryText: 'Feels So Empty',
                        secondaryText: 'No general outing reports found',
                      ),
                    );
                  }

                  return SliverList.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        child: GeneralOutingCard(outing: reports[index]),
                      );
                    },
                  );
                },
                loading: () => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Loading general outings...',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                error: (error, stackTrace) => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.danger,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load general outings',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _refreshData,
                          icon: const Icon(Iconsax.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ) ??
              const SliverFillRemaining(
                child: EmptyContentView(
                  primaryText: 'General Outings',
                  secondaryText:
                      'Pull to refresh and load your general outing reports',
                ),
              ),
        ],
      ),
    );
  }
}
