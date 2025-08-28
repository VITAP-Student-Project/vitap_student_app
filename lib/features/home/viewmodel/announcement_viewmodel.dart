import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/features/home/model/announcement.dart';
import 'package:vit_ap_student_app/features/home/repository/announcement_repository.dart';

part 'announcement_viewmodel.g.dart';

@riverpod
class AnnouncementViewModel extends _$AnnouncementViewModel {
  late AnnouncementRepository _announcementRepository;

  @override
  AsyncValue<List<Announcement>>? build() {
    _announcementRepository = ref.watch(announcementRepositoryProvider);
    // Auto-fetch announcements when viewmodel is initialized
    _autoFetchAnnouncements();
    return null;
  }

  void _autoFetchAnnouncements() {
    // Use addPostFrameCallback to ensure widget is built first
    Future.microtask(() => fetchAnnouncements());
  }

  Future<void> fetchAnnouncements() async {
    state = const AsyncValue.loading();

    final result = await _announcementRepository.fetchAnnouncements();

    state = switch (result) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final announcements) => AsyncValue.data(announcements),
    };
  }

  Future<void> refreshAnnouncements() async {
    await fetchAnnouncements();
  }
}
