import 'package:flutter/material.dart';

/// One cell of the Quick Access grid: a wide pill button above a label.
///
/// The cell is a **fixed width** and the label reserves **two lines** even when
/// it only needs one. Both matter: an earlier version let each cell size to its
/// own label inside a `spaceBetween` row, so "Digital Assignments" rendered
/// wider than "Marks" and the second row's pills no longer sat under the
/// first's. Fixed cells keep the columns and baselines aligned however long the
/// labels get.
class QuickAccessIcon extends StatelessWidget {
  const QuickAccessIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.width,
    this.emphasized = false,
    this.iconTurns = 0,
  });

  /// Size of the pill button. Kept generous rather than shrunk to fit more
  /// columns — M3 Expressive warns that smaller shapes read as less important,
  /// and these are the app's primary navigation.
  static const double pillWidth = 76;
  static const double pillHeight = 60;

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  /// Width of the whole cell, including the label. Supplied by the grid so
  /// every cell in a row is identical.
  final double width;

  /// Draws the pill in the tertiary role instead of secondary.
  ///
  /// Used by the More/Less control so it reads as a different kind of action
  /// from the destinations around it — the "break from the surrounding style to
  /// draw attention to a particular element" tactic.
  final bool emphasized;

  /// Rotation applied to the icon, in turns. Animated, so the More chevron can
  /// flip as the grid opens.
  final double iconTurns;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final Color background = emphasized
        ? cs.tertiaryContainer
        : cs.secondaryContainer;
    final Color foreground = emphasized
        ? cs.onTertiaryContainer
        : cs.onSecondaryContainer;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            style: IconButton.styleFrom(
              fixedSize: const Size(pillWidth, pillHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(pillHeight / 2),
              ),
              backgroundColor: background,
            ),
            onPressed: onPressed,
            icon: AnimatedRotation(
              turns: iconTurns,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubicEmphasized,
              child: Icon(icon, size: 24, color: foreground),
            ),
          ),
          const SizedBox(height: 6),
          // Two lines are always reserved so single- and double-word labels
          // produce the same cell height and the rows stay on a grid.
          //
          // labelSmall rather than labelMedium because the cell is only a
          // little wider than the pill, and the longest label ("Assignments")
          // does not fit on one line at the larger size — it truncated to
          // "Assignmen…". Scaling down here is preferable to abbreviating the
          // label into something students have to decode.
          SizedBox(
            height: (tt.labelSmall?.fontSize ?? 11) * 2.8,
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: tt.labelSmall?.copyWith(color: cs.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
