import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Utility function to get the appropriate download directory path based on platform
class DownloadPathUtil {
  /// Get the download directory path for saving files
  ///
  /// Returns the path to the downloads directory where files can be saved
  /// - For Android: Returns app's external storage directory (works without permissions on Android 10+)
  /// - For iOS: Returns the app's documents directory (iOS doesn't have a public downloads folder)
  /// - For other platforms: Returns the downloads directory if available, otherwise documents directory
  static Future<String> getDownloadPath() async {
    try {
      if (Platform.isAndroid) {
        // For Android 10+ (API 29+), we cannot directly write to public Downloads folder
        // due to scoped storage restrictions. Use app's external storage directory instead.
        // Files will be saved to: /storage/emulated/0/Android/data/<package>/files/Downloads

        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          // Create a Downloads subfolder within app's external storage
          final downloadPath = '${directory.path}/Downloads';
          final downloadDir = Directory(downloadPath);

          if (!await downloadDir.exists()) {
            await downloadDir.create(recursive: true);
          }

          return downloadPath;
        }

        // Fallback to application documents directory
        final documentsDir = await getApplicationDocumentsDirectory();
        final downloadPath = '${documentsDir.path}/Downloads';
        final downloadDir = Directory(downloadPath);

        if (!await downloadDir.exists()) {
          await downloadDir.create(recursive: true);
        }

        return downloadPath;
      } else if (Platform.isIOS) {
        // For iOS, use the application documents directory
        // iOS doesn't have a public downloads folder accessible to third-party apps
        final directory = await getApplicationDocumentsDirectory();
        return directory.path;
      } else {
        // For other platforms (Desktop), try to get downloads directory
        final directory = await getDownloadsDirectory();
        if (directory != null) {
          return directory.path;
        }

        // Fallback to documents directory
        final documentsDirectory = await getApplicationDocumentsDirectory();
        return documentsDirectory.path;
      }
    } catch (e) {
      // If all else fails, use the application documents directory
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  /// Get the temporary directory path
  /// Useful for temporary file storage before moving to downloads
  static Future<String> getTempPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  /// Get the application documents directory path
  static Future<String> getDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
