import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/utils/file_saver.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/course_page/model/course_page_detail.dart';
import 'package:vit_ap_student_app/features/course_page/view/widgets/download_actions_row.dart';
import 'package:vit_ap_student_app/features/course_page/view/widgets/lecture_card.dart';
import 'package:vit_ap_student_app/features/course_page/viewmodel/course_detail_viewmodel.dart';
import 'package:vit_ap_student_app/features/course_page/viewmodel/material_download_viewmodel.dart';

class LecturesPage extends ConsumerStatefulWidget {
  final String courseCode;
  final String courseTitle;
  final String faculty;
  final String erpId;
  final String classId;

  const LecturesPage({
    super.key,
    required this.courseCode,
    required this.courseTitle,
    required this.faculty,
    required this.erpId,
    required this.classId,
  });

  @override
  ConsumerState<LecturesPage> createState() => _LecturesPageState();
}

class _LecturesPageState extends ConsumerState<LecturesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCourseDetail();
    });
  }

  void _fetchCourseDetail() {
    ref.read(courseDetailViewmodelProvider.notifier).fetchCourseDetail(
          erpId: widget.erpId,
          classId: widget.classId,
        );
  }

  Future<void> _downloadMaterial(String downloadPath, String label) async {
    try {
      final bytes = await ref
          .read(materialDownloadViewmodelProvider.notifier)
          .downloadMaterial(downloadPath: downloadPath);

      if (bytes != null && mounted) {
        final savedPath = await FileSaver.saveAndOpenCourseMaterial(
          bytes: bytes,
          courseCode: widget.courseCode,
          label: label,
        );

        if (savedPath == null && mounted) {
          showSnackBar(context, 'Save cancelled', SnackBarType.warning);
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context,
          'Error downloading material: ${e.toString()}',
          SnackBarType.error,
        );
      }
    }
  }

  Future<void> _downloadAllMaterials(String downloadPath) async {
    try {
      final bytes = await ref
          .read(materialDownloadViewmodelProvider.notifier)
          .downloadAllMaterials(downloadPath: downloadPath);

      if (bytes != null && mounted) {
        final savedPath = await FileSaver.saveAndOpenAllCourseMaterials(
          bytes: bytes,
          courseCode: widget.courseCode,
        );

        if (savedPath == null && mounted) {
          showSnackBar(context, 'Save cancelled', SnackBarType.warning);
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context,
          'Error downloading materials: ${e.toString()}',
          SnackBarType.error,
        );
      }
    }
  }

  Future<void> _downloadSyllabus(String downloadPath) async {
    try {
      // Syllabus uses the same download mechanism as other materials.
      // We use downloadMaterial directly with the parsed syllabusDownloadPath
      // because the Rust download_course_syllabus reconstructs the path using
      // courseType which may be the full name (e.g. "Embedded Theory") instead
      // of the abbreviation ("ETH"), causing a 0KB download.
      final bytes = await ref
          .read(materialDownloadViewmodelProvider.notifier)
          .downloadMaterial(downloadPath: downloadPath);

      if (bytes != null && mounted) {
        final savedPath = await FileSaver.saveAndOpenCourseSyllabus(
          bytes: bytes,
          courseCode: widget.courseCode,
        );

        if (savedPath == null && mounted) {
          showSnackBar(context, 'Save cancelled', SnackBarType.warning);
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context,
          'Error downloading syllabus: ${e.toString()}',
          SnackBarType.error,
        );
      }
    }
  }

  String _extractFacultyName(String faculty) {
    // Faculty format: "70735 - Shaik Subhani - SCOPE"
    final parts = faculty.split(' - ');
    if (parts.length >= 2) {
      return parts[1];
    }
    return faculty;
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(courseDetailViewmodelProvider);
    final downloadState = ref.watch(materialDownloadViewmodelProvider);

    ref.listen(
      courseDetailViewmodelProvider,
      (_, next) {
        next?.whenOrNull(
          error: (error, st) {
            showSnackBar(context, error.toString(), SnackBarType.error);
          },
        );
      },
    );

    ref.listen(
      materialDownloadViewmodelProvider,
      (_, next) {
        next?.whenOrNull(
          error: (error, st) {
            showSnackBar(context, error.toString(), SnackBarType.error);
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.courseTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (downloadState?.isLoading == true)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
        ],
      ),
      body: _buildBody(detailState),
    );
  }

  Widget _buildBody(AsyncValue? detailState) {
    if (detailState == null) {
      return const Loader();
    }

    return detailState.when(
      data: (courseDetail) => _buildContent(courseDetail),
      loading: () => const Loader(),
      error: (error, st) => ErrorContentView(
        error: error.toString(),
      ),
    );
  }

  Widget _buildContent(CoursePageDetailModel courseDetail) {
    final lectures = courseDetail.lectures;
    final facultyName = _extractFacultyName(courseDetail.courseInfo.faculty);

    return RefreshIndicator(
      onRefresh: () async => _fetchCourseDetail(),
      child: CustomScrollView(
        slivers: [
          // Course Info Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facultyName,
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
                          courseDetail.courseInfo.courseCode,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                          courseDetail.courseInfo.courseType,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                          courseDetail.courseInfo.slot,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DownloadActionsRow(
                    onDownloadAll: courseDetail.downloadAllPath != null
                        ? () =>
                            _downloadAllMaterials(courseDetail.downloadAllPath!)
                        : null,
                    onDownloadSyllabus:
                        courseDetail.syllabusDownloadPath != null
                            ? () => _downloadSyllabus(
                                  courseDetail.syllabusDownloadPath!,
                                )
                            : null,
                  ),
                ],
              ),
            ),
          ),
          if (lectures.isEmpty)
            const SliverFillRemaining(
              child: EmptyContentView(
                primaryText: "No lectures found",
                secondaryText: "No lecture schedule available yet",
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final lecture = lectures[index];
                    return LectureCard(
                      lecture: lecture,
                      onMaterialTap: (material) => _downloadMaterial(
                        material.downloadPath,
                        material.label,
                      ),
                    );
                  },
                  childCount: lectures.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
