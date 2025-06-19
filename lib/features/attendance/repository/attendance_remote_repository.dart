import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/attendance.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'attendance_remote_repository.g.dart';

@riverpod
AttendanceRemoteRepository attendanceRemoteRepository(
    AttendanceRemoteRepositoryRef ref) {
  final client = serviceLocator<http.Client>();
  return AttendanceRemoteRepository(client);
}

class AttendanceRemoteRepository {
  final http.Client client;

  AttendanceRemoteRepository(this.client);

  Future<Either<Failure, List<Attendance>>> fetchAttendance({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${ServerConstants.baseUrl}/student/attendance'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "registration_number": registrationNumber,
          "password": password,
          "sem_sub_id": semSubId
        }),
      )
          .timeout(ServerConstants.apiTimeout);

      // final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      log(response.body);

      if (response.statusCode != 200) {
        final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(attendanceFromJson(response.body));
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
