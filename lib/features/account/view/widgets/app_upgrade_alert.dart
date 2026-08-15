import 'package:flutter/material.dart';
import 'package:flutter_m3shapes_extended/flutter_m3shapes_extended.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upgrader/upgrader.dart';

/// The launch-time update prompt, wearing the app's own treatment.
///
/// Overrides [UpgradeAlertState.alertDialog] the same way `AppUpgradeCard`
/// overrides `buildUpgradeCard`, so all of upgrader's plumbing is inherited
/// untouched: the store lookup, `shouldDisplayUpgrade`, `saveLastAlerted`, the
/// `PopScope` that stops a blocking update being swiped away, and the
/// ignore/later/update handlers.
///
/// Deliberately still a dialog rather than a bottom sheet. An update can be
/// *blocking* — below `minAppVersion`, or flagged critical — and upgrader
/// expresses that through `PopScope` on a modal route. A bottom sheet would
/// need that reimplemented by hand, and getting it subtly wrong means a
/// mandatory update someone can swipe past. It is bottom-aligned and inset so
/// it reads like a sheet while staying a modal route.
class AppUpgradeAlert extends UpgradeAlert {
  AppUpgradeAlert({
    super.key,
    super.upgrader,
    super.child,
    super.showIgnore = true,
    super.showLater = true,
    super.showReleaseNotes = true,
  });

  @override
  UpgradeAlertState createState() => _AppUpgradeAlertState();
}

class _AppUpgradeAlertState extends UpgradeAlertState {
  @override
  Widget alertDialog(
    Key? key,
    String title,
    String message,
    String? releaseNotes,
    BuildContext context,
    bool cupertino,
    UpgraderMessages messages,
  ) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    // A blocked update is one the student cannot postpone, so upgrader drops
    // the escape hatches itself. Mirrored here rather than assumed.
    final bool isBlocked = widget.upgrader.blocked();
    final bool showLater = isBlocked ? false : widget.showLater;

    final String? storeVersion = widget.upgrader.currentAppStoreVersion;
    final String? notes = widget.showReleaseNotes ? releaseNotes?.trim() : null;

    return Dialog(
      key: key,
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.fromLTRB(
        12,
        24,
        12,
        12 + MediaQuery.paddingOf(context).bottom,
      ),
      backgroundColor: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Stack(
          children: <Widget>[
            // Decoration, not content: an oversized soft shape bled off the
            // bottom-left corner and clipped by the dialog. Sits behind the
            // text and is hidden from screen readers.
            Positioned(
              left: -100,
              bottom: -110,
              child: ExcludeSemantics(
                child: M3EContainer.c7SidedCookie(
                  width: 280,
                  height: 280,
                  color: cs.secondaryContainer.withValues(alpha: 0.45),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (storeVersion != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _VersionPill(version: storeVersion),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    isBlocked
                        ? 'An update is required'
                        : 'A newer version is here',
                    style: GoogleFonts.unbounded(
                      textStyle: tt.headlineSmall,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.8,
                      height: 1.15,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _body(isBlocked),
                    style: tt.bodyMedium?.copyWith(
                      height: 1.45,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  if (notes != null && notes.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        notes,
                        maxLines: 12,
                        overflow: TextOverflow.ellipsis,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 60,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        shape: const StadiumBorder(),
                        textStyle: tt.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () =>
                          onUserUpdated(context, !widget.upgrader.blocked()),
                      icon: const Icon(Icons.north_east_rounded, size: 18),
                      iconAlignment: IconAlignment.end,
                      label: const Text('Update now'),
                    ),
                  ),
                  if (showLater) ...<Widget>[
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 52,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: cs.onSurfaceVariant,
                        ),
                        onPressed: () => onUserLater(context, true),
                        child: const Text('Not now'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Written fresh rather than using upgrader's default body, which is
  /// assembled from templated strings and reads like a system message.
  String _body(bool isBlocked) {
    if (isBlocked) {
      return 'This version is no longer supported. Updating takes a moment, '
          'and everything on your device stays where it is.';
    }
    return 'Everything saved on your device stays exactly as it is — '
        'updating just brings the latest fixes and improvements.';
  }
}

/// The version badge above the headline.
class _VersionPill extends StatelessWidget {
  const _VersionPill({required this.version});

  final String version;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 7, 14, 7),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.auto_awesome_rounded, size: 14, color: cs.onSurface),
          const SizedBox(width: 8),
          Text(
            'Version $version',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: cs.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
