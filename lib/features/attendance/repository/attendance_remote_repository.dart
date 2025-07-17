import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/models/attendance.dart';
import 'package:vit_ap_student_app/core/services/vtop_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart' as vtop;

part 'attendance_remote_repository.g.dart';

@riverpod
AttendanceRemoteRepository attendanceRemoteRepository(
    AttendanceRemoteRepositoryRef ref) {
  final vtopService = serviceLocator<VtopClientService>();
  return AttendanceRemoteRepository(vtopService);
}

class AttendanceRemoteRepository {
  final VtopClientService vtopService;

  AttendanceRemoteRepository(this.vtopService);

  Future<Either<Failure, List<Attendance>>> fetchAttendance({
    required String registrationNumber,
    required String password,
    required String semSubId,
  }) async {
    try {
      final client = await vtopService.getClient(
        username: registrationNumber,
        password: password,
      );

      final attendanceRecords = await vtop.fetchAttendance(
        client: client,
        semesterId: semSubId,
      );
      return Right(attendanceFromJson(attendanceRecords));
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      log("Error fetching attendance from VTOP: ${e.toString()}");
      return Left(Failure("Failed to fetch attendance: ${e.toString()}"));
    }
  }
}
