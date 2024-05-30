import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Function()? onTap;

  const SettingsListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
