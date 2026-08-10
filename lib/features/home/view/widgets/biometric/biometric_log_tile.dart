import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vit_ap_student_app/core/utils/parse_class_time.dart';
import 'package:vit_ap_student_app/features/home/model/biometric.dart';

/// A single scan.
///
/// The time is the title, because it is the only thing that differs between rows
/// and the only reason anyone opens this page. The row used to lead with the
/// location and repeat the selected date as a subtitle — the same date on every
/// row, on a screen where you had just chosen it — while the time sat in the
/// trailing slot at 12pt.
class BiometricLogTile extends StatelessWidget {
  const BiometricLogTile({super.key, required this.entry});

  final Biometric entry;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final bool isHostel = isHostelLocation(entry.location);

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: cs.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isHostel ? Iconsax.building_3 : Iconsax.book_1,
          size: 20,
          // `tertiary`/`primary` rather than the *Container roles this used to
          // reach for — container colours are backgrounds, and drawing an icon
          // in one leaves it barely visible against another container.
          color: isHostel ? cs.tertiary : cs.primary,
        ),
      ),
      title: Text(
        formatScanTime(entry.time),
        style: tt.titleMedium?.copyWith(
          color: cs.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        entry.location,
        style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Whether a scan happened at a hostel gate rather than an academic block.
///
/// Matched on whole segments: the old `location.contains('MH')` also fired on
/// any block code that merely contained those letters.
bool isHostelLocation(String location) =>
    RegExp(r'\b(MH|LH)\b|hostel', caseSensitive: false).hasMatch(location);

/// `"08:42"` becomes `"8:42 AM"`, or comes back unchanged when VTOP sends
/// something that isn't a time.
///
/// The previous `DateFormat.Hm().parse(...)` ran unguarded inside an item
/// builder, so one malformed row took down the whole list.
String formatScanTime(String time) {
  final DateTime? parsed = parseClassTime(time);
  return parsed == null ? time.trim() : formatScanClock(parsed);
}

/// The app's 12-hour clock format.
///
/// Spelled out rather than using `DateFormat.jm()`, which separates the meridiem
/// with a narrow no-break space (U+202F). `formatTo12Hour` — every other time in
/// the app — uses a plain space, and the two look subtly different side by side.
String formatScanClock(DateTime time) => DateFormat('h:mm a').format(time);
