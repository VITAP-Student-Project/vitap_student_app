/// When the home page should offer the support card.
///
/// Separate rules from the review prompt because the surfaces cost different
/// amounts of attention: the review sheet interrupts, so it is rationed hard,
/// while this is a passive card you can scroll past. It still has to be earned,
/// though — a support ask that is simply always there teaches people to ignore
/// cards, and the announcement cards sit in the same place.
library;

/// Successes before the card is offered.
///
/// Higher than the review prompt's threshold on purpose, so someone is not
/// asked to rate the app and fund it in the same week.
const int supportCardMinimumHappyMoments = 6;

/// How long someone must have been using the app first.
const Duration supportCardMinimumAge = Duration(days: 14);

/// How long the card stays gone once dismissed.
///
/// Long enough that dismissing it feels respected rather than deferred.
const Duration supportCardDismissalCooldown = Duration(days: 120);

bool shouldShowSupportCard({
  required int happyMoments,
  required DateTime? firstSeenAt,
  required DateTime? dismissedAt,
  required DateTime now,
  bool isDemoMode = false,
}) {
  // App review builds should see the app, not a request for money.
  if (isDemoMode) return false;
  if (happyMoments < supportCardMinimumHappyMoments) return false;

  if (firstSeenAt == null) return false;
  if (now.difference(firstSeenAt) < supportCardMinimumAge) return false;

  if (dismissedAt == null) return true;
  return now.difference(dismissedAt) >= supportCardDismissalCooldown;
}
