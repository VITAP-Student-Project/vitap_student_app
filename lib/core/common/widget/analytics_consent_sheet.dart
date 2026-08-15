import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// What anonymous usage data actually covers.
///
/// Written from what [AnalyticsService] genuinely sends — coarse cohort
/// properties, screen and feature names, scrubbed error text — so the promise on
/// screen matches the code rather than the other way round. If the service
/// starts sending something new, this needs updating with it.
void showAnalyticsConsentSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (BuildContext context) => const _AnalyticsConsentSheet(),
  );
}

class _AnalyticsConsentSheet extends StatelessWidget {
  const _AnalyticsConsentSheet();

  static const List<String> _collected = <String>[
    'Which screens you open and which features you use',
    'Your joining year and branch — taken from the start of your registration '
        'number, with the unique digits discarded on your device',
    'Context on actions, like a course code, a file type or a tab name',
    'Errors the app runs into, with links, emails and long numbers stripped out',
  ];

  static const List<String> _notCollected = <String>[
    'Your registration number, name or password',
    'Your marks, attendance, timetable or any other academic data',
    'Anything you type, including file names and search terms',
    'Any identifier that could single you out',
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Anonymous usage data',
              style: tt.headlineSmall?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'It tells us which parts of the app are worth improving. '
              'You can turn it off any time in Settings.',
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            _Section(
              icon: Iconsax.tick_circle,
              color: cs.primary,
              title: 'What is collected',
              items: _collected,
            ),
            const SizedBox(height: 12),
            _Section(
              icon: Iconsax.close_circle,
              color: cs.error,
              title: 'What is never collected',
              items: _notCollected,
            ),
            const SizedBox(height: 20),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: const StadiumBorder(),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.color,
    required this.title,
    required this.items,
  });

  final IconData icon;
  final Color color;
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: tt.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final String item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 7, right: 10),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: cs.onSurfaceVariant,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurface,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
