import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/core/services/review_prompt_policy.dart';
import 'package:vit_ap_student_app/core/services/support_prompt_policy.dart';

final DateTime now = DateTime(2026, 8, 10);

/// Old enough to clear [reviewPromptMinimumAge] unless a test says otherwise.
final DateTime establishedUser = now.subtract(const Duration(days: 30));

void main() {
  group('shouldRequestReview', () {
    test('waits for a few successes before asking a stranger to vouch', () {
      for (
        int moments = 0;
        moments < reviewPromptMinimumHappyMoments;
        moments++
      ) {
        expect(
          shouldRequestReview(
            happyMoments: moments,
            firstSeenAt: establishedUser,
            lastPromptedAt: null,
            now: now,
          ),
          isFalse,
          reason: '$moments happy moments',
        );
      }

      expect(
        shouldRequestReview(
          happyMoments: reviewPromptMinimumHappyMoments,
          firstSeenAt: establishedUser,
          lastPromptedAt: null,
          now: now,
        ),
        isTrue,
      );
    });

    // A keen new user can hit three successes on day one, and an opinion formed
    // in an afternoon is not the one worth asking for.
    test('will not ask someone who only just started using the app', () {
      expect(
        shouldRequestReview(
          happyMoments: 10,
          firstSeenAt: now.subtract(const Duration(days: 1)),
          lastPromptedAt: null,
          now: now,
        ),
        isFalse,
      );
      expect(
        shouldRequestReview(
          happyMoments: 10,
          firstSeenAt: now.subtract(reviewPromptMinimumAge),
          lastPromptedAt: null,
          now: now,
        ),
        isTrue,
      );
    });

    // Neither store reports whether a review was left, so a prompt that was
    // silently swallowed must not be retried every week.
    test('holds off until the cooldown has elapsed', () {
      expect(
        shouldRequestReview(
          happyMoments: 20,
          firstSeenAt: establishedUser,
          lastPromptedAt: now.subtract(const Duration(days: 30)),
          now: now,
        ),
        isFalse,
      );
      expect(
        shouldRequestReview(
          happyMoments: 20,
          firstSeenAt: establishedUser,
          lastPromptedAt: now.subtract(reviewPromptCooldown),
          now: now,
        ),
        isTrue,
      );
    });

    test('never asks the demo account', () {
      expect(
        shouldRequestReview(
          happyMoments: 100,
          firstSeenAt: establishedUser,
          lastPromptedAt: null,
          now: now,
          isDemoMode: true,
        ),
        isFalse,
      );
    });
  });

  group('shouldShowSupportCard', () {
    // Set higher than the review threshold so nobody is asked to rate the app
    // and fund it in the same week.
    test('needs more use than the review prompt does', () {
      expect(
        supportCardMinimumHappyMoments > reviewPromptMinimumHappyMoments,
        isTrue,
      );
      expect(
        shouldShowSupportCard(
          happyMoments: supportCardMinimumHappyMoments - 1,
          firstSeenAt: establishedUser,
          dismissedAt: null,
          now: now,
        ),
        isFalse,
      );
      expect(
        shouldShowSupportCard(
          happyMoments: supportCardMinimumHappyMoments,
          firstSeenAt: establishedUser,
          dismissedAt: null,
          now: now,
        ),
        isTrue,
      );
    });

    test('stays gone for months once dismissed', () {
      expect(
        shouldShowSupportCard(
          happyMoments: 50,
          firstSeenAt: establishedUser,
          dismissedAt: now.subtract(const Duration(days: 30)),
          now: now,
        ),
        isFalse,
      );
      expect(
        shouldShowSupportCard(
          happyMoments: 50,
          firstSeenAt: establishedUser,
          dismissedAt: now.subtract(supportCardDismissalCooldown),
          now: now,
        ),
        isTrue,
      );
    });

    test('never asks the demo account', () {
      expect(
        shouldShowSupportCard(
          happyMoments: 50,
          firstSeenAt: establishedUser,
          dismissedAt: null,
          now: now,
          isDemoMode: true,
        ),
        isFalse,
      );
    });
  });
}
