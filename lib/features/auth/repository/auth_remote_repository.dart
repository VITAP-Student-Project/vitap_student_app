import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/exceptions.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/features/grade_view/model/grade_view_course.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/types/semester.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  final vtopService = serviceLocator<VtopClientService>();
  return AuthRemoteRepository(vtopService);
}

class AuthRemoteRepository {
  final VtopClientService vtopService;

  AuthRemoteRepository(this.vtopService);

  Future<Either<Failure, User>> login({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final client = await vtopService.getClient(
        username: registrationNumber,
        password: password,
      );

      final response = await vtop.fetchAllData(
        client: client,
        semesterId: semSubId,
      );

      final resBodyMap = jsonDecode(response) as Map<String, dynamic>;
      final user = User.fromJson(resBodyMap);

      // 1. Intercept the new grades array from the Rust JSON payload
      final rawGrades = resBodyMap['grades'] as List<dynamic>? ?? [];
      final courses = rawGrades
          .map((g) => GradeViewCourseModel.fromJson(g as Map<String, dynamic>))
          .toList();
      final marksList = user.marks.toList();

      // 2. Fetch the old user directly from ObjectBox to preserve the cache
      final store = serviceLocator<Store>();
      final oldUser = store.box<User>().getAll().firstOrNull;

      if (oldUser != null) {
        for (final newMark in marksList) {
          try {
            final oldMark = oldUser.marks.firstWhere((m) =>
            m.courseCode == newMark.courseCode &&
                m.courseType == newMark.courseType);
            newMark.gradeStatsJson = oldMark.gradeStatsJson;
          } catch (_) {}
        }
      }

      // 3. Merge the intercepted grades into the marks list
      if (courses.isEmpty) {
        _purgeGrades(marksList);
      } else {
        _mergeGrades(marksList, courses);
      }

      return Right(user);
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint('JSON parsing failed: ${e.toString()}');
      return Left(Failure('Invalid response format from server'));
    } catch (e) {
      debugPrint('Login failed: ${e.toString()}');
      return Left(Failure('An unexpected error occurred. Please try again.'));
    }
  }

  Future<Either<Failure, List<SemesterInfo>>> fetchSemesters({
    required String registrationNumber,
    required String password,
  }) async {
    try {
      final client = await vtopService.getClient(
        username: registrationNumber,
        password: password,
      );

      final response = await vtop.fetchSemesters(
        client: client,
      );
      return Right((response.semesters));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint('JSON parsing failed: ${e.toString()}');
      return Left(Failure('Invalid response format from server'));
    } catch (e) {
      debugPrint('Login failed: ${e.toString()}');
      return Left(Failure('An unexpected error occurred. Please try again.'));
    }
  }

  Future<Either<Failure, void>> submitLoginOtp(String otpCode) async {
    try {
      await vtopService.submitLoginOtp(otpCode);
      return const Right(null);
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      debugPrint('OTP submit failed: ${e.toString()}');
      return Left(Failure('Failed to verify OTP. Please try again.'));
    }
  }

  Future<Either<Failure, void>> resendLoginOtp() async {
    try {
      await vtopService.resendLoginOtp();
      return const Right(null);
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      debugPrint('OTP resend failed: ${e.toString()}');
      return Left(Failure('Failed to resend OTP. Please try again.'));
    }
  }

  void _purgeGrades(List<Mark> marks) {
    for (final mark in marks) {
      mark.grade = null;
      mark.grandTotal = null;
      mark.gradeCourseId = null;
      mark.gradeStatsJson = null;
    }
  }

  void _mergeGrades(List<Mark> marks, List<GradeViewCourseModel> courses) {
    final Map<String, List<GradeViewCourseModel>> groupedCourses = {};
    for (final c in courses) {
      groupedCourses.putIfAbsent(c.courseCode.trim(), () => []).add(c);
    }

    for (final mark in marks) {
      final matchGroup = groupedCourses[mark.courseCode.trim()];
      if (matchGroup != null) {
        final validGrade = matchGroup.firstWhere(
              (c) => c.grade.trim().isNotEmpty && c.grade != '-',
          orElse: () => matchGroup.first,
        );
        final validId = matchGroup.firstWhere(
              (c) => c.courseId.trim().isNotEmpty,
          orElse: () => matchGroup.first,
        );
        final validTotal = matchGroup.firstWhere(
              (c) => c.grandTotal.trim().isNotEmpty && c.grandTotal != '-',
          orElse: () => matchGroup.first,
        );

        mark.grade = validGrade.grade.trim().isEmpty || validGrade.grade == '-'
            ? null
            : validGrade.grade;
        mark.grandTotal = validTotal.grandTotal.trim().isEmpty ||
            validTotal.grandTotal == '-'
            ? null
            : validTotal.grandTotal;
        mark.gradeCourseId =
        validId.courseId.trim().isEmpty ? null : validId.courseId;
      } else {
        mark.grade = null;
        mark.grandTotal = null;
        mark.gradeCourseId = null;
        mark.gradeStatsJson = null;
      }
    }
  }
}