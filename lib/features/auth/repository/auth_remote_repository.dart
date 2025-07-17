import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/models/profile.dart';
import 'package:vit_ap_student_app/core/models/attendance.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
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
      log(response);

      final resBodyMap = jsonDecode(response) as Map<String, dynamic>;

      // Debug: Let's test each model separately to find the issue
      try {
        log("Testing Profile parsing...");
        final profileData = resBodyMap['profile'] as Map<String, dynamic>;
        final profile = Profile.fromJson(profileData);
        log("Profile parsed successfully");

        log("Testing Attendance parsing...");
        final attendanceData = resBodyMap['attendance'] as List<dynamic>;
        final attendance = attendanceData
            .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
            .toList();
        log("Attendance parsed successfully");

        log("Testing Timetable parsing...");
        final timetableData = resBodyMap['timetable'] as Map<String, dynamic>;
        final timetable = Timetable.fromJson(timetableData);
        log("Timetable parsed successfully");

        log("Testing ExamSchedule parsing...");
        final examScheduleData = resBodyMap['exam_schedule'] as List<dynamic>;
        final examSchedule = examScheduleData
            .map((e) => ExamSchedule.fromJson(e as Map<String, dynamic>))
            .toList();
        log("ExamSchedule parsed successfully");

        log("Testing Marks parsing...");
        final marksData = resBodyMap['marks'] as List<dynamic>;
        final marks = marksData
            .map((e) => Mark.fromJson(e as Map<String, dynamic>))
            .toList();
        log("Marks parsed successfully");

        log("All models parsed individually. Now testing User.fromJson...");
        return Right(User.fromJson(resBodyMap));
      } catch (e, stackTrace) {
        log("Error during model parsing: $e");
        log("Stack trace: $stackTrace");
        return Left(Failure("Model parsing failed: ${e.toString()}"));
      }
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint("Login failed: ${e.toString()}");
      return Left(Failure("Login failed: ${e.toString()}"));
    }
  }
}
