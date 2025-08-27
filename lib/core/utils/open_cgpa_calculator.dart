import 'dart:convert';
import 'dart:io';
import 'package:vit_ap_student_app/core/models/grade_history.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

import 'launch_web.dart';

void openCgpaCalculator(GradeHistory gradeHistory) async {
  final compressed =
      gzip.encode(utf8.encode(jsonEncode(gradeHistory.toJson())));
  final encodedData = base64Url.encode(compressed);

  const baseUrl = 'https://cgpa-calculator-vitap.vercel.app/api/app/';
  final url = '$baseUrl?data=$encodedData';

  await directToWeb(url);

  AnalyticsService.logEvent('cgpa_calculator_opened', {
    'data_size': encodedData.length,
    'timestamp': DateTime.now().toIso8601String(),
  });
}
