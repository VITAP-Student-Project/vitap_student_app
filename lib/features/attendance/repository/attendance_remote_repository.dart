import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/exceptions.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/attendance.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/features/attendance/model/attendance_detail.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'attendance_remote_repository.g.dart';

@riverpod
AttendanceRemoteRepository attendanceRemoteRepository(
    AttendanceRemoteRepositoryRef ref) {
  final vtopService = serviceLocator<VtopClientService>();
  return AttendanceRemoteRepository(vtopService);
}

class AttendanceRemoteRepository {
  final VtopClientService vtopService;

  AttendanceRemoteRepository(this.vtopService);

  /// Fetch attendance data with automatic session management and retry
  /// This method demonstrates the new robust approach to handling VTOP requests
  Future<Either<Failure, List<Attendance>>> fetchAttendance({
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

      // Use the new executeWithRetry method for robust session handling
      final attendanceRecords = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchAttendance(
          client: client,
          semesterId: semSubId,
        ),
      );

      return Right(attendanceFromJson(attendanceRecords));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint("JSON parsing failed: ${e.toString()}");
      return Left(Failure("Invalid response format from server"));
    } catch (e) {
      debugPrint("Error fetching attendance from VTOP: ${e.toString()}");
      return Left(Failure("Failed to fetch attendance: ${e.toString()}"));
    }
  }

  /// Fetch detailed attendance with automatic session management and retry
  Future<Either<Failure, List<AttendanceDetail>>> fetchDetailedAttendance({
    required String registrationNumber,
    required String password,
    required String semSubId,
    required String courseId,
    required String courseType,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );

      // Use the new executeWithRetry method for robust session handling
      final attendanceRecords = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchAttendanceDetail(
          client: client,
          semesterId: semSubId,
          courseId: courseId,
          courseType: courseType,
        ),
      );

      debugPrint(attendanceRecords);
      return Right(attendanceDetailFromJson(attendanceRecords));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint("JSON parsing failed: ${e.toString()}");
      return Left(Failure("Invalid response format from server"));
    } catch (e) {
      debugPrint(
          "Error fetching detailed attendance from VTOP: ${e.toString()}");
      return Left(
          Failure("Failed to fetch detailed attendance: ${e.toString()}"));
    }
  }

  /// Legacy method - kept for backward compatibility but marked for migration
  /// @deprecated Use fetchAttendance instead which has better session handling
  @Deprecated('Use fetchAttendance with the new session management')
  Future<Either<Failure, List<Attendance>>> fetchAttendanceLegacy({
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

      // Use the new executeWithRetry method for robust session handling
      final attendanceRecords = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchAttendance(
          client: client,
          semesterId: semSubId,
        ),
      );
      return Right(attendanceFromJson(attendanceRecords));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint("JSON parsing failed: ${e.toString()}");
      return Left(Failure("Invalid response format from server"));
    } catch (e) {
      debugPrint("Error fetching attendance from VTOP: ${e.toString()}");
      return Left(Failure("Failed to fetch attendance: ${e.toString()}"));
    }
  }
}
