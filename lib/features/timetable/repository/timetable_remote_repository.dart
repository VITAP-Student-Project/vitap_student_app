import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'timetable_remote_repository.g.dart';

@riverpod
TimetableRemoteRepository timetableRemoteRepository(
    TimetableRemoteRepositoryRef ref) {
  final client = serviceLocator<http.Client>();
  return TimetableRemoteRepository(client);
}

class TimetableRemoteRepository {
  final http.Client client;

  TimetableRemoteRepository(this.client);

  Future<Either<Failure, Timetable>> fetchTimetable({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('${ServerConstants.baseUrl}/student/timetable'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "registration_number": registrationNumber,
              "password": password,
              "sem_sub_id": semSubId
            }),
          )
          .timeout(ServerConstants.apiTimeout);

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      log(response.body);

      if (response.statusCode != 200) {
        final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(Timetable.fromJson(resBodyMap));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on http.ClientException catch (e) {
      return Left(Failure("Client error: ${e.message}"));
    } on FormatException catch (e) {
      return Left(Failure("Invalid response format: ${e.message}"));
    } on TimeoutException {
      return Left(Failure("Request timed out. Please try again."));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
