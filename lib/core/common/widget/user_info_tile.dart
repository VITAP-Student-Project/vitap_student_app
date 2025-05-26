import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final String title;
  final String description;
  final double gap;
  const UserInfoTile(
    this.title,
    this.description, {
    this.gap = 12.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 0),
        Text(
          description == "" ? "N/A" : description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: gap)
      ],
    );
  }
}
