import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/course_page/model/course_page_detail.dart';

class LectureCard extends StatelessWidget {
  final LectureEntryModel lecture;
  final void Function(ReferenceMaterialModel material) onMaterialView;
  final void Function(ReferenceMaterialModel material) onMaterialDownload;

  /// Download path of the material currently being fetched, if any. Its row
  /// shows a spinner and every material row is disabled while one is in flight.
  ///
  /// Keyed on the path rather than the label because VTOP reuses labels
  /// ("Module 1") across lectures, and matching on those spins every row that
  /// happens to share a name.
  final String? busyMaterialPath;

  const LectureCard({
    super.key,
    required this.lecture,
    required this.onMaterialView,
    required this.onMaterialDownload,
    this.busyMaterialPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lecture.formattedDate.isNotEmpty
                            ? lecture.formattedDate
                            : lecture.date,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        lecture.day,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (lecture.hasMaterials)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.document,
                          size: 14,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${lecture.referenceMaterials.length}',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondaryContainer,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (lecture.topic.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                lecture.topic,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                ),
              ),
            ],
            if (lecture.hasMaterials) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 4),
              for (final material in lecture.referenceMaterials)
                _MaterialRow(
                  material: material,
                  busy: busyMaterialPath == material.downloadPath,
                  enabled: busyMaterialPath == null,
                  onView: () => onMaterialView(material),
                  onDownload: () => onMaterialDownload(material),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

/// One reference material: its name, and the two things you can do with it.
///
/// View opens the file without saving anything; Download puts it through the
/// system save dialog.
class _MaterialRow extends StatelessWidget {
  const _MaterialRow({
    required this.material,
    required this.busy,
    required this.enabled,
    required this.onView,
    required this.onDownload,
  });

  final ReferenceMaterialModel material;
  final bool busy;
  final bool enabled;
  final VoidCallback onView;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: busy
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.secondary,
              ),
            )
          : Icon(Iconsax.document, size: 20, color: colors.secondary),
      title: Text(
        material.label,
        style: TextStyle(
          color: colors.onSurface,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: enabled ? onView : null,
            icon: const Icon(Iconsax.eye, size: 20),
            color: colors.onSurfaceVariant,
            tooltip: 'View',
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            onPressed: enabled ? onDownload : null,
            icon: const Icon(Iconsax.document_download, size: 20),
            color: colors.onSurfaceVariant,
            tooltip: 'Download',
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
