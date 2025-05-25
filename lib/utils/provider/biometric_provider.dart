import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/apis.dart';

final biometricLogProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, date) async {
  final response = await fetchBiometricLog(date);
  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to fetch biometrics: ${response.statusCode}');
  }
});
