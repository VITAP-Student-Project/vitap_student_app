import 'dart:io';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:permission_handler/permission_handler.dart';

/// A service class for handling file storage operations across different platforms
/// Uses the file_saver package to save files in appropriate directories based on platform:
/// - Android: Application files directory (Android/data/your.package.name/files/)
/// - iOS: Application Documents Directory
/// - Web: Downloads folder (direct download)
/// - Windows/MacOS/Linux: Downloads folder
class FileStorageService {
  /// Save PDF bytes to the appropriate directory based on platform
  ///
  /// [pdfBytes] - The PDF file content as bytes
  /// [fileName] - The name of the file (extension will be added automatically)
  /// [includeExtension] - Whether to include .pdf extension in saved filename
  ///
  /// Returns the file path where the PDF was saved, or null if failed
  Future<String?> savePdfToDownloads({
    required Uint8List pdfBytes,
    required String fileName,
    bool includeExtension = true,
  }) async {
    try {
      // Request storage permission if needed
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Remove .pdf extension from fileName if it exists to avoid duplication
      final baseName = fileName.endsWith('.pdf')
          ? fileName.substring(0, fileName.length - 4)
          : fileName;

      // Save the PDF using file_saver
      final result = await FileSaver.instance.saveFile(
        name: baseName,
        bytes: pdfBytes,
        fileExtension: 'pdf',
        includeExtension: includeExtension,
        mimeType: MimeType.pdf,
      );

      return result;
    } catch (e) {
      throw Exception('Failed to save PDF: ${e.toString()}');
    }
  }

  /// Save any file with specified extension and MIME type
  ///
  /// [fileBytes] - The file content as bytes
  /// [fileName] - The name of the file
  /// [fileExtension] - The file extension (without dot)
  /// [mimeType] - The MIME type for the file
  /// [includeExtension] - Whether to include extension in saved filename
  ///
  /// Returns the file path where the file was saved, or null if failed
  Future<String?> saveFileWithExtension({
    required Uint8List fileBytes,
    required String fileName,
    required String fileExtension,
    required MimeType mimeType,
    bool includeExtension = true,
  }) async {
    try {
      // Request storage permission if needed
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Remove extension from fileName if it exists to avoid duplication
      final baseName = fileName.endsWith('.$fileExtension')
          ? fileName.substring(0, fileName.length - fileExtension.length - 1)
          : fileName;

      // Save the file using file_saver
      final result = await FileSaver.instance.saveFile(
        name: baseName,
        bytes: fileBytes,
        fileExtension: fileExtension,
        includeExtension: includeExtension,
        mimeType: mimeType,
      );

      return result;
    } catch (e) {
      throw Exception('Failed to save file: ${e.toString()}');
    }
  }

  /// Save file from a File object
  ///
  /// [file] - The File object to save
  /// [fileName] - Optional custom name for the file
  /// [includeExtension] - Whether to include extension in saved filename
  ///
  /// Returns the file path where the file was saved, or null if failed
  Future<String?> saveFromFile({
    required File file,
    String? fileName,
    bool includeExtension = true,
  }) async {
    try {
      // Request storage permission if needed
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Get file extension from the original file
      final originalPath = file.path;
      final extension = originalPath.split('.').last;

      // Use provided fileName or extract from file path
      final baseName =
          fileName ?? originalPath.split('/').last.split('.').first;

      // Determine MIME type based on extension
      final mimeType = _getMimeTypeFromExtension(extension);

      // Save the file using file_saver
      final result = await FileSaver.instance.saveFile(
        name: baseName,
        file: file,
        fileExtension: extension,
        includeExtension: includeExtension,
        mimeType: mimeType,
      );

      return result;
    } catch (e) {
      throw Exception('Failed to save file: ${e.toString()}');
    }
  }

  /// Save file from URL using LinkDetails
  ///
  /// [url] - The URL to download from
  /// [fileName] - The name for the saved file
  /// [fileExtension] - The file extension
  /// [mimeType] - The MIME type for the file
  /// [headers] - Optional HTTP headers for the request
  /// [includeExtension] - Whether to include extension in saved filename
  ///
  /// Returns the file path where the file was saved, or null if failed
  Future<String?> saveFromUrl({
    required String url,
    required String fileName,
    required String fileExtension,
    required MimeType mimeType,
    Map<String, String>? headers,
    bool includeExtension = true,
  }) async {
    try {
      // Request storage permission if needed
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Remove extension from fileName if it exists to avoid duplication
      final baseName = fileName.endsWith('.$fileExtension')
          ? fileName.substring(0, fileName.length - fileExtension.length - 1)
          : fileName;

      // Create LinkDetails for the download
      final linkDetails = LinkDetails(
        link: url,
        headers: headers ?? {},
      );

      // Save the file using file_saver
      final result = await FileSaver.instance.saveFile(
        name: baseName,
        link: linkDetails,
        fileExtension: fileExtension,
        includeExtension: includeExtension,
        mimeType: mimeType,
      );

      return result;
    } catch (e) {
      throw Exception('Failed to save file from URL: ${e.toString()}');
    }
  }

