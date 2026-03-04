import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/digital_assignment/model/digital_assignment_model.dart';
import 'package:vit_ap_student_app/features/digital_assignment/view/widgets/assignment_tile.dart';
import 'package:vit_ap_student_app/features/digital_assignment/view/widgets/otp_bottom_sheet.dart';
import 'package:vit_ap_student_app/features/digital_assignment/viewmodel/download_assignment_viewmodel.dart';
import 'package:vit_ap_student_app/features/digital_assignment/viewmodel/upload_assignment_viewmodel.dart';

class AssignmentDetailPage extends ConsumerStatefulWidget {
  final DigitalAssignment assignment;

  const AssignmentDetailPage({super.key, required this.assignment});

  @override
  ConsumerState<AssignmentDetailPage> createState() =>
      _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends ConsumerState<AssignmentDetailPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('AssignmentDetailPage');
  }

  String _extractFacultyName(String faculty) {
    // Faculty format: "Shaik Subhani - SCOPE"
    final parts = faculty.split(' - ');
    if (parts.isNotEmpty) {
      return parts[0];
    }
    return faculty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Listen to upload state – handle OTP flow and success/error globally.
    // The OTP dialog handles its own error display (incorrect OTP retry),
    // so we only handle non-OTP errors and success here.
    ref.listen(uploadAssignmentViewModelProvider, (prev, next) {
      next?.when(
        data: (result) {
          final message = result.trim().isNotEmpty
              ? result
              : 'Assignment uploaded successfully';
          showSnackBar(context, message, SnackBarType.success);

          // Pop back to the list page so it auto-refreshes with the
          // updated assignment state.
          if (context.mounted) Navigator.of(context).pop();
        },
        loading: () {},
        error: (error, _) {
          if (error.toString() == 'OTP_REQUIRED') {
            _showOtpDialog(context);
          } else if (error.toString() != 'Incorrect OTP. Please try again.') {
            // Incorrect OTP errors are handled inside the OTP dialog itself.
            showSnackBar(context, error.toString(), SnackBarType.error);
          }
        },
      );
    });

    // Listen to download state
    ref.listen(downloadAssignmentViewModelProvider, (prev, next) {
      next?.when(
        data: (_) {},
        loading: () {},
        error: (error, _) {
          showSnackBar(context, error.toString(), SnackBarType.error);
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.assignment.courseTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Info Header
            _buildCourseHeader(context, theme),
            const SizedBox(height: 12),

            // Upload restrictions note
            _buildUploadNote(context, theme),
            const SizedBox(height: 16),

            // Individual Assignment Tiles
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.assignment.details.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final detail = widget.assignment.details[index];
                return AssignmentTile(
                  detail: detail,
                  classId: widget.assignment.classId,
                  courseCode: widget.assignment.courseCode,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseHeader(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _extractFacultyName(widget.assignment.faculty),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              child: Text(
                widget.assignment.courseCode,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              child: Text(
                widget.assignment.courseType,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUploadNote(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Iconsax.info_circle,
            size: 18,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Guidelines',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\u2022 Max file size: 4 MB\n'
                  '\u2022 Allowed types: PDF, DOC, DOCX, XLS, XLSX',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOtpDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) {
        return OtpBottomSheet(
          assignment: widget.assignment,
          onCancel: () => Navigator.pop(ctx),
        );
      },
    );
  }
}
