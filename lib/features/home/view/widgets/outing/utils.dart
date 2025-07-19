import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

Color getStatusColor(String status, BuildContext context) {
  switch (status.toLowerCase().trim()) {
    case 'leave request accepted':
    case 'outing request accepted':
      return Colors.green;
    case 'waiting for warden\'s approval':
      return Colors.orange;
    case 'rejected':
      return Colors.red;
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
