import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final Icon leadingIcon;
  final Icon? trailingIcon;
  final VoidCallback? onTap;
  final Widget? trailingWidget;
  final Color? leadingIconColor;
  final Color? leadingIconBackgroundColor;
  final Color? tileColor;
  final Color? titleColor;

  const SettingTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.trailingWidget,
    this.leadingIconColor,
    this.leadingIconBackgroundColor,
    this.tileColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst)
          Divider(
            color: Theme.of(context).colorScheme.onTertiary,
            indent: 18,
            endIndent: 28,
            thickness: 0.8,
          ),
        ListTile(
          tileColor:
              tileColor ?? Theme.of(context).colorScheme.surfaceContainerLow,
          titleTextStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: titleColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: leadingIconBackgroundColor ??
                  Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              leadingIcon.icon,
              color: leadingIconColor ?? Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(title),
          trailing: trailingWidget ?? trailingIcon,
          onTap: onTap,
        ),
      ],
    );
  }
}
