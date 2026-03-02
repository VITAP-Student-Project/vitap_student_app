// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WeatherViewModel)
final weatherViewModelProvider = WeatherViewModelProvider._();

final class WeatherViewModelProvider
    extends $NotifierProvider<WeatherViewModel, AsyncValue<Weather>?> {
  WeatherViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherViewModelHash();

  @$internal
  @override
  WeatherViewModel create() => WeatherViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Weather>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Weather>?>(value),
    );
  }
}

String _$weatherViewModelHash() => r'c6110f1b7958a0c7735fe26480f6ab583c8fa63d';

abstract class _$WeatherViewModel extends $Notifier<AsyncValue<Weather>?> {
  AsyncValue<Weather>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Weather>?, AsyncValue<Weather>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Weather>?, AsyncValue<Weather>?>,
              AsyncValue<Weather>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
