// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AnnouncementViewModel)
final announcementViewModelProvider = AnnouncementViewModelProvider._();

final class AnnouncementViewModelProvider
    extends
        $NotifierProvider<
          AnnouncementViewModel,
          AsyncValue<List<Announcement>>?
        > {
  AnnouncementViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'announcementViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$announcementViewModelHash();

  @$internal
  @override
  AnnouncementViewModel create() => AnnouncementViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Announcement>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Announcement>>?>(
        value,
      ),
    );
  }
}

String _$announcementViewModelHash() =>
    r'3a87fd8c716bbfc025ee142336e2ba287ee77ad4';

abstract class _$AnnouncementViewModel
    extends $Notifier<AsyncValue<List<Announcement>>?> {
  AsyncValue<List<Announcement>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<Announcement>>?,
              AsyncValue<List<Announcement>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Announcement>>?,
                AsyncValue<List<Announcement>>?
              >,
              AsyncValue<List<Announcement>>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
