import 'dart:convert';
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
      final response = await client.post(
        Uri.parse('${ServerConstants.baseUrl}/student/all_data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "registration_number": registrationNumber,
          "password": password,
          "sem_sub_id": semSubId
        }),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(User.fromJson(resBodyMap));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
