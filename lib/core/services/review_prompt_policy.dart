/// When it is reasonable to ask someone to rate the app.
///
/// Kept as a pure decision so the rules can be read and tested without a store
/// connection. Asking at the wrong moment is worse than not asking: a prompt
/// during a failure, or on someone's first day, converts a neutral user into an
/// annoyed one — and on the stores an annoyed rating is permanent.
library;

/// Successful, satisfying actions to see before asking.
///
/// Three rather than one: a single success could be someone's first minute in
/// the app, and asking a stranger to vouch for you is how you collect one-stars.
const int reviewPromptMinimumHappyMoments = 3;

/// How long someone must have had the app before being asked anything.
///
/// A keen new user could hit three successes on day one. An opinion formed in
/// an afternoon is not the opinion worth asking for, and being asked that early
/// reads as pushy.
const Duration reviewPromptMinimumAge = Duration(days: 7);

/// How long to wait before asking again after a prompt was shown.
///
/// The stores enforce their own quotas and may silently show nothing, so the app
/// cannot tell whether a review was actually left. This gap is what keeps a
/// silently-ignored prompt from being retried every week.
const Duration reviewPromptCooldown = Duration(days: 90);

/// Whether to ask for a review now.
///
/// [happyMoments] is the running count of successful actions, [firstSeenAt] is
/// when the app first recorded one, and [lastPromptedAt] is when a prompt was
/// last surfaced, or null if never.
bool shouldRequestReview({
  required int happyMoments,
  required DateTime? firstSeenAt,
  required DateTime? lastPromptedAt,
  required DateTime now,
  bool isDemoMode = false,
}) {
  // The demo account is a review build walking through the app, not a student
  // with an opinion about it.
  if (isDemoMode) return false;
  if (happyMoments < reviewPromptMinimumHappyMoments) return false;

  if (firstSeenAt == null) return false;
  if (now.difference(firstSeenAt) < reviewPromptMinimumAge) return false;

  if (lastPromptedAt == null) return true;
  return now.difference(lastPromptedAt) >= reviewPromptCooldown;
}
