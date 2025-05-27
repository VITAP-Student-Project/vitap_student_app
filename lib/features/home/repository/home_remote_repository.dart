import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
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
      log("${resBodyMap}");

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(Weather.fromJson(resBodyMap));
    } catch (e) {
      log("Error: ${e.toString()}");
      return Left(Failure(e.toString()));
    }
  }
}
