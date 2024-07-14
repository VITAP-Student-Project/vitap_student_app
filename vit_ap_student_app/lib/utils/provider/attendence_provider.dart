// Provider to handle fetching and storing attendance data
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/attendence_api.dart';

final fetchAttendanceProvider =
    FutureProvider.family<void, Map<String, String>>((ref, params) async {
  final service = ref.read(attendanceServiceProvider);
  String username = params['username']!;
  String password = params['password']!;
  String semSubID = params['semSubID']!;
  await service.fetchAndStoreAttendanceData(username, password, semSubID);
});