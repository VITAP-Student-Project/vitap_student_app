import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/services/file_storage_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

class PdfViewerScreen extends StatefulWidget {
  final Uint8List pdfBytes;
  final String title;
  final String fileName;

  const PdfViewerScreen({
    super.key,
    required this.pdfBytes,
    required this.title,
    required this.fileName,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool _isDownloading = false;

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  Future<void> _downloadPdf() async {
    if (_isDownloading) return;

    setState(() {
      _isDownloading = true;
    });

    try {
      final fileStorageService = serviceLocator<FileStorageService>();
      final filePath = await fileStorageService.savePdfToDownloads(
        pdfBytes: widget.pdfBytes,
        fileName: widget.fileName,
      );

      if (filePath != null && mounted) {
        showSnackBar(
          context,
          'PDF downloaded successfully',
          SnackBarType.success,
        );
      } else if (mounted) {
        showSnackBar(
          context,
          'Failed to download PDF',
          SnackBarType.error,
        );
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context,
          'Download failed: ${e.toString()}',
          SnackBarType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: _isDownloading ? null : _downloadPdf,
            icon: _isDownloading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Iconsax.document_download),
            tooltip: 'Download PDF',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SfPdfViewer.memory(
        widget.pdfBytes,
        controller: _pdfViewerController,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          showSnackBar(
            context,
            'Failed to load PDF: ${details.error}',
            SnackBarType.error,
          );
        },
      ),
    );
  }
}
