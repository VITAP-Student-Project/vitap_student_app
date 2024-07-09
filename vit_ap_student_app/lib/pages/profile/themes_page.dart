import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/provider/theme_provider.dart';

class UserThemes extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.notifier).state;
    return Scaffold(
      appBar: AppBar(
        title: Text('Themes'),
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
                    fontSize: 18),
              )),
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Light'),
            trailing:
                themeMode == AppThemeMode.light ? Icon(Icons.check) : null,
            onTap: () =>
                ref.read(themeModeProvider.notifier).state = AppThemeMode.light,
          ),
          ListTile(
            leading: Icon(Icons.nights_stay),
            title: Text('Dark'),
            trailing: themeMode == AppThemeMode.dark ? Icon(Icons.check) : null,
            onTap: () =>
                ref.read(themeModeProvider.notifier).state = AppThemeMode.dark,
          ),
          ListTile(
            leading: Icon(Icons.brightness_4),
            title: Text('System'),
            trailing:
                themeMode == AppThemeMode.system ? Icon(Icons.check) : null,
            onTap: () => ref.read(themeModeProvider.notifier).state =
                AppThemeMode.system,
          ),
        ],
      ),
    );
  }
}
