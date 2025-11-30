import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/model/general_outing_report.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/pdf_download_viewmodel.dart';

import 'utils.dart';

void showGeneralOutingDetailBottomSheet(
    GeneralOutingReport outing, BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return _GeneralOutingDetailBottomSheetContent(outing: outing);
    },
  );
}

class _GeneralOutingDetailBottomSheetContent extends ConsumerWidget {
  final GeneralOutingReport outing;

  const _GeneralOutingDetailBottomSheetContent({required this.outing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(generalOutingPdfDownloadViewModelProvider
        .select((val) => val?.isLoading == true));

    // Listen to download state changes
    ref.listen(
      generalOutingPdfDownloadViewModelProvider,
      (_, next) {
        next?.when(
          data: (message) {
            if (message.contains('PDF loaded successfully')) {
              // PDF viewer has been opened, no need to show snackbar
              return;
            } else {
              // This is a file path from download
              Navigator.of(context).pop(); // Close bottom sheet
              showSnackBar(
                context,
                'PDF downloaded successfully',
                SnackBarType.success,
              );
            }
          },
          error: (error, st) {
            showSnackBar(
              context,
              'Failed: $error',
              SnackBarType.error,
            );
          },
          loading: () {},
        );
      },
    );

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        getStatusColor(outing.status, context).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    getStatusIcon(outing.status),
                    color: getStatusColor(outing.status, context),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'General Outing',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        outing.purposeOfVisit,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: getStatusColor(outing.status, context)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          outing.status.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: getStatusColor(outing.status, context),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Details Section
            _buildDetailSection(
              context,
              'Outing Details',
              [
                _DetailItem(
                  icon: Iconsax.location,
                  label: 'Place of Visit',
                  value: outing.placeOfVisit.isEmpty
                      ? 'Not specified'
                      : outing.placeOfVisit,
                ),
                _DetailItem(
                  icon: Iconsax.document_text,
                  label: 'Purpose',
                  value: outing.purposeOfVisit,
                ),
                _DetailItem(
                  icon: Iconsax.user,
                  label: 'Registration Number',
                  value: outing.registrationNumber,
                ),
                _DetailItem(
                  icon: Iconsax.receipt_item,
                  label: 'Leave ID',
                  value: outing.leaveId.isEmpty ? "N/A" : outing.leaveId,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Date & Time Section
            _buildDetailSection(
              context,
              'Schedule',
              [
                _DetailItem(
                  icon: Iconsax.calendar_1,
                  label: 'From Date',
                  value: formatOutingDate(outing.fromDate),
                ),
                _DetailItem(
                  icon: Iconsax.clock,
                  label: 'From Time',
                  value: outing.fromTime,
                ),
                _DetailItem(
                  icon: Iconsax.calendar_2,
                  label: 'To Date',
                  value: formatOutingDate(outing.toDate),
                ),
                _DetailItem(
                  icon: Iconsax.clock,
                  label: 'To Time',
                  value: outing.toTime,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Action Buttons
            if (outing.canDownload) ...[
              // View PDF Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(generalOutingPdfDownloadViewModelProvider
                                  .notifier)
                              .viewGeneralOutingPdf(
                                leaveId: outing.leaveId,
                                context: context,
                                customFileName:
                                    'general_outing_${outing.leaveId}',
                              );
                        },
                  icon: isLoading ? Loader() : const Icon(Iconsax.document_1),
                  label: Text(isLoading ? 'Loading...' : 'View PDF'),
                ),
              ),
              const SizedBox(height: 12),

              // Download PDF Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    side: BorderSide(
                      color: Colors.green.shade500,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(generalOutingPdfDownloadViewModelProvider
                                  .notifier)
                              .downloadGeneralOutingPdf(
                                leaveId: outing.leaveId,
                                customFileName:
                                    'general_outing_${outing.leaveId}',
                              );
                        },
                  icon: Icon(
                    Iconsax.document_download,
                    color: Colors.green.shade500,
                  ),
                  label: Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailSection(
    BuildContext context, String title, List<_DetailItem> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children:
              items.map((item) => _buildDetailRow(context, item)).toList(),
        ),
      ),
    ],
  );
}

Widget _buildDetailRow(BuildContext context, _DetailItem item) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            item.icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                item.value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _DetailItem {
  final IconData icon;
  final String label;
  final String value;

  _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}
