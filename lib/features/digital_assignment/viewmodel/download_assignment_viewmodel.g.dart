// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_assignment_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DownloadAssignmentViewModel)
final downloadAssignmentViewModelProvider =
    DownloadAssignmentViewModelProvider._();

final class DownloadAssignmentViewModelProvider
    extends
        $NotifierProvider<DownloadAssignmentViewModel, AsyncValue<Uint8List>?> {
  DownloadAssignmentViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadAssignmentViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadAssignmentViewModelHash();

  @$internal
  @override
  DownloadAssignmentViewModel create() => DownloadAssignmentViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Uint8List>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Uint8List>?>(value),
    );
  }
}

String _$downloadAssignmentViewModelHash() =>
    r'5729d7ae4606878513ceda6daec3339e74c06b04';

abstract class _$DownloadAssignmentViewModel
    extends $Notifier<AsyncValue<Uint8List>?> {
  AsyncValue<Uint8List>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Uint8List>?, AsyncValue<Uint8List>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Uint8List>?, AsyncValue<Uint8List>?>,
              AsyncValue<Uint8List>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
