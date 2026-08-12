// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConnectViewModel)
final connectViewModelProvider = ConnectViewModelProvider._();

final class ConnectViewModelProvider
    extends $AsyncNotifierProvider<ConnectViewModel, Map<String, dynamic>> {
  ConnectViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectViewModelHash();

  @$internal
  @override
  ConnectViewModel create() => ConnectViewModel();
}

String _$connectViewModelHash() => r'24b8de154575758816cfbac85c35de8f71ba44b5';

abstract class _$ConnectViewModel extends $AsyncNotifier<Map<String, dynamic>> {
  FutureOr<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
