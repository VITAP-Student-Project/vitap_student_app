import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/home/model/weekend_outing_report.dart';

import 'utils.dart';

void showWeekendOutingDetailBottomSheet(
    WeekendOutingReport outing, BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      log(outing.status.toLowerCase().trim());
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
                      color: getStatusColor(outing.status, context)
                          .withOpacity(0.1),
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
                          'Weekend Outing',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          outing.purposeOfVisit,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
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
              const SizedBox(height: 32),

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
                    label: 'Booking ID',
                    value: outing.bookingId,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Accommodation Section
              _buildDetailSection(
                context,
                'Accommodation',
                [
                  _DetailItem(
                    icon: Iconsax.building_4,
                    label: 'Hostel Block',
                    value: outing.hostelBlock,
                  ),
                  _DetailItem(
                    icon: Iconsax.home_2,
                    label: 'Room Number',
                    value: outing.roomNumber,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Schedule Section
              _buildDetailSection(
                context,
                'Schedule',
                [
                  _DetailItem(
                    icon: Iconsax.calendar_1,
                    label: 'Date',
                    value:
                        '${outing.date.day}/${outing.date.month}/${outing.date.year}',
                  ),
                  _DetailItem(
                    icon: Iconsax.clock,
                    label: 'Time',
                    value: outing.time,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Download Button
              if (outing.canDownload)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement download functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Download functionality coming soon!'),
                        ),
                      );
                    },
                    icon: const Icon(Iconsax.document_download),
                    label: const Text('Download Report'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.green.shade500,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
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
