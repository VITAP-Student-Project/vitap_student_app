// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outing_submission_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GeneralOutingSubmission)
final generalOutingSubmissionProvider = GeneralOutingSubmissionProvider._();

final class GeneralOutingSubmissionProvider
    extends $NotifierProvider<GeneralOutingSubmission, AsyncValue<String>?> {
  GeneralOutingSubmissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generalOutingSubmissionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generalOutingSubmissionHash();

  @$internal
  @override
  GeneralOutingSubmission create() => GeneralOutingSubmission();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String>?>(value),
    );
  }
}

String _$generalOutingSubmissionHash() =>
    r'f279dd699debcc9a7b39892af27101e821138b28';

abstract class _$GeneralOutingSubmission
    extends $Notifier<AsyncValue<String>?> {
  AsyncValue<String>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>?, AsyncValue<String>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>?, AsyncValue<String>?>,
              AsyncValue<String>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WeekendOutingSubmission)
final weekendOutingSubmissionProvider = WeekendOutingSubmissionProvider._();

final class WeekendOutingSubmissionProvider
    extends $NotifierProvider<WeekendOutingSubmission, AsyncValue<String>?> {
  WeekendOutingSubmissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weekendOutingSubmissionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weekendOutingSubmissionHash();

  @$internal
  @override
  WeekendOutingSubmission create() => WeekendOutingSubmission();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String>?>(value),
    );
  }
}

String _$weekendOutingSubmissionHash() =>
    r'926c9b8d1b57c775f77052ffe4dd4b682bca579a';

abstract class _$WeekendOutingSubmission
    extends $Notifier<AsyncValue<String>?> {
  AsyncValue<String>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>?, AsyncValue<String>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>?, AsyncValue<String>?>,
              AsyncValue<String>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
