import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

String normalizeStatus(String status) {
  return status.toLowerCase().replaceAll('’', "'").trim();
}

bool isWaitingForMentorApproval(String status) {
  return normalizeStatus(status) == "waiting for mentor's approval";
}

bool isWaitingForWardenApproval(String status) {
  return normalizeStatus(status) == "waiting for warden's approval";
}

Color getStatusColor(String status, BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  switch (status.toLowerCase().trim()) {
    case 'leave request accepted':
    case 'outing request accepted':
      return isDark ? Colors.green.shade400 : Colors.green.shade600;
    case 'waiting for warden\'s approval':
    case 'waiting for mentor\'s approval':
      return isDark ? Colors.amber.shade400 : Colors.orange.shade700;
    case 'rejected':
      return isDark ? Colors.red.shade400 : Colors.red.shade600;
    default:
      return Theme.of(context).colorScheme.primary;
  }
}

IconData getStatusIcon(String status) {
  switch (status.toLowerCase().trim()) {
    case 'leave request accepted':
    case 'outing request accepted':
      return Iconsax.tick_circle;
    case 'waiting for warden\'s approval':
      return Iconsax.clock;
    case 'rejected':
      return Iconsax.close_circle;
    default:
      return Iconsax.info_circle;
  }
}

String formatOutingDate(String date) {
  try {
    final dateString = DateTime.parse(date);

    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(dateString);
  } catch (e) {
    // Fallback to original string if parsing fails
    return date;
  }
}
