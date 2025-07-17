import 'package:fpdart/fpdart.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/home/repository/home_remote_repository.dart';

part 'marks_viewmodel.g.dart';

@riverpod
class MarksViewModel extends _$MarksViewModel {
  late HomeRemoteRepository _homeRemoteRepository;

  @override
  AsyncValue<List<Mark>>? build() {
    _homeRemoteRepository = ref.watch(homeRemoteRepositoryProvider);

    return null;
  }

  Future<void> refreshMarks() async {
    state = const AsyncValue.loading();
    final User? user = ref.read(currentUserNotifierProvider);
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    final Credentials? credentials = await userNotifier.getSavedCredentials();
    if (credentials == null) {
      AsyncValue.error(
          "User not found. Please Logout and Login.", StackTrace.current);
    }
    final res = await _homeRemoteRepository.fetchMarks(
      registrationNumber: credentials!.registrationNumber,
      password: credentials.password,
      semSubId: credentials.semSubId,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final newMarks)) {
      state = AsyncValue.data(newMarks);
      if (user != null) {
        userNotifier
            .updateUser(user.copyWith(marks: ToMany<Mark>(items: newMarks)));
      }
    }
  }
}
