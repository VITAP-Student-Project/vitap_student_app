import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/course_page/model/course_page_detail.dart';

class LectureCard extends StatelessWidget {
  final LectureEntryModel lecture;
  final Function(ReferenceMaterialModel material) onMaterialTap;

  const LectureCard({
    super.key,
    required this.lecture,
    required this.onMaterialTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Iconsax.document,
                          size: 14,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${lecture.referenceMaterials.length}',
                          style: const TextStyle(
                            color: Colors.green,
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
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: lecture.referenceMaterials.map((material) {
                  return InkWell(
                    onTap: () => onMaterialTap(material),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiaryContainer
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.document_download,
                            size: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              material.label,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
