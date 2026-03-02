// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BiometricViewModel)
final biometricViewModelProvider = BiometricViewModelProvider._();

final class BiometricViewModelProvider
    extends
        $NotifierProvider<BiometricViewModel, AsyncValue<List<Biometric>>?> {
  BiometricViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricViewModelHash();

  @$internal
  @override
  BiometricViewModel create() => BiometricViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Biometric>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Biometric>>?>(value),
    );
  }
}

String _$biometricViewModelHash() =>
    r'0882430c46b01accf5e346e0c3c2fb4148fc1d6a';

abstract class _$BiometricViewModel
    extends $Notifier<AsyncValue<List<Biometric>>?> {
  AsyncValue<List<Biometric>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<Biometric>>?, AsyncValue<List<Biometric>>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Biometric>>?,
                AsyncValue<List<Biometric>>?
              >,
              AsyncValue<List<Biometric>>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
