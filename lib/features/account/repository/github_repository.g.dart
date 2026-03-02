// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(githubRepository)
final githubRepositoryProvider = GithubRepositoryProvider._();

final class GithubRepositoryProvider
    extends
        $FunctionalProvider<
          GithubRepository,
          GithubRepository,
          GithubRepository
        >
    with $Provider<GithubRepository> {
  GithubRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'githubRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$githubRepositoryHash();

  @$internal
  @override
  $ProviderElement<GithubRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GithubRepository create(Ref ref) {
    return githubRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GithubRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GithubRepository>(value),
    );
  }
}

String _$githubRepositoryHash() => r'd6dbf09f63f64a712ef249c3cb87ac49d8fc1a53';
