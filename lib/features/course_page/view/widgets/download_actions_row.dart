import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DownloadActionsRow extends StatelessWidget {
  final VoidCallback? onDownloadAll;
  final VoidCallback? onDownloadSyllabus;

  const DownloadActionsRow({
    super.key,
    this.onDownloadAll,
    this.onDownloadSyllabus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onDownloadSyllabus != null)
          Expanded(
            child: _buildActionButton(
              context,
              icon: Iconsax.document_text,
              label: "Syllabus",
              onTap: onDownloadSyllabus!,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        if (onDownloadSyllabus != null && onDownloadAll != null)
          const SizedBox(width: 12),
        if (onDownloadAll != null)
          Expanded(
            child: _buildActionButton(
              context,
              icon: Iconsax.folder_2,
              label: "Download All",
              onTap: onDownloadAll!,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withOpacity(0.5)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
