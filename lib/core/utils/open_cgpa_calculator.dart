import 'dart:convert';
import 'dart:io';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';
import 'package:vit_ap_student_app/core/models/grade_history.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

import 'launch_web.dart';

String generateCgpaCalculatorUrl(GradeHistory gradeHistory) {
  final compressed =
      gzip.encode(utf8.encode(jsonEncode(gradeHistory.toJson())));
  final encodedData = base64Url.encode(compressed);

  const baseUrl = ServerConstants.cgpaCalculatorBaseUrl;
  final url = '$baseUrl?data=$encodedData';

  return url;
}

void openCgpaCalculator(GradeHistory gradeHistory) async {
  final url = generateCgpaCalculatorUrl(gradeHistory);

  await directToWeb(url);

  AnalyticsService.logEvent('cgpa_calculator_opened', {
    'data_size': base64Url
        .encode(gzip.encode(utf8.encode(jsonEncode(gradeHistory.toJson()))))
        .length,
    'timestamp': DateTime.now().toIso8601String(),
  });
}
