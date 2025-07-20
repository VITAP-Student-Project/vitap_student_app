import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/error/exceptions.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/types/semester.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';

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
      debugPrint("Login failed: ${e.toString()}");
      return Left(Failure("An unexpected error occurred. Please try again."));
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
      log(response.semesters.first.name);
      return Right((response.semesters));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } on FormatException catch (e) {
      debugPrint("JSON parsing failed: ${e.toString()}");
      return Left(Failure("Invalid response format from server"));
    } catch (e) {
      debugPrint("Login failed: ${e.toString()}");
      return Left(Failure("An unexpected error occurred. Please try again."));
    }
  }
}
