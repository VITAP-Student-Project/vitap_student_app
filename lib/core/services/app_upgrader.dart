import 'package:upgrader/upgrader.dart';

/// The one [Upgrader] the whole app shares.
///
/// Both the launch-time `UpgradeAlert` and the persistent card on the account
/// page read this instance. They used to construct their own, which was wrong
/// in three ways at once:
///
/// - Two Play Store lookups every launch instead of one.
/// - `saveLastAlerted()` lives on the instance, so the alert's "Later" was
///   invisible to the card — the two could disagree about whether the student
///   had already been told.
/// - Configuration drifted. `countryCode` and the debug flags were set on one
///   instance only, so the card silently ran with different settings and, in
///   debug, appeared broken when it was merely reading a different object.
final Upgrader appUpgrader = Upgrader(
  countryCode: 'IN',
  debugLogging: forceUpgradePromptsForTesting,
  debugDisplayAlways: forceUpgradePromptsForTesting,
);

/// Shows the update alert and card even when the app is already current.
///
/// Flip to `true` to see either surface without waiting for a real release —
/// the store lookup still has to succeed, since both widgets check that version
/// info exists *before* they consult any debug flag.
const bool forceUpgradePromptsForTesting = false;
