import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/providers/theme_mode_notifier.dart';
import 'package:vit_ap_student_app/core/theme/app_theme.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final notifier = ref.read(themeModeNotifierProvider.notifier);

    final isLight = themeMode == lightTheme;

    return IconButton(
      icon: Icon(
        isLight ? Iconsax.moon : Iconsax.sun_1,
        color: isLight ? Colors.indigo : Colors.yellow,
      ),
      onPressed: notifier.toggleTheme,
    );
  }
}
