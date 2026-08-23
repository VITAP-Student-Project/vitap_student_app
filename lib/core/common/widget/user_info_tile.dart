import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/show_snackbar.dart';

/// The primary thing a row's value is *for*, when copying isn't it.
///
/// An email address or a phone number is worth acting on directly — copying one
/// so you can paste it into the dialer is a worse version of tapping Call.
class UserInfoAction {
  const UserInfoAction({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
}

/// A labelled value from the student's or their mentor's record.
///
/// Copying used to be a long press with nothing on screen to suggest it, and
/// the gesture silently did nothing when the value was missing — so the one
/// time somebody discovered it, it might not work. Rows that can be copied now
/// say so with an icon and respond to a press; rows with nothing in them look
/// as inert as they are.
class UserInfoTile extends StatelessWidget {
  const UserInfoTile(
    this.title,
    this.description, {
    this.gap = 12.0,
    this.copyable = false,
    this.action,
    super.key,
  });

  final String title;
  final String description;
  final double gap;

  /// Opt in per row. Not every value is worth pasting somewhere — a blood group
  /// or a gender carries an icon for nothing, and eight of them down a page is
  /// noise that stops signalling anything.
  final bool copyable;

  /// Shown before the copy control and used as the row's tap action.
  final UserInfoAction? action;

  bool get _hasValue {
    final value = description.trim();
    return value.isNotEmpty && value != 'N/A';
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: description.trim()));
    if (!context.mounted) return;
    showSnackBar(context, '$title copied', SnackBarType.success);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool interactive = _hasValue && (copyable || action != null);

    final Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.primary,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                _hasValue ? description.trim() : 'N/A',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  // A missing value reads as absent rather than as content.
                  color: _hasValue ? colors.onSurface : colors.outline,
                ),
              ),
            ),
            if (interactive && action != null)
              _TileIconButton(
                icon: action!.icon,
                tooltip: action!.tooltip,
                onTap: action!.onTap,
                emphasized: true,
              ),
            if (interactive && copyable)
              _TileIconButton(
                icon: Iconsax.copy,
                tooltip: 'Copy $title',
                onTap: () => _copy(context),
              ),
          ],
        ),
      ],
    );

    if (!interactive) {
      return Padding(
        padding: EdgeInsets.only(top: 4, bottom: gap),
        child: body,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          // Tapping does the row's main job — its action where it has one,
          // otherwise the copy. The long press still copies, so anyone who
          // already knew the gesture keeps it.
          onTap: action?.onTap ?? () => _copy(context),
          onLongPress: copyable ? () => _copy(context) : null,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: body,
          ),
        ),
        SizedBox(height: gap > 4 ? gap - 4 : 0),
      ],
    );
  }
}

/// A compact icon control.
///
/// Not an [IconButton]: its 48px minimum tap target is most of the width of a
/// value row, and these sit at the end of one.
class _TileIconButton extends StatelessWidget {
  const _TileIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.emphasized = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 18,
            color: emphasized ? colors.primary : colors.outline,
          ),
        ),
      ),
    );
  }
}
