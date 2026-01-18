// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'for_you_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$featuredItemsHash() => r'2fafb0a3a3370efa6e9be53d75bf8f03fd97dfab';

/// Provider for featured items - derived from main items list
///
/// Copied from [featuredItems].
@ProviderFor(featuredItems)
final featuredItemsProvider = AutoDisposeProvider<List<ForYouItem>>.internal(
  featuredItems,
  name: r'featuredItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedItemsRef = AutoDisposeProviderRef<List<ForYouItem>>;
String _$forYouTypesHash() => r'949ec3545598a85602ac0f17a1fea7f57ecbc6a1';

/// Provider for available types - derived from main items list
///
/// Copied from [forYouTypes].
@ProviderFor(forYouTypes)
final forYouTypesProvider = AutoDisposeProvider<List<String>>.internal(
  forYouTypes,
  name: r'forYouTypesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$forYouTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ForYouTypesRef = AutoDisposeProviderRef<List<String>>;
String _$likedItemsSessionHash() => r'6bc4250ba56861a32cc2cac7869244c6be1b7b50';

/// Provider to track liked items in current session (resets on app restart)
///
/// Copied from [LikedItemsSession].
@ProviderFor(LikedItemsSession)
final likedItemsSessionProvider =
    AutoDisposeNotifierProvider<LikedItemsSession, Set<String>>.internal(
  LikedItemsSession.new,
  name: r'likedItemsSessionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$likedItemsSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LikedItemsSession = AutoDisposeNotifier<Set<String>>;
String _$forYouViewModelHash() => r'421874672b1f256fd7f9d00909c15aae8dfc53e6';

/// Main ViewModel - holds all items and provides filtered views
///
/// Copied from [ForYouViewModel].
@ProviderFor(ForYouViewModel)
final forYouViewModelProvider = AutoDisposeNotifierProvider<ForYouViewModel,
    AsyncValue<List<ForYouItem>>>.internal(
  ForYouViewModel.new,
  name: r'forYouViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$forYouViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ForYouViewModel = AutoDisposeNotifier<AsyncValue<List<ForYouItem>>>;
String _$forYouSubmitHash() => r'd04fe35d0bba0ce8103c54128c7618829a21745d';

/// Provider for submit state
///
/// Copied from [ForYouSubmit].
@ProviderFor(ForYouSubmit)
final forYouSubmitProvider =
    AutoDisposeNotifierProvider<ForYouSubmit, AsyncValue<ForYouItem?>>.internal(
  ForYouSubmit.new,
  name: r'forYouSubmitProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$forYouSubmitHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ForYouSubmit = AutoDisposeNotifier<AsyncValue<ForYouItem?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
