import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:upgrader/upgrader.dart';

/// A persistent "you're on an old version" card for the account page.
///
/// The launch-time [UpgradeAlert] in `main.dart` runs with `showIgnore: false`,
/// so tapping Later dismisses it and nothing mentions the update again until
/// upgrader's next interval comes round. This card is the standing reminder for
/// exactly that person: it cannot be dismissed, because a card you can dismiss
/// is the thing that already failed.
///
/// Subclasses [UpgradeCard] rather than restyling it through `CardTheme`, which
/// would repaint every card in the app. All of upgrader's plumbing — the store
/// lookup, the version comparison, `shouldDisplayUpgrade` — is inherited
/// untouched; only [UpgradeCardState.buildUpgradeCard] is replaced, so the card
/// renders nothing at all when the app is up to date.
class AppUpgradeCard extends UpgradeCard {
  AppUpgradeCard({super.key, super.upgrader})
    : super(
        // No Ignore or Later: those are the alert's job. This card exists to
        // keep saying it.
        showIgnore: false,
        showLater: false,
        showPrompt: false,
        showReleaseNotes: false,
        margin: EdgeInsets.zero,
      );

  @override
  UpgradeCardState createState() => _AppUpgradeCardState();
}

class _AppUpgradeCardState extends UpgradeCardState {
  @override
  Widget buildUpgradeCard(BuildContext context, Key? key) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final String? storeVersion = widget.upgrader.currentAppStoreVersion;
    final String? installedVersion = widget.upgrader.currentInstalledVersion;

    return Padding(
      key: key,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Material(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onUserUpdated,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Iconsax.arrow_circle_up,
                      size: 22,
                      color: cs.onSecondaryContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Update available',
                            style: tt.titleSmall?.copyWith(
                              color: cs.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _describe(storeVersion, installedVersion),
                            style: tt.bodySmall?.copyWith(
                              color: cs.onSecondaryContainer.withValues(
                                alpha: 0.82,
                              ),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: const StadiumBorder(),
                    backgroundColor: cs.onSecondaryContainer,
                    foregroundColor: cs.secondaryContainer,
                  ),
                  onPressed: onUserUpdated,
                  child: const Text('Update now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Names both versions when upgrader knows them, and stays vague rather than
  /// printing `null` when the store lookup came back thin.
  String _describe(String? storeVersion, String? installedVersion) {
    if (storeVersion == null) {
      return 'A newer version of the app is available.';
    }
    if (installedVersion == null) {
      return 'Version $storeVersion is available.';
    }
    return 'You are on $installedVersion. Version $storeVersion is available.';
  }
}
