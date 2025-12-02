import 'package:flutter/material.dart';

/// A browser-style URL bar that displays the current route.
class UrlBar extends StatelessWidget {
  final String url;
  final bool isLoading;
  final bool isSecure;

  const UrlBar({
    super.key,
    required this.url,
    this.isLoading = false,
    this.isSecure = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Security indicator
          Icon(
            isSecure ? Icons.lock_rounded : Icons.lock_open_rounded,
            size: 14,
            color: isSecure ? colorScheme.primary : colorScheme.error,
          ),
          const SizedBox(width: 6),
          // URL/Route display
          Flexible(
            child: Text(
              "VTOP",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Loading indicator
          if (isLoading) ...[
            const SizedBox(width: 8),
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
