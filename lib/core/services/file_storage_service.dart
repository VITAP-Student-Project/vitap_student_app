import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileStorageService {
  /// Save PDF bytes to the Downloads folder
  Future<String?> savePdfToDownloads({
    required Uint8List pdfBytes,
    required String fileName,
  }) async {
    try {
      // Request storage permission
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Get Downloads directory
      final downloadsDir = await _getDownloadsDirectory();
      if (downloadsDir == null) {
        throw Exception('Could not access Downloads directory');
      }

      // Ensure the file name has .pdf extension
      final pdfFileName =
          fileName.endsWith('.pdf') ? fileName : '$fileName.pdf';

      // Create the file path
      final filePath = '${downloadsDir.path}/$pdfFileName';
      final file = File(filePath);

      // Write the PDF bytes to the file
      await file.writeAsBytes(pdfBytes);

      return filePath;
    } catch (e) {
      throw Exception('Failed to save PDF: ${e.toString()}');
    }
  }

  /// Request storage permission based on platform and Android version
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 13+ (API level 33+), we don't need WRITE_EXTERNAL_STORAGE
      // For older versions, request the permission
      final androidInfo = await _getAndroidSdkVersion();

      if (androidInfo >= 33) {
        // Android 13+ uses scoped storage, no special permission needed for Downloads
        return true;
      } else {
        // Android 12 and below
        final status = await Permission.storage.request();
        return status == PermissionStatus.granted;
      }
    } else if (Platform.isIOS) {
      // iOS doesn't require explicit permission for app's Documents directory
      return true;
    }

    return false;
  }

  /// Get Downloads directory based on platform
  Future<Directory?> _getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      // Try to get the Downloads directory
      final directory = Directory('/storage/emulated/0/Download');
      if (await directory.exists()) {
        return directory;
      }

      // Fallback to external storage directory
      final externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        final downloadsDir = Directory('${externalDir.path}/Download');
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        return downloadsDir;
      }
    } else if (Platform.isIOS) {
      // For iOS, use Documents directory as Downloads equivalent
      return await getApplicationDocumentsDirectory();
    }

    return null;
  }

  /// Get Android SDK version
  Future<int> _getAndroidSdkVersion() async {
    if (Platform.isAndroid) {
      try {
        final result = await Process.run('getprop', ['ro.build.version.sdk']);
        return int.parse(result.stdout.toString().trim());
      } catch (e) {
        // Default to older version to be safe
        return 30;
      }
    }
    return 0;
  }

  /// Check if file exists at given path
  Future<bool> fileExists(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

  /// Delete file at given path
  Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Get file size in bytes
  Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
