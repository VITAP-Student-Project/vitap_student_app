// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_calendar_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(academicCalendarRepository)
final academicCalendarRepositoryProvider =
    AcademicCalendarRepositoryProvider._();

final class AcademicCalendarRepositoryProvider
    extends
        $FunctionalProvider<
          AcademicCalendarRepository,
          AcademicCalendarRepository,
          AcademicCalendarRepository
        >
    with $Provider<AcademicCalendarRepository> {
  AcademicCalendarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'academicCalendarRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$academicCalendarRepositoryHash();

  @$internal
  @override
  $ProviderElement<AcademicCalendarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AcademicCalendarRepository create(Ref ref) {
    return academicCalendarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcademicCalendarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcademicCalendarRepository>(value),
    );
  }
}

String _$academicCalendarRepositoryHash() =>
    r'b26470e1c31d5d1d999e3e1e0838eb30a17d59ce';
