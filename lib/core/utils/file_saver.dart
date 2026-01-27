import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';

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
}
