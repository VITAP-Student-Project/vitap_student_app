import 'package:flutter/material.dart';

class SettingsCategory extends StatelessWidget {
  final String category;
  const SettingsCategory(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, top: 12, bottom: 12),
      child: Text(
        category,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
