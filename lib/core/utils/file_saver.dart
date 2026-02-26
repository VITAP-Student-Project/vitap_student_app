import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vit_ap_student_app/core/utils/file_type_detector.dart';

/// Utility class for saving files with platform-specific handling
/// Uses flutter_file_dialog on Android to let users pick save location
/// Uses documents directory on iOS
class FileSaver {
  /// Save a file with the given bytes and filename
  ///
  /// On Android: Opens a file picker dialog for the user to choose the save location
  /// On iOS: Saves to the app's documents directory
  ///
  /// Returns the saved file path on success, or null if the user cancelled or an error occurred
  static Future<String?> saveFile({
    required Uint8List bytes,
    required String fileName,
    String? mimeType,
  }) async {
    try {
      if (Platform.isAndroid) {
        return await _saveFileAndroid(
          bytes: bytes,
          fileName: fileName,
          mimeType: mimeType,
        );
      } else if (Platform.isIOS) {
        return await _saveFileIOS(
          bytes: bytes,
          fileName: fileName,
        );
      } else {
        // For other platforms, use documents directory
        return await _saveFileDefault(
          bytes: bytes,
          fileName: fileName,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Save file on Android using flutter_file_dialog
  /// This opens a system file picker dialog for the user to choose the save location
  static Future<String?> _saveFileAndroid({
    required Uint8List bytes,
    required String fileName,
    String? mimeType,
  }) async {
    // First, save the file to a temporary location
    final tempDir = await getTemporaryDirectory();
    final tempFilePath = '${tempDir.path}/$fileName';
    final tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(bytes);

    try {
      // Use flutter_file_dialog to let user pick save location
      final params = SaveFileDialogParams(
        sourceFilePath: tempFilePath,
        fileName: fileName,
        mimeTypesFilter: mimeType != null ? [mimeType] : null,
      );

      final savedFilePath = await FlutterFileDialog.saveFile(params: params);

      // Clean up temp file
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      return savedFilePath;
    } catch (e) {
      // Clean up temp file on error
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
      rethrow;
    }
  }

  /// Save file on iOS using documents directory
  static Future<String?> _saveFileIOS({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  /// Default save method for other platforms
  static Future<String?> _saveFileDefault({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  /// Save a PDF file
  /// Convenience method that sets the correct mime type for PDF files
  static Future<String?> savePdf({
    required Uint8List bytes,
    required String fileName,
  }) async {
    // Ensure filename has .pdf extension
    final pdfFileName = fileName.endsWith('.pdf') ? fileName : '$fileName.pdf';

    return await saveFile(
      bytes: bytes,
      fileName: pdfFileName,
      mimeType: 'application/pdf',
    );
  }

  // ---------------------------------------------------------------------------
  // Course Material Methods
  // ---------------------------------------------------------------------------

  /// Saves a course material file and opens it with the appropriate external app.
  ///
  /// Detects the file format from magic bytes (since the VTOP API download path
  /// always says "downloadPdf/" regardless of actual file type), saves the file
  /// with the correct extension, and opens it using the system's default app.
  ///
  /// Returns the saved file path on success, or null on failure.
  static Future<String?> saveAndOpenCourseMaterial({
    required Uint8List bytes,
    required String courseCode,
    required String label,
  }) async {
    final extension = FileTypeDetector.detectExtension(bytes);
    final mimeType = FileTypeDetector.getMimeType(extension);
    final sanitizedLabel = _sanitizeFileName(label);
    final fileName = '${courseCode}_$sanitizedLabel.$extension';

    return await _saveToTempAndOpen(
      bytes: bytes,
      fileName: fileName,
      mimeType: mimeType,
    );
  }

  /// Saves all course materials (ZIP archive) and opens with the appropriate app.
  ///
  /// The "Download All" feature always returns a ZIP file.
  /// Returns the saved file path on success, or null on failure.
  static Future<String?> saveAndOpenAllCourseMaterials({
    required Uint8List bytes,
    required String courseCode,
  }) async {
    final fileName = '${courseCode}_all_materials.zip';

    return await _saveToTempAndOpen(
      bytes: bytes,
      fileName: fileName,
      mimeType: 'application/zip',
    );
  }

  /// Saves the course syllabus (.docx) and opens with the appropriate app.
  ///
  /// The syllabus download always returns a .docx file.
  /// Returns the saved file path on success, or null on failure.
  static Future<String?> saveAndOpenCourseSyllabus({
    required Uint8List bytes,
    required String courseCode,
  }) async {
    final fileName = '${courseCode}_syllabus.docx';

    return await _saveToTempAndOpen(
      bytes: bytes,
      fileName: fileName,
      mimeType:
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    );
  }

  /// Saves bytes to a temp file and opens it with the system's default app.
  ///
  /// Returns the saved file path on success, or null if opening failed.
  /// If open_file fails, falls back to saving via the system file dialog
  /// so the user can choose where to save the file and open it from there.
  static Future<String?> _saveToTempAndOpen({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  }) async {
    // Save to temp directory first
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    // Try to open with the appropriate external app
    final result = await OpenFile.open(filePath);

    if (result.type == ResultType.done) {
      return filePath;
    }

    // Fallback: save via system file dialog so user can access the file
    final savedPath = await saveFile(
      bytes: bytes,
      fileName: fileName,
      mimeType: mimeType,
    );

    if (savedPath != null) {
      // Try to open the permanently saved file
      await OpenFile.open(savedPath);
    }

    return savedPath;
  }

  /// Sanitizes filename by removing/replacing invalid characters.
  static String _sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
  }
}
