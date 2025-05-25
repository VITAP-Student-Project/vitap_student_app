import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/user.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<Failure, User>> login({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ServerConstants.baseUrl}/student/all_data',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "registration_number": registrationNumber,
            "password": password,
            "sem_sub_id": semSubId
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(
        User.fromJson(resBodyMap),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
