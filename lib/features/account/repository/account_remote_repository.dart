import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/exceptions.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'account_remote_repository.g.dart';

@riverpod
AccountRemoteRepository accountRemoteRepository(
    AccountRemoteRepositoryRef ref) {
  final vtopService = serviceLocator<VtopClientService>();
  return AccountRemoteRepository(vtopService);
}

class AccountRemoteRepository {
  final VtopClientService vtopService;

  AccountRemoteRepository(this.vtopService);

  /// Sync user data with enhanced session management and automatic retry
  /// This method demonstrates the new robust approach for critical user data operations
  Future<Either<Failure, User>> syncUser({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      // Debug: Check if semSubId is empty
      if (semSubId.isEmpty) {
        debugPrint(
            "WARNING: semSubId is empty! This will cause empty data results.");
        return Left(
            Failure("Semester ID is missing. Please logout and login again."));
      }

      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );

      debugPrint("Syncing with semSubId: '$semSubId'");

      // Use the new executeWithRetry method for robust session handling
      // This is especially important for sync operations as they're critical for user experience
      final response = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchAllData(
          client: client,
          semesterId: semSubId,
        ),
        maxRetries: 3, // Higher retry count for critical sync operations
      );

      final resBodyMap = jsonDecode(response) as Map<String, dynamic>;
      return Right(User.fromJson(resBodyMap));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint("JSON parsing failed: ${e.toString()}");
      return Left(Failure("Invalid response format from server"));
    } catch (e) {
      debugPrint("Unexpected error during user sync: ${e.toString()}");
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  /// Legacy method - kept for backward compatibility but marked for migration
  /// @deprecated Use syncUser instead which has better session handling
  @Deprecated('Use syncUser with the new session management')
  Future<Either<Failure, User>> syncUserLegacy({
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
      final response = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchAllData(
          client: client,
          semesterId: semSubId,
        ),
      );

      final resBodyMap = jsonDecode(response) as Map<String, dynamic>;
      return Right(User.fromJson(resBodyMap));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint("JSON parsing failed: ${e.toString()}");
      return Left(Failure("Invalid response format from server"));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
