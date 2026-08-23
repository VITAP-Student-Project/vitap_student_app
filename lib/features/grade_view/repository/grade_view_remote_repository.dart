import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/exceptions.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/features/grade_view/model/grade_view_course.dart';
import 'package:vit_ap_student_app/features/grade_view/model/grade_view_detail.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'grade_view_remote_repository.g.dart';

@riverpod
GradeViewRemoteRepository gradeViewRemoteRepository(Ref ref) {
  final vtopService = serviceLocator<VtopClientService>();
  return GradeViewRemoteRepository(vtopService);
}

class GradeViewRemoteRepository {
  final VtopClientService vtopService;

  GradeViewRemoteRepository(this.vtopService);

  /// Fetches the graded courses for a semester.
  ///
  /// Grades appear only once a semester has ended; the current semester
  /// returns an empty list until results are published.
  Future<Either<Failure, List<GradeViewCourseModel>>> fetchGradeView({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );

      final coursesJson = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) =>
            vtop.fetchGradeView(client: client, semesterId: semSubId),
      );

      return Right(gradeViewCoursesFromJson(coursesJson));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint('JSON parsing failed: ${e.toString()}');
      return Left(Failure('Invalid response format from server'));
    } catch (e) {
      debugPrint('Error fetching grade view: ${e.toString()}');
      return Left(Failure('Failed to fetch grades: ${e.toString()}'));
    }
  }

  /// Fetches the mark breakdown and class statistics for a single course.
  Future<Either<Failure, GradeViewDetailModel>> fetchGradeViewDetail({
    required String registrationNumber,
    required String password,
    required String semSubId,
    required String courseId,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );

      final detailJson = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchGradeViewDetail(
          client: client,
          semesterId: semSubId,
          courseId: courseId,
        ),
      );

      return Right(gradeViewDetailFromJson(detailJson));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint('JSON parsing failed: ${e.toString()}');
      return Left(Failure('Invalid response format from server'));
    } catch (e) {
      debugPrint('Error fetching grade view detail: ${e.toString()}');
      return Left(Failure('Failed to fetch grade details: ${e.toString()}'));
    }
  }
}
