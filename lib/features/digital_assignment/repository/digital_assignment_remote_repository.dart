import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/exceptions.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/features/digital_assignment/model/digital_assignment_model.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'digital_assignment_remote_repository.g.dart';

@riverpod
DigitalAssignmentRemoteRepository digitalAssignmentRemoteRepository(Ref ref) {
  final vtopService = serviceLocator<VtopClientService>();
  return DigitalAssignmentRemoteRepository(vtopService);
}

class DigitalAssignmentRemoteRepository {
  final VtopClientService vtopService;

  DigitalAssignmentRemoteRepository(this.vtopService);

  /// Fetch all digital assignments for a semester
  Future<Either<Failure, List<DigitalAssignment>>> fetchDigitalAssignments({
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

      final jsonString = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchDigitalAssignments(
          client: client,
          semesterId: semSubId,
        ),
      );

      log(jsonString);

      return Right(digitalAssignmentsFromJson(jsonString));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint('JSON parsing failed: ${e.toString()}');
      return Left(Failure('Invalid response format from server'));
    } catch (e) {
      debugPrint(
          'Error fetching digital assignments from VTOP: ${e.toString()}');
      return Left(
          Failure('Failed to fetch digital assignments: ${e.toString()}'));
    }
  }

  /// Upload a digital assignment file
  Future<Either<Failure, String>> uploadDigitalAssignment({
    required String registrationNumber,
    required String password,
    required String semSubId,
    required String classId,
    required String mode,
    required String fileName,
    required List<int> fileBytes,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );

      final result = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.uploadDigitalAssignment(
          client: client,
          classId: classId,
          mode: mode,
          fileName: fileName,
          fileBytes: fileBytes,
        ),
      );

      return Right(result);
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      // Check for OTP required error - this is a special case
      if (rustError is VtopError_DigitalAssignmentUploadOtpRequired) {
        return Left(Failure('OTP_REQUIRED'));
      }
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      debugPrint('Error uploading digital assignment: ${e.toString()}');
      return Left(Failure('Failed to upload assignment: ${e.toString()}'));
    }
  }

  /// Complete upload with OTP verification
  Future<Either<Failure, String>> uploadDigitalAssignmentWithOtp({
    required String registrationNumber,
    required String password,
    required String semSubId,
    required String otpEmail,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );

      final result = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.uploadDigitalAssignmentWithOtp(
          client: client,
          otpEmail: otpEmail,
        ),
      );

      return Right(result);
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      if (rustError is VtopError_DigitalAssignmentUploadIncorrectOtp) {
        return Left(Failure('Incorrect OTP. Please try again.'));
      }
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      debugPrint('Error verifying OTP: ${e.toString()}');
      return Left(Failure('Failed to verify OTP: ${e.toString()}'));
    }
  }

  /// Download a digital assignment file (question paper or submitted document)
  Future<Either<Failure, Uint8List>> downloadAssignmentFile({
    required String registrationNumber,
    required String password,
    required String semSubId,
    required String downloadPath,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );

      final bytes = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.downloadDigitalAssignment(
          client: client,
          downloadUrl: downloadPath,
        ),
      );

      return Right(bytes);
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      debugPrint('Error downloading assignment file: ${e.toString()}');
      return Left(Failure('Failed to download file: ${e.toString()}'));
    }
  }
}
