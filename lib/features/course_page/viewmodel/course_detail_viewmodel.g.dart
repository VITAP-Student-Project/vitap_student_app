// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CourseDetailViewmodel)
final courseDetailViewmodelProvider = CourseDetailViewmodelProvider._();

final class CourseDetailViewmodelProvider
    extends
        $NotifierProvider<
          CourseDetailViewmodel,
          AsyncValue<CoursePageDetailModel>?
        > {
  CourseDetailViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseDetailViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseDetailViewmodelHash();

  @$internal
  @override
  CourseDetailViewmodel create() => CourseDetailViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<CoursePageDetailModel>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<CoursePageDetailModel>?>(
        value,
      ),
    );
  }
}

String _$courseDetailViewmodelHash() =>
    r'd3a68819cd5a819b7bbc081a63e035305065f483';

abstract class _$CourseDetailViewmodel
    extends $Notifier<AsyncValue<CoursePageDetailModel>?> {
  AsyncValue<CoursePageDetailModel>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CoursePageDetailModel>?,
              AsyncValue<CoursePageDetailModel>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CoursePageDetailModel>?,
                AsyncValue<CoursePageDetailModel>?
              >,
              AsyncValue<CoursePageDetailModel>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
