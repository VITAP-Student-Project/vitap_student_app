import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/outing_reports_viewmodel.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/outing/general_outing_card.dart';

class GeneralOutingHistoryPage extends ConsumerStatefulWidget {
  const GeneralOutingHistoryPage({super.key});

  @override
  ConsumerState<GeneralOutingHistoryPage> createState() =>
      _GeneralOutingHistoryPageState();
}

class _GeneralOutingHistoryPageState
    extends ConsumerState<GeneralOutingHistoryPage> {
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
    await AnalyticsService.logEvent('refresh_general_outing_history');
    setState(() {
      lastSynced = DateTime.now();
    });
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(generalOutingReportsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('General Outing History'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: state?.when(
              data: (reports) {
                if (reports.isEmpty) {
                  return const Center(
                    child: EmptyContentView(
                      primaryText: 'No general outing applications found',
                      secondaryText:
                          'Your outing applications will appear here',
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    return GeneralOutingCard(
                      outing: reports[index],
                    );
                  },
                );
              },
              loading: () => const Loader(),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: $error',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ) ??
            const Loader(),
      ),
    );
  }
}
