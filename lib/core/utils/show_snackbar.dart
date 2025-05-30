import 'package:flutter/material.dart';

enum SnackBarType { success, warning, error }

// TODO: Fix colors to adapt dynamic themeing

void showSnackBar(BuildContext context, String content, SnackBarType type) {
  // Define colors and icons for each case
  Color backgroundColor;
  IconData prefixIcon;

  switch (type) {
    case SnackBarType.success:
      backgroundColor = Colors.green.shade300;
      prefixIcon = Icons.check_circle;
      break;
    case SnackBarType.warning:
      backgroundColor = Colors.yellow.shade700;
      prefixIcon = Icons.warning;
      break;
    case SnackBarType.error:
      backgroundColor = Colors.red;
      prefixIcon = Icons.error;
      break;
  }

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        showCloseIcon: true,
        content: Row(
          children: [
            Icon(prefixIcon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
}
