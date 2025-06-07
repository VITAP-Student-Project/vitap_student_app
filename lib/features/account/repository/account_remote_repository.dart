import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'account_remote_repository.g.dart';

@riverpod
AccountRemoteRepository accountRemoteRepository(
    AccountRemoteRepositoryRef ref) {
  final client = serviceLocator<http.Client>();
  return AccountRemoteRepository(client);
}

class AccountRemoteRepository {
  final http.Client client;

  AccountRemoteRepository(this.client);

  Future<Either<Failure, User>> syncUser({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final uri = Uri.parse('${ServerConstants.baseUrl}/student/all_data');

      final response = await client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "registration_number": registrationNumber,
              "password": password,
              "sem_sub_id": semSubId,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        try {
          final errorBody = jsonDecode(response.body);
          final message = errorBody is Map && errorBody['detail'] != null
              ? errorBody['detail'].toString()
              : 'Unexpected error occurred [${response.statusCode}]';
          return Left(Failure(message));
        } catch (_) {
          return Left(Failure(
              'Failed to parse error response [${response.statusCode}]'));
        }
      }

      final resBodyMap = jsonDecode(response.body);
      if (resBodyMap is! Map<String, dynamic>) {
        return Left(Failure("Unexpected response structure"));
      }

      try {
        final user = User.fromJson(resBodyMap);
        return Right(user);
      } catch (e) {
        return Left(Failure("Failed to parse user data: ${e.toString()}"));
      }
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
