import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/file_storage_service.dart';
import 'package:vit_ap_student_app/core/common/widget/pdf_viewer_screen.dart';
import 'package:vit_ap_student_app/features/home/repository/outing_remote_repository.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'pdf_download_viewmodel.g.dart';

@riverpod
class GeneralOutingPdfDownloadViewModel
    extends _$GeneralOutingPdfDownloadViewModel {
  late OutingRemoteRepository _outingRemoteRepository;
  late FileStorageService _fileStorageService;

  @override
  AsyncValue<String>? build() {
    _outingRemoteRepository = ref.watch(outingRemoteRepositoryProvider);
    _fileStorageService = serviceLocator<FileStorageService>();
    return null;
  }

  Future<void> downloadGeneralOutingPdf({
    required String leaveId,
    String? customFileName,
  }) async {
    state = const AsyncValue.loading();

    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error(
        "User credentials not found. Please login again.",
        StackTrace.current,
      );
      return;
    }

    // Download PDF bytes from repository
    final res = await _outingRemoteRepository.downloadGeneralOutingReport(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      leaveId: leaveId,
    );

    switch (res) {
      case Left(value: final failure):
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      case Right(value: final pdfBytes):
        await _savePdfToFile(pdfBytes, leaveId, customFileName);
        break;
    }
  }

  Future<void> viewGeneralOutingPdf({
    required String leaveId,
    required BuildContext context,
    String? customFileName,
  }) async {
    state = const AsyncValue.loading();

    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error(
        "User credentials not found. Please login again.",
        StackTrace.current,
      );
      return;
    }

    // Download PDF bytes from repository
    final res = await _outingRemoteRepository.downloadGeneralOutingReport(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      leaveId: leaveId,
    );

    switch (res) {
      case Left(value: final failure):
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      case Right(value: final pdfBytes):
        state = const AsyncValue.data("PDF loaded successfully");

        // Navigate to PDF viewer
        if (context.mounted) {
          final fileName = customFileName ?? 'general_outing_report_$leaveId';
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewerScreen(
                pdfBytes: pdfBytes,
                title: leaveId,
                fileName: fileName,
              ),
            ),
          );
        }
        break;
    }
  }

  Future<void> _savePdfToFile(
    Uint8List pdfBytes,
    String leaveId,
    String? customFileName,
  ) async {
    try {
      final fileName = customFileName ?? 'general_outing_report_$leaveId';

      final filePath = await _fileStorageService.savePdfToDownloads(
        pdfBytes: pdfBytes,
        fileName: fileName,
      );

      if (filePath != null) {
        state = AsyncValue.data(filePath);
      } else {
        state = AsyncValue.error(
          "Failed to save PDF file",
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(
        "Error saving PDF: ${e.toString()}",
        StackTrace.current,
      );
    }
  }
}

@riverpod
class WeekendOutingPdfDownloadViewModel
    extends _$WeekendOutingPdfDownloadViewModel {
  late OutingRemoteRepository _outingRemoteRepository;
  late FileStorageService _fileStorageService;

  @override
  AsyncValue<String>? build() {
    _outingRemoteRepository = ref.watch(outingRemoteRepositoryProvider);
    _fileStorageService = serviceLocator<FileStorageService>();
    return null;
  }

  Future<void> downloadWeekendOutingPdf({
    required String leaveId,
    String? customFileName,
  }) async {
    state = const AsyncValue.loading();

    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error(
        "User credentials not found. Please login again.",
        StackTrace.current,
      );
      return;
    }

    // Download PDF bytes from repository
    final res = await _outingRemoteRepository.downloadWeekendOutingReport(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      leaveId: leaveId,
    );

    switch (res) {
      case Left(value: final failure):
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      case Right(value: final pdfBytes):
        await _savePdfToFile(pdfBytes, leaveId, customFileName);
        break;
    }
  }

  Future<void> viewWeekendOutingPdf({
    required String leaveId,
    required BuildContext context,
    String? customFileName,
  }) async {
    state = const AsyncValue.loading();

    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error(
        "User credentials not found. Please login again.",
        StackTrace.current,
      );
      return;
    }

    // Download PDF bytes from repository
    final res = await _outingRemoteRepository.downloadWeekendOutingReport(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      leaveId: leaveId,
    );

    switch (res) {
      case Left(value: final failure):
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      case Right(value: final pdfBytes):
        state = const AsyncValue.data("PDF loaded successfully");

        // Navigate to PDF viewer
        if (context.mounted) {
          final fileName = customFileName ?? 'weekend_outing_report_$leaveId';
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewerScreen(
                pdfBytes: pdfBytes,
                title: leaveId,
                fileName: fileName,
              ),
            ),
          );
        }
        break;
    }
  }

  Future<void> _savePdfToFile(
    Uint8List pdfBytes,
    String leaveId,
    String? customFileName,
  ) async {
    try {
      final fileName = customFileName ?? 'weekend_outing_report_$leaveId';

      final filePath = await _fileStorageService.savePdfToDownloads(
        pdfBytes: pdfBytes,
        fileName: fileName,
      );

      if (filePath != null) {
        state = AsyncValue.data(filePath);
      } else {
        state = AsyncValue.error(
          "Failed to save PDF file",
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(
        "Error saving PDF: ${e.toString()}",
        StackTrace.current,
      );
    }
  }
}
