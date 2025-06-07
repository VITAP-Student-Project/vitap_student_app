import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/exam_schedule.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/features/home/model/biometric.dart';
import 'package:vit_ap_student_app/features/home/model/payment_receipt.dart';
import 'package:vit_ap_student_app/features/home/model/pending_payment.dart';
import 'package:vit_ap_student_app/features/home/model/weather.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'home_remote_repository.g.dart';

@riverpod
HomeRemoteRepository homeRemoteRepository(HomeRemoteRepositoryRef ref) {
  final client = serviceLocator<http.Client>();
  return HomeRemoteRepository(client);
}

class HomeRemoteRepository {
  final http.Client client;

  HomeRemoteRepository(this.client);

  Future<Either<Failure, Weather>> fetchWeather() async {
    try {
      final response = await client.get(
        Uri.parse(
            'https://api.open-meteo.com/v1/forecast?latitude=16.51&longitude=80.51&hourly=temperature_2m,apparent_temperature,rain,weather_code,uv_index&daily=temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=1&models=best_match'),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(Weather.fromJson(resBodyMap));
    } catch (e) {
      log("Error: ${e.toString()}");
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<Biometric>>> fetchBiometric({
    required String registrationNumber,
    required String password,
    required String date,
  }) async {
    try {
      log("Date: $date");
      final response = await client
          .post(
            Uri.parse('${ServerConstants.baseUrl}/student/biometric'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "registration_number": registrationNumber,
              "password": password,
              "date": date
            }),
          )
          .timeout(const Duration(seconds: 10));

      // final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      log(response.body);

      if (response.statusCode != 200) {
        final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(biometricFromJson(response.body));
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

  Future<Either<Failure, List<Mark>>> fetchMarks({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('${ServerConstants.baseUrl}/student/marks'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "registration_number": registrationNumber,
              "password": password,
              "sem_sub_id": semSubId
            }),
          )
          .timeout(const Duration(seconds: 10));

      // final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      log(response.body);

      if (response.statusCode != 200) {
        final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(markFromJson(response.body));
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

  Future<Either<Failure, List<ExamSchedule>>> fetchExamSchedule({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('${ServerConstants.baseUrl}/student/exam_schedule'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "registration_number": registrationNumber,
              "password": password,
              "sem_sub_id": semSubId
            }),
          )
          .timeout(const Duration(seconds: 10));

      // final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      log(response.body);

      if (response.statusCode != 200) {
        final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(examScheduleFromJson(response.body));
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

  Future<Either<Failure, List<PendingPayment>>> fetchPendingPayments({
    required String registrationNumber,
    required String password,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('${ServerConstants.baseUrl}/student/pending_payments'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "registration_number": registrationNumber,
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      // final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      log(response.body);

      if (response.statusCode != 200) {
        final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(pendingPaymentFromJson(response.body));
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

  Future<Either<Failure, List<PaymentReceipt>>> fetchPaymentReceipts({
    required String registrationNumber,
    required String password,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('${ServerConstants.baseUrl}/student/payment_receipts'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "registration_number": registrationNumber,
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      // final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      log(response.body);

      if (response.statusCode != 200) {
        final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(paymentReceiptFromJson(response.body));
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
