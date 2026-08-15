import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/package_version.dart';
import 'package:vit_ap_student_app/core/utils/semantic_version.dart';
import 'package:vit_ap_student_app/features/home/model/announcement.dart';
import 'package:vit_ap_student_app/features/home/repository/announcement_dismissal_store.dart';
import 'package:vit_ap_student_app/features/home/repository/announcement_repository.dart';
import 'package:vit_ap_student_app/features/home/utils/announcement_targeting.dart';

part 'announcement_viewmodel.g.dart';

@riverpod
class AnnouncementViewModel extends _$AnnouncementViewModel {
  late AnnouncementRepository _announcementRepository;
  static const AnnouncementDismissalStore _dismissalStore =
      AnnouncementDismissalStore();

  /// Everything the feed returned, before targeting — kept so dismissing one
  /// announcement can re-filter without another network round trip.
  List<Announcement> _allAnnouncements = <Announcement>[];
  Set<String> _dismissedIds = <String>{};
  AnnouncementAudience? _audience;

  @override
  AsyncValue<List<Announcement>>? build() {
    _announcementRepository = ref.watch(announcementRepositoryProvider);
    Future<void>.microtask(fetchAnnouncements);
    return null;
  }

  Future<void> fetchAnnouncements() async {
    state = const AsyncValue.loading();

    final Either<Failure, List<Announcement>> result =
        await _announcementRepository.fetchAnnouncements();

    switch (result) {
      case Left(value: final failure):
        state = AsyncValue.error(failure.message, StackTrace.current);
      case Right(value: final announcements):
        _allAnnouncements = announcements;
        _audience = await _resolveAudience();
        _dismissedIds = prunedDismissedIds(
          await _dismissalStore.read(),
          announcements,
        );
        // Ids for announcements that have left the feed are dropped, so the
        // stored set cannot grow forever.
        await _dismissalStore.write(_dismissedIds);
        state = AsyncValue.data(_visible());
    }
  }

  Future<void> refreshAnnouncements() => fetchAnnouncements();

  /// Hides [id] on this device and remembers it.
  Future<void> dismiss(String id) async {
    _dismissedIds = <String>{..._dismissedIds, id};
    await _dismissalStore.write(_dismissedIds);
    state = AsyncValue.data(_visible());
  }

  List<Announcement> _visible() {
    final AnnouncementAudience? audience = _audience;
    if (audience == null) return const <Announcement>[];
    return visibleAnnouncements(
      _allAnnouncements,
      audience: audience,
      dismissedIds: _dismissedIds,
    );
  }

  /// Builds the targeting context: platform, installed version, and the coarse
  /// cohort already derived from the registration number for analytics.
  Future<AnnouncementAudience> _resolveAudience() async {
    final String? registrationNumber = ref
        .read(currentUserProvider)
        ?.profile
        .target
        ?.registrationNumber;

    StudentIdentity? identity;
    if (registrationNumber != null && registrationNumber.trim().isNotEmpty) {
      identity = StudentIdentity.fromRegistrationNumber(registrationNumber);
    }

    return AnnouncementAudience(
      platform: Platform.isIOS
          ? AnnouncementPlatform.ios
          : AnnouncementPlatform.android,
      appVersion: SemanticVersion.tryParse(await packageVersion()),
      joiningYear: _knownOrNull(identity?.joiningYear),
      branch: _knownOrNull(identity?.branch),
    );
  }

  /// [StudentIdentity] reports `Custom` when a registration number is off
  /// pattern. That is a placeholder, not a cohort, so it becomes null here and
  /// cohort-targeted announcements are held back rather than matched by accident.
  static String? _knownOrNull(String? value) =>
      value == null || value == 'Custom' ? null : value;
}
