// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outing_reports_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GeneralOutingReportsViewModel)
final generalOutingReportsViewModelProvider =
    GeneralOutingReportsViewModelProvider._();

final class GeneralOutingReportsViewModelProvider
    extends
        $NotifierProvider<
          GeneralOutingReportsViewModel,
          AsyncValue<List<GeneralOutingReport>>?
        > {
  GeneralOutingReportsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generalOutingReportsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generalOutingReportsViewModelHash();

  @$internal
  @override
  GeneralOutingReportsViewModel create() => GeneralOutingReportsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<GeneralOutingReport>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<GeneralOutingReport>>?>(value),
    );
  }
}

String _$generalOutingReportsViewModelHash() =>
    r'bc2e8041890f6f5bebd0dd437f8bab6ac03becf1';

abstract class _$GeneralOutingReportsViewModel
    extends $Notifier<AsyncValue<List<GeneralOutingReport>>?> {
  AsyncValue<List<GeneralOutingReport>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<GeneralOutingReport>>?,
              AsyncValue<List<GeneralOutingReport>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<GeneralOutingReport>>?,
                AsyncValue<List<GeneralOutingReport>>?
              >,
              AsyncValue<List<GeneralOutingReport>>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WeekendOutingReportsViewModel)
final weekendOutingReportsViewModelProvider =
    WeekendOutingReportsViewModelProvider._();

final class WeekendOutingReportsViewModelProvider
    extends
        $NotifierProvider<
          WeekendOutingReportsViewModel,
          AsyncValue<List<WeekendOutingReport>>?
        > {
  WeekendOutingReportsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weekendOutingReportsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weekendOutingReportsViewModelHash();

  @$internal
  @override
  WeekendOutingReportsViewModel create() => WeekendOutingReportsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<WeekendOutingReport>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<WeekendOutingReport>>?>(value),
    );
  }
}

String _$weekendOutingReportsViewModelHash() =>
    r'a179bde881885871cb664551bc16a66c5e75cee9';

abstract class _$WeekendOutingReportsViewModel
    extends $Notifier<AsyncValue<List<WeekendOutingReport>>?> {
  AsyncValue<List<WeekendOutingReport>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<WeekendOutingReport>>?,
              AsyncValue<List<WeekendOutingReport>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<WeekendOutingReport>>?,
                AsyncValue<List<WeekendOutingReport>>?
              >,
              AsyncValue<List<WeekendOutingReport>>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
