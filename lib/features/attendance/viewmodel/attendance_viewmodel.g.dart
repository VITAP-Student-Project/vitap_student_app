// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AttendanceViewMode)
final attendanceViewModeProvider = AttendanceViewModeProvider._();

final class AttendanceViewModeProvider
    extends
        $NotifierProvider<AttendanceViewMode, AsyncValue<List<Attendance>>?> {
  AttendanceViewModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceViewModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceViewModeHash();

  @$internal
  @override
  AttendanceViewMode create() => AttendanceViewMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Attendance>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Attendance>>?>(
        value,
      ),
    );
  }
}

String _$attendanceViewModeHash() =>
    r'4a547e70683e11b5ae1591f0297c3419091e3e71';

abstract class _$AttendanceViewMode
    extends $Notifier<AsyncValue<List<Attendance>>?> {
  AsyncValue<List<Attendance>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<Attendance>>?,
              AsyncValue<List<Attendance>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Attendance>>?,
                AsyncValue<List<Attendance>>?
              >,
              AsyncValue<List<Attendance>>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
