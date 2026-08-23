import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

/// Everything about how Wiredash looks, reads and is opened, in one place.
///
/// The two entry points were called directly from five widgets, so the survey's
/// cadence and the sheet's wording lived wherever someone last touched them.
/// Wiredash also ships its own blue-on-white theme and generic SaaS copy, both
/// of which land in the middle of a seeded cream-and-olive app as somebody
/// else's product.
abstract final class AppFeedback {
  /// Opens the feedback composer.
  static void compose(BuildContext context) {
    Wiredash.of(context).show();
  }

  /// Asks the "would you recommend this" question, at most once every 60 days
  /// and never to someone who has just installed the app.
  ///
  /// The gate is Wiredash's own; it is set here so every caller gets the same
  /// cadence rather than each deciding how often to interrupt.
  static void promoterSurvey(BuildContext context) {
    Wiredash.of(context).showPromoterSurvey(
      options: const PsOptions(
        frequency: Duration(days: 60),
        initialDelay: Duration(days: 7),
        minimumAppStarts: 12,
      ),
    );
  }
}

/// Maps the app's [ColorScheme] onto Wiredash's own palette.
///
/// Built from a scheme rather than a [BuildContext] because [Wiredash] sits
/// above [MaterialApp], where there is no [Theme] to read.
WiredashThemeData appWiredashTheme(ColorScheme colors) {
  return WiredashThemeData(
    brightness: colors.brightness,
    primaryColor: colors.primary,
    secondaryColor: colors.secondary,
    textOnPrimary: colors.onPrimary,
    textOnSecondary: colors.onSecondary,
    primaryBackgroundColor: colors.surface,
    secondaryBackgroundColor: colors.surfaceContainer,
    primaryTextOnBackgroundColor: colors.onSurface,
    secondaryTextOnBackgroundColor: colors.onSurfaceVariant,
    primaryContainerColor: colors.primaryContainer,
    textOnPrimaryContainerColor: colors.onPrimaryContainer,
    secondaryContainerColor: colors.secondaryContainer,
    textOnSecondaryContainerColor: colors.onSecondaryContainer,
    // The backdrop behind the shrunken app, and the handle that pulls it back.
    appBackgroundColor: colors.surface,
    appHandleBackgroundColor: colors.surfaceContainerHighest,
    errorColor: colors.error,
  );
}

/// The app's wording for the feedback and promoter flows.
///
/// Extends the English strings and overrides only what needed saying
/// differently, so an SDK upgrade that adds a screen still has copy for it.
///
/// The substantive change is naming who receives this. Wiredash's default "Send
/// us your feedback" reads, in an app full of VTOP data, as though it reaches
/// the university — it doesn't; it reaches one student who maintains this.
class AppWiredashLocalizations extends WiredashLocalizationsEn {
  AppWiredashLocalizations() : super();

  @override
  String get feedbackStep1MessageTitle => "What's on your mind?";

  @override
  String get feedbackStep1MessageBreadcrumbTitle => 'Message';

  @override
  String get feedbackStep1MessageDescription =>
      'This goes to the student who builds this app, not to VIT-AP.';

  @override
  String get feedbackStep1MessageHint =>
      'A bug, something confusing, or an idea…';

  @override
  String get feedbackStep1MessageErrorMissingMessage => 'Add a message first';

  @override
  String get feedbackStep3ScreenshotOverviewTitle => 'Add a screenshot?';

  @override
  String get feedbackStep3ScreenshotOverviewDescription =>
      'A picture of what you saw makes a bug far quicker to track down.';

  @override
  String get feedbackStep4EmailTitle => 'Want a reply?';

  @override
  String get feedbackStep4EmailDescription =>
      'Leave your email if you would like to hear back. Optional.';

  @override
  String get feedbackStep6SubmitTitle => 'Ready to send';

  @override
  String get feedbackStep6SubmitDescription =>
      'Have a last look, then send it across.';

  @override
  String get feedbackStep7SubmissionInFlightMessage => 'Sending…';

  @override
  String get feedbackStep7SubmissionSuccessMessage =>
      'Sent — thank you, this genuinely helps.';

  @override
  String get feedbackStep7SubmissionErrorMessage => "That didn't send.";

  @override
  String get promoterScoreStep1Question =>
      'Would you recommend this app to another student?';

  @override
  String get promoterScoreStep1Description => '0 = never, 10 = definitely';

  @override
  String get promoterScoreStep2MessageTitle =>
      'What would make it worth recommending?';

  @override
  String get promoterScoreStep2MessageHint =>
      'The one thing you would change…';

  @override
  String get promoterScoreStep3ThanksMessagePromoters =>
      'Thank you — that means a lot.';

  @override
  String get promoterScoreStep3ThanksMessagePassives =>
      'Thanks for rating the app.';

  @override
  String get promoterScoreStep3ThanksMessageDetractors =>
      'Thanks for saying so — it helps more than a high score would.';
}

/// Serves [AppWiredashLocalizations] for every locale.
///
/// The app ships in English only, so there is nothing to resolve; returning the
/// same strings for any locale is better than letting a device set to another
/// language fall back to Wiredash's defaults and lose the wording above.
class AppWiredashLocalizationsDelegate
    extends LocalizationsDelegate<WiredashLocalizations> {
  const AppWiredashLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WiredashLocalizations> load(Locale locale) async =>
      AppWiredashLocalizations();

  @override
  bool shouldReload(AppWiredashLocalizationsDelegate old) => false;
}
