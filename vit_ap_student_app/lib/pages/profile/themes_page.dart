import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/provider/theme_provider.dart';

class UserThemes extends ConsumerWidget {
  const UserThemes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Themes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Appearance',
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                tileColor: Theme.of(context).colorScheme.secondary,
                title: const Text(
                  '💡 Light',
                ),
                trailing: themeMode == AppThemeMode.light
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => themeNotifier.setThemeMode(AppThemeMode.light),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('🌙 Dark'),
                trailing: themeMode == AppThemeMode.dark
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => themeNotifier.setThemeMode(AppThemeMode.dark),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('⚙️ System'),
                trailing: themeMode == AppThemeMode.system
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => themeNotifier.setThemeMode(AppThemeMode.system),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
