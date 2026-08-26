// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MarkDetailViewModel)
final markDetailViewModelProvider = MarkDetailViewModelProvider._();

final class MarkDetailViewModelProvider
    extends
        $NotifierProvider<
          MarkDetailViewModel,
          AsyncValue<GradeStatisticsModel?>?
        > {
  MarkDetailViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markDetailViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markDetailViewModelHash();

  @$internal
  @override
  MarkDetailViewModel create() => MarkDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<GradeStatisticsModel?>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<GradeStatisticsModel?>?>(
        value,
      ),
    );
  }
}

String _$markDetailViewModelHash() =>
    r'1ec893e207803fee0a8fc1e2f9ef6ee589a9a52b';

abstract class _$MarkDetailViewModel
    extends $Notifier<AsyncValue<GradeStatisticsModel?>?> {
  AsyncValue<GradeStatisticsModel?>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<GradeStatisticsModel?>?,
              AsyncValue<GradeStatisticsModel?>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<GradeStatisticsModel?>?,
                AsyncValue<GradeStatisticsModel?>?
              >,
              AsyncValue<GradeStatisticsModel?>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
