import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/course_page/view/pages/lectures_page.dart';
import 'package:vit_ap_student_app/features/course_page/view/widgets/class_entry_card.dart';
import 'package:vit_ap_student_app/features/course_page/viewmodel/course_detail_viewmodel.dart';
import 'package:vit_ap_student_app/features/course_page/viewmodel/slots_viewmodel.dart';

class CourseDetailPage extends ConsumerStatefulWidget {
  final String classId;
  final String courseCode;
  final String courseTitle;

  const CourseDetailPage({
    super.key,
    required this.classId,
    required this.courseCode,
    required this.courseTitle,
  });

  @override
  ConsumerState<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends ConsumerState<CourseDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSlots();
    });
  }

  void _fetchSlots() {
    ref
        .read(slotsViewmodelProvider.notifier)
        .fetchSlots(classId: widget.classId);
  }

  void _onClassEntrySelected(String erpId, String classId, String faculty) {
    // Fetch course detail for selected class entry
    ref.read(courseDetailViewmodelProvider.notifier).fetchCourseDetail(
          erpId: erpId,
          classId: classId,
        );

    // Navigate to lectures page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LecturesPage(
          courseCode: widget.courseCode,
          courseTitle: widget.courseTitle,
          faculty: faculty,
          erpId: erpId,
          classId: classId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slotsState = ref.watch(slotsViewmodelProvider);

    ref.listen(
      slotsViewmodelProvider,
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
        centerTitle: false,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.courseCode,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              widget.courseTitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: _buildBody(slotsState),
    );
  }

  Widget _buildBody(AsyncValue? slotsState) {
    if (slotsState == null) {
      return const Loader();
    }

    return slotsState.when(
      data: (slotsResponse) {
        if (slotsResponse.classEntries.isEmpty) {
          return const EmptyContentView(
            primaryText: "No class entries found",
            secondaryText: "No faculty/slots available for this course",
          );
        }

        return RefreshIndicator(
          onRefresh: () async => _fetchSlots(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Select Faculty/Slot",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: slotsResponse.classEntries.length,
                  itemBuilder: (context, index) {
                    final entry = slotsResponse.classEntries[index];
                    return ClassEntryCard(
                      entry: entry,
                      onTap: () => _onClassEntrySelected(
                        entry.erpId,
                        entry.classId,
                        entry.faculty,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Loader(),
      error: (error, st) => ErrorContentView(
        error: error.toString(),
      ),
    );
  }
}
