// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slots_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SlotsViewmodel)
final slotsViewmodelProvider = SlotsViewmodelProvider._();

final class SlotsViewmodelProvider
    extends $NotifierProvider<SlotsViewmodel, AsyncValue<SlotsResponseModel>?> {
  SlotsViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'slotsViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$slotsViewmodelHash();

  @$internal
  @override
  SlotsViewmodel create() => SlotsViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<SlotsResponseModel>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<SlotsResponseModel>?>(
        value,
      ),
    );
  }
}

String _$slotsViewmodelHash() => r'be488c758f8973dfdb4068343641824fb911fdd0';

abstract class _$SlotsViewmodel
    extends $Notifier<AsyncValue<SlotsResponseModel>?> {
  AsyncValue<SlotsResponseModel>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<SlotsResponseModel>?,
              AsyncValue<SlotsResponseModel>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<SlotsResponseModel>?,
                AsyncValue<SlotsResponseModel>?
              >,
              AsyncValue<SlotsResponseModel>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
