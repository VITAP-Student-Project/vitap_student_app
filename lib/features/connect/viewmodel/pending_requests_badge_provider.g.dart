// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_requests_badge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PendingRequestsBadge)
final pendingRequestsBadgeProvider = PendingRequestsBadgeProvider._();

final class PendingRequestsBadgeProvider
    extends $NotifierProvider<PendingRequestsBadge, int> {
  PendingRequestsBadgeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingRequestsBadgeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingRequestsBadgeHash();

  @$internal
  @override
  PendingRequestsBadge create() => PendingRequestsBadge();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pendingRequestsBadgeHash() =>
    r'b5517506405584ffab99ca0fc107787b47b94a8f';

abstract class _$PendingRequestsBadge extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
