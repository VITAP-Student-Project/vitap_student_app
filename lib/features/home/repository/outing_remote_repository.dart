import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/exceptions.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/features/home/model/general_outing_report.dart';
import 'package:vit_ap_student_app/features/home/model/weekend_outing_report.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'outing_remote_repository.g.dart';

@riverpod
OutingRemoteRepository outingRemoteRepository(OutingRemoteRepositoryRef ref) {
  final client = serviceLocator<http.Client>();
  final vtopService = serviceLocator<VtopClientService>();
  return OutingRemoteRepository(client, vtopService);
}

class OutingRemoteRepository {
  final http.Client client;
  final VtopClientService vtopService;

  OutingRemoteRepository(this.client, this.vtopService);

  Future<Either<Failure, List<GeneralOutingReport>>> fetchGeneralOutingReports({
    required String registrationNumber,
    required String password,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      // Use the new executeWithRetry method for robust session handling
      final generalOutingRecords = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchGeneralOutingReports(
          client: client,
        ),
      );

      return Right(generalOutingReportFromJson(generalOutingRecords));
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

  Future<Either<Failure, List<WeekendOutingReport>>> fetchWeekendOutingReports({
    required String registrationNumber,
    required String password,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      // Use the new executeWithRetry method for robust session handling
      final generalOutingRecords = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchWeekendOutingReports(
          client: client,
        ),
      );

      log(generalOutingRecords);

      return Right(weekendOutingReportFromJson(generalOutingRecords));
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

  Future<Either<Failure, Uint8List>> downloadWeekendOutingReport({
    required String registrationNumber,
    required String password,
    required String leaveId,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      // Use the new executeWithRetry method for robust session handling
      final weekendOutingReport = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchWeekendOutingPdf(
          client: client,
          bookingId: leaveId,
        ),
      );

      return Right(weekendOutingReport);
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

  Future<Either<Failure, Uint8List>> downloadGeneralOutingReport({
    required String registrationNumber,
    required String password,
    required String leaveId,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      // Use the new executeWithRetry method for robust session handling
      final generalOutingReport = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.fetchGeneralOutingPdf(
          client: client,
          leaveId: leaveId,
        ),
      );

      return Right(generalOutingReport);
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

  Future<Either<Failure, String>> submitGeneralOutingForm({
    required String registrationNumber,
    required String password,
    required String outPlace,
    required String purposeOfVisit,
    required String outingDate,
    required String outTime,
    required String inDate,
    required String inTime,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      final response = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.submitGeneralOutingForm(
          client: client,
          outPlace: outPlace,
          purposeOfVisit: purposeOfVisit,
          outingDate: outingDate,
          outTime: outTime,
          inDate: inDate,
          inTime: inTime,
        ),
      );

      return Right(response);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, String>> submitWeekendOutingForm({
    required String registrationNumber,
    required String password,
    required String outPlace,
    required String purposeOfVisit,
    required String outingDate,
    required String outTime,
    required String contactNumber,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      final response = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.submitWeekendOutingForm(
          client: client,
          outPlace: outPlace,
          purposeOfVisit: purposeOfVisit,
          outingDate: outingDate,
          outTime: outTime,
          contactNumber: contactNumber,
        ),
      );

      return Right(response);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, String>> deleteGeneralOuting({
    required String registrationNumber,
    required String password,
    required String leaveId,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      final response = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.deleteGeneralOuting(
          client: client,
          leaveId: leaveId,
        ),
      );

      return Right(response);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, String>> deleteWeekendOuting({
    required String registrationNumber,
    required String password,
    required String bookingId,
  }) async {
    try {
      final credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: '',
      );

      final response = await vtopService.executeWithRetry(
        credentials: credentials,
        operation: (client) => vtop.deleteWeekendOuting(
          client: client,
          bookingId: bookingId,
        ),
      );

      return Right(response);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on VtopError catch (rustError) {
      final failureMessage = await VtopException.getFailureMessage(rustError);
      return Left(Failure(failureMessage));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
