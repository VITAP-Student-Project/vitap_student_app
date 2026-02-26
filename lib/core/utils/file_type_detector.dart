import 'dart:convert';
import 'dart:typed_data';

/// Detects file type from magic bytes (file signature).
///
/// Since the VTOP download API does not provide content-type headers
/// and the download path always uses "downloadPdf/" regardless of
/// actual file type, we detect the format from the file's magic bytes.
class FileTypeDetector {
  /// Detects the file extension from the given bytes.
  ///
  /// Returns the file extension (without dot) e.g., "pdf", "pptx", "docx".
  /// Returns "bin" if the file type cannot be determined.
  static String detectExtension(Uint8List bytes) {
    if (bytes.length < 4) return 'bin';

    // PDF: %PDF (25 50 44 46)
    if (_startsWith(bytes, [0x25, 0x50, 0x44, 0x46])) {
      return 'pdf';
    }

    // ZIP-based formats: PK\x03\x04 (50 4B 03 04)
    // This includes .zip, .docx, .pptx, .xlsx
    if (_startsWith(bytes, [0x50, 0x4B, 0x03, 0x04])) {
      return _detectZipBasedFormat(bytes);
    }

    // Old Microsoft Office compound document: D0 CF 11 E0
    if (_startsWith(bytes, [0xD0, 0xCF, 0x11, 0xE0])) {
      return _detectOldOfficeFormat(bytes);
    }

    // PNG: 89 50 4E 47
    if (_startsWith(bytes, [0x89, 0x50, 0x4E, 0x47])) {
      return 'png';
    }

    // JPEG: FF D8 FF
    if (bytes.length >= 3 &&
        bytes[0] == 0xFF &&
        bytes[1] == 0xD8 &&
        bytes[2] == 0xFF) {
      return 'jpg';
    }

    // GIF: GIF87a or GIF89a
    if (_startsWith(bytes, [0x47, 0x49, 0x46, 0x38])) {
      return 'gif';
    }

    // MP4: ftyp at offset 4
    if (bytes.length >= 8 && _containsAt(bytes, 4, [0x66, 0x74, 0x79, 0x70])) {
      return 'mp4';
    }

    // Plain text check (if mostly printable ASCII)
    if (_looksLikeText(bytes)) {
      return 'txt';
    }

    return 'bin';
  }

  /// Returns the MIME type for a given file extension.
  static String getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'doc':
        return 'application/msword';
      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case 'ppt':
        return 'application/vnd.ms-powerpoint';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'zip':
        return 'application/zip';
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'mp4':
        return 'video/mp4';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }

  /// Detects the specific format of a ZIP-based file.
  ///
  /// Modern Office formats (.docx, .pptx, .xlsx) are ZIP archives
  /// containing specific directory structures.
  static String _detectZipBasedFormat(Uint8List bytes) {
    final content = _tryDecodeAsciiSegments(bytes);

    // DOCX: contains "word/document.xml" or "word/"
    if (content.contains('word/')) {
      return 'docx';
    }

    // PPTX: contains "ppt/presentation.xml" or "ppt/"
    if (content.contains('ppt/')) {
      return 'pptx';
    }

    // XLSX: contains "xl/workbook.xml" or "xl/"
    if (content.contains('xl/')) {
      return 'xlsx';
    }

    // Generic ZIP file
    return 'zip';
  }

  /// Detects old Microsoft Office format from compound document bytes.
  ///
  /// These use the OLE2 Compound Document format.
  static String _detectOldOfficeFormat(Uint8List bytes) {
    final content = _tryDecodeAsciiSegments(bytes);

    if (content.contains('PowerPoint') ||
        content.contains('P\x00o\x00w\x00e\x00r\x00P\x00o\x00i\x00n\x00t')) {
      return 'ppt';
    }

    if (content.contains('Microsoft Excel') || content.contains('Workbook')) {
      return 'xls';
    }

    if (content.contains('Microsoft Word') ||
        content.contains('W\x00o\x00r\x00d')) {
      return 'doc';
    }

    // Default to doc for old Office format
    return 'doc';
  }

  static bool _startsWith(Uint8List bytes, List<int> signature) {
    if (bytes.length < signature.length) return false;
    for (var i = 0; i < signature.length; i++) {
      if (bytes[i] != signature[i]) return false;
    }
    return true;
  }

  static bool _containsAt(Uint8List bytes, int offset, List<int> signature) {
    if (bytes.length < offset + signature.length) return false;
    for (var i = 0; i < signature.length; i++) {
      if (bytes[offset + i] != signature[i]) return false;
    }
    return true;
  }

  /// Scans the bytes for ASCII directory name patterns.
  ///
  /// This avoids the overhead of a full ZIP parse by simply scanning
  /// the raw bytes for known directory names in the ZIP local file headers.
  static String _tryDecodeAsciiSegments(Uint8List bytes) {
    // Only scan a reasonable portion of the file (first 20KB should contain the structure)
    final scanLength = bytes.length < 20480 ? bytes.length : 20480;
    final segment = bytes.sublist(0, scanLength);

    try {
      return ascii.decode(segment, allowInvalid: true);
    } catch (_) {
      return '';
    }
  }

  /// Checks if the bytes look like plain text.
  static bool _looksLikeText(Uint8List bytes) {
    final checkLength = bytes.length < 512 ? bytes.length : 512;
    var printableCount = 0;

    for (var i = 0; i < checkLength; i++) {
      final b = bytes[i];
      if ((b >= 0x20 && b <= 0x7E) || b == 0x0A || b == 0x0D || b == 0x09) {
        printableCount++;
      }
    }

    return printableCount / checkLength > 0.85;
  }
}
