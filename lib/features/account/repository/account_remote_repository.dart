import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
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

  Future<Either<Failure, User>> syncUser({
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

      final resBodyMap = jsonDecode(response) as Map<String, dynamic>;
      return Right(User.fromJson(resBodyMap));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