  /// Save file with custom MIME type
  ///
  /// [fileBytes] - The file content as bytes
  /// [fileName] - The name of the file
  /// [fileExtension] - The file extension
  /// [customMimeType] - Custom MIME type string
  /// [includeExtension] - Whether to include extension in saved filename
  ///
  /// Returns the file path where the file was saved, or null if failed
  Future<String?> saveWithCustomMimeType({
    required Uint8List fileBytes,
    required String fileName,
    required String fileExtension,
    required String customMimeType,
    bool includeExtension = true,
  }) async {
    try {
      // Request storage permission if needed
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Remove extension from fileName if it exists to avoid duplication
      final baseName = fileName.endsWith('.$fileExtension')
          ? fileName.substring(0, fileName.length - fileExtension.length - 1)
          : fileName;

      // Save the file using file_saver with custom MIME type
      final result = await FileSaver.instance.saveFile(
        name: baseName,
        bytes: fileBytes,
        fileExtension: fileExtension,
        includeExtension: includeExtension,
        mimeType: MimeType.custom,
        customMimeType: customMimeType,
      );

      return result;
    } catch (e) {
      throw Exception(
          'Failed to save file with custom MIME type: ${e.toString()}');
    }
  }

  /// Open save dialog (only available for Android, iOS, macOS & Windows)
  ///
  /// [fileBytes] - The file content as bytes
  /// [fileName] - The name of the file
  /// [fileExtension] - The file extension
  /// [mimeType] - The MIME type for the file
  /// [includeExtension] - Whether to include extension in saved filename
  ///
  /// Returns the file path where the file was saved, or null if failed
  Future<String?> saveAs({
    required Uint8List fileBytes,
    required String fileName,
    required String fileExtension,
    required MimeType mimeType,
    bool includeExtension = true,
  }) async {
    try {
      // Request storage permission if needed
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Remove extension from fileName if it exists to avoid duplication
      final baseName = fileName.endsWith('.$fileExtension')
          ? fileName.substring(0, fileName.length - fileExtension.length - 1)
          : fileName;

      // Use saveAs method (only available on certain platforms)
      final result = await FileSaver.instance.saveAs(
        name: baseName,
        bytes: fileBytes,
        fileExtension: fileExtension,
        includeExtension: includeExtension,
        mimeType: mimeType,
      );

      return result;
    } catch (e) {
      throw Exception('Failed to save file with saveAs: ${e.toString()}');
    }
  }

  /// Request storage permission based on platform and Android version
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 13+ (API level 33+), we don't need WRITE_EXTERNAL_STORAGE
      // For older versions, request the permission
      final androidInfo = await _getAndroidSdkVersion();

      if (androidInfo >= 33) {
        // Android 13+ uses scoped storage, no special permission needed
        return true;
      } else {
        // Android 12 and below
        final status = await Permission.storage.request();
        return status == PermissionStatus.granted;
      }
    } else if (Platform.isIOS) {
      // iOS doesn't require explicit permission for app's Documents directory
      return true;
    } else {
      // Other platforms (Web, Desktop) don't require explicit permissions
      return true;
    }
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

  /// Get appropriate MIME type based on file extension
  MimeType _getMimeTypeFromExtension(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return MimeType.pdf;
      case 'txt':
        return MimeType.text;
      case 'doc':
      case 'docx':
        return MimeType.microsoftWord;
      case 'xls':
      case 'xlsx':
        return MimeType.microsoftExcel;
      case 'ppt':
      case 'pptx':
        return MimeType.microsoftPresentation;
      case 'jpg':
      case 'jpeg':
        return MimeType.jpeg;
      case 'png':
        return MimeType.png;
      case 'gif':
        return MimeType.gif;
      case 'mp3':
        return MimeType.other; // Audio files
      case 'mp4':
      case 'avi':
        return MimeType.other; // Video files
      case 'zip':
        return MimeType.zip;
      case 'json':
        return MimeType.json;
      case 'xml':
        return MimeType.xml;
      case 'csv':
        return MimeType.csv;
      default:
        return MimeType.other;
    }
  }

  /// Check if file exists at given path
  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
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

  /// Get readable file size string (e.g., "1.5 MB")
  String getReadableFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    if (bytes == 0) return '0 B';

    final i = (bytes.bitLength - 1) ~/ 10;
    final size = bytes / (1 << (i * 10));

    return '${size.toStringAsFixed(i == 0 ? 0 : 1)} ${suffixes[i]}';
  }
}
