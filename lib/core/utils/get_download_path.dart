import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Utility function to get the appropriate download directory path based on platform
class DownloadPathUtil {
  /// Get the download directory path for saving files
  ///
  /// Returns the path to the downloads directory where files can be saved
  /// - For Android: Returns the public Downloads directory
  /// - For iOS: Returns the app's documents directory (iOS doesn't have a public downloads folder)
  /// - For other platforms: Returns the downloads directory if available, otherwise documents directory
  static Future<String> getDownloadPath() async {
    try {
      if (Platform.isAndroid) {
        // For Android, get the public Downloads directory
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          // Navigate to the Downloads folder
          // /storage/emulated/0/Android/data/package/files -> /storage/emulated/0/Download
          final List<String> paths = directory.path.split('/');
          final int index = paths.indexOf('Android');
          if (index != -1) {
            paths.removeRange(index, paths.length);
            paths.add('Download');
            final String downloadPath = paths.join('/');

            // Create the directory if it doesn't exist
            final downloadDir = Directory(downloadPath);
            if (!await downloadDir.exists()) {
              await downloadDir.create(recursive: true);
            }

            return downloadPath;
          }
        }

        // Fallback to external storage directory
        return directory?.path ??
            (await getApplicationDocumentsDirectory()).path;
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
