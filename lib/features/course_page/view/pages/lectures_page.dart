import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/common/widget/pdf_viewer_screen.dart';
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
    final bytes = await ref
        .read(materialDownloadViewmodelProvider.notifier)
        .downloadMaterial(downloadPath: downloadPath);

    if (bytes != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(
            pdfBytes: bytes,
            title: label,
            fileName: '${widget.courseCode}_$label',
          ),
        ),
      );
    }
  }

  Future<void> _downloadAllMaterials(String downloadPath) async {
    showSnackBar(context, "Feature under development!", SnackBarType.warning);

    // final bytes = await ref
    //     .read(materialDownloadViewmodelProvider.notifier)
    //     .downloadAllMaterials(downloadPath: downloadPath);

    // if (bytes != null && mounted) {
    //   //TODO: For ZIP files, we might want to save directly instead of preview
    // You can extend this to save the file
    // }
  }

  Future<void> _downloadSyllabus(String courseId, String courseType) async {
    showSnackBar(context, "Feature under development!", SnackBarType.warning);

    // TODO: Some error in the pdf page as the expected format for syllabus is .docx
    // final bytes = await ref
    //     .read(materialDownloadViewmodelProvider.notifier)
    //     .downloadSyllabus(courseId: courseId, courseType: courseType);

    // if (bytes != null && mounted) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PdfViewerScreen(
    //         pdfBytes: bytes,
    //         title: "Syllabus - ${widget.courseCode}",
    //         fileName: '${widget.courseCode}_syllabus',
    //       ),
    //     ),
    //   );
    // }
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
                                  courseDetail.courseInfo.courseId,
                                  courseDetail.courseInfo.courseType,
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
