// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_view_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GradeViewViewmodel)
final gradeViewViewmodelProvider = GradeViewViewmodelProvider._();

final class GradeViewViewmodelProvider
    extends
        $NotifierProvider<
          GradeViewViewmodel,
          AsyncValue<List<GradeViewCourseModel>>?
        > {
  GradeViewViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gradeViewViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gradeViewViewmodelHash();

  @$internal
  @override
  GradeViewViewmodel create() => GradeViewViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<GradeViewCourseModel>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<GradeViewCourseModel>>?>(value),
    );
  }
}

String _$gradeViewViewmodelHash() =>
    r'012be2caad008f800016eac8817d59c8fe29b384';

abstract class _$GradeViewViewmodel
    extends $Notifier<AsyncValue<List<GradeViewCourseModel>>?> {
  AsyncValue<List<GradeViewCourseModel>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<GradeViewCourseModel>>?,
              AsyncValue<List<GradeViewCourseModel>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<GradeViewCourseModel>>?,
                AsyncValue<List<GradeViewCourseModel>>?
              >,
              AsyncValue<List<GradeViewCourseModel>>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
