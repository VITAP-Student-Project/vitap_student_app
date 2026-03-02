// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'for_you_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to track liked items in current session (resets on app restart)

@ProviderFor(LikedItemsSession)
final likedItemsSessionProvider = LikedItemsSessionProvider._();

/// Provider to track liked items in current session (resets on app restart)
final class LikedItemsSessionProvider
    extends $NotifierProvider<LikedItemsSession, Set<String>> {
  /// Provider to track liked items in current session (resets on app restart)
  LikedItemsSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likedItemsSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likedItemsSessionHash();

  @$internal
  @override
  LikedItemsSession create() => LikedItemsSession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$likedItemsSessionHash() => r'6bc4250ba56861a32cc2cac7869244c6be1b7b50';

/// Provider to track liked items in current session (resets on app restart)

abstract class _$LikedItemsSession extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Main ViewModel - holds all items and provides filtered views

@ProviderFor(ForYouViewModel)
final forYouViewModelProvider = ForYouViewModelProvider._();

/// Main ViewModel - holds all items and provides filtered views
final class ForYouViewModelProvider
    extends $NotifierProvider<ForYouViewModel, AsyncValue<List<ForYouItem>>> {
  /// Main ViewModel - holds all items and provides filtered views
  ForYouViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forYouViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forYouViewModelHash();

  @$internal
  @override
  ForYouViewModel create() => ForYouViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<ForYouItem>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<ForYouItem>>>(value),
    );
  }
}

String _$forYouViewModelHash() => r'421874672b1f256fd7f9d00909c15aae8dfc53e6';

/// Main ViewModel - holds all items and provides filtered views

abstract class _$ForYouViewModel
    extends $Notifier<AsyncValue<List<ForYouItem>>> {
  AsyncValue<List<ForYouItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ForYouItem>>, AsyncValue<List<ForYouItem>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ForYouItem>>,
                AsyncValue<List<ForYouItem>>
              >,
              AsyncValue<List<ForYouItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider for featured items - derived from main items list

@ProviderFor(featuredItems)
final featuredItemsProvider = FeaturedItemsProvider._();

/// Provider for featured items - derived from main items list

final class FeaturedItemsProvider
    extends
        $FunctionalProvider<
          List<ForYouItem>,
          List<ForYouItem>,
          List<ForYouItem>
        >
    with $Provider<List<ForYouItem>> {
  /// Provider for featured items - derived from main items list
  FeaturedItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredItemsHash();

  @$internal
  @override
  $ProviderElement<List<ForYouItem>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<ForYouItem> create(Ref ref) {
    return featuredItems(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ForYouItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ForYouItem>>(value),
    );
  }
}

String _$featuredItemsHash() => r'e04ff303bfeadb29cb33fb290ec6e901e92c6f3f';

/// Provider for available types - derived from main items list

@ProviderFor(forYouTypes)
final forYouTypesProvider = ForYouTypesProvider._();

/// Provider for available types - derived from main items list

final class ForYouTypesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  /// Provider for available types - derived from main items list
  ForYouTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forYouTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forYouTypesHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return forYouTypes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$forYouTypesHash() => r'f2105d23394fe1362199d82c16b8aec8e002c2e5';

/// Provider for submit state

@ProviderFor(ForYouSubmit)
final forYouSubmitProvider = ForYouSubmitProvider._();

/// Provider for submit state
final class ForYouSubmitProvider
    extends $NotifierProvider<ForYouSubmit, AsyncValue<bool>> {
  /// Provider for submit state
  ForYouSubmitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forYouSubmitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forYouSubmitHash();

  @$internal
  @override
  ForYouSubmit create() => ForYouSubmit();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<bool>>(value),
    );
  }
}

String _$forYouSubmitHash() => r'35cf27bf903159fd953c49925b2475d544d30233';

/// Provider for submit state

abstract class _$ForYouSubmit extends $Notifier<AsyncValue<bool>> {
  AsyncValue<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, AsyncValue<bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, AsyncValue<bool>>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
