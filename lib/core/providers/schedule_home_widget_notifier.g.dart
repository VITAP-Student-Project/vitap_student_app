// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_home_widget_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScheduleHomeWidgetNotifier)
final scheduleHomeWidgetProvider = ScheduleHomeWidgetNotifierProvider._();

final class ScheduleHomeWidgetNotifierProvider
    extends $NotifierProvider<ScheduleHomeWidgetNotifier, Timetable?> {
  ScheduleHomeWidgetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleHomeWidgetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleHomeWidgetNotifierHash();

  @$internal
  @override
  ScheduleHomeWidgetNotifier create() => ScheduleHomeWidgetNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Timetable? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Timetable?>(value),
    );
  }
}

String _$scheduleHomeWidgetNotifierHash() =>
    r'5026a843ce35d5ee0a415d98ea347f2a099492fa';

abstract class _$ScheduleHomeWidgetNotifier extends $Notifier<Timetable?> {
  Timetable? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Timetable?, Timetable?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Timetable?, Timetable?>,
              Timetable?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
