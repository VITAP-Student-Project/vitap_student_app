import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Picks the day whose log to fetch.
///
/// Replaces three separate controls — a read-only text field, a calendar icon
/// button and a "Go" box, each hand-sized in pixels — with one. Students check
/// today or yesterday almost every time, so stepping is one tap where the picker
/// was three; the label still opens the full picker for anything further back.
class BiometricDateStepper extends StatelessWidget {
  const BiometricDateStepper({
    super.key,
    required this.selectedDate,
    required this.firstDate,
    required this.onChanged,
  });

  final DateTime selectedDate;
  final DateTime firstDate;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final DateTime today = _dayOf(DateTime.now());
    final DateTime day = _dayOf(selectedDate);

    // VTOP has no log for a day that hasn't happened, and none before the app's
    // earliest supported date — so the arrows stop rather than fetching nothing.
    final bool canGoBack = day.isAfter(_dayOf(firstDate));
    final bool canGoForward = day.isBefore(today);

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: canGoBack
                ? () => onChanged(_dayOf(day.subtract(const Duration(days: 1))))
                : null,
            icon: const Icon(Icons.chevron_left_rounded),
            tooltip: 'Previous day',
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _pick(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _relativeLabel(day, today),
                      style: tt.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat('d MMM yyyy').format(day),
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: canGoForward
                ? () => onChanged(_dayOf(day.add(const Duration(days: 1))))
                : null,
            icon: const Icon(Icons.chevron_right_rounded),
            tooltip: 'Next day',
          ),
        ],
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: DateTime.now(),
      helpText: 'Pick a date',
    );
    if (picked != null) onChanged(_dayOf(picked));
  }

  /// `Today` and `Yesterday` are what this page is used for; anything older is
  /// named by its weekday, with the full date on the line beneath.
  String _relativeLabel(DateTime day, DateTime today) {
    final int difference = today.difference(day).inDays;
    return switch (difference) {
      0 => 'Today',
      1 => 'Yesterday',
      _ => DateFormat('EEEE').format(day),
    };
  }

  static DateTime _dayOf(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
