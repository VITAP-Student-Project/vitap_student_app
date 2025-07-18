import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/models/grade_history.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/grade_card.dart';

class GradeHistoryPage extends ConsumerStatefulWidget {
  const GradeHistoryPage({super.key});

  @override
  ConsumerState<GradeHistoryPage> createState() => _GradeHistoryPageState();
}

class _GradeHistoryPageState extends ConsumerState<GradeHistoryPage> {
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('GradeHistoryPage');
  }

  List<String> _getUniqueExamMonths(GradeHistory gradeHistory) {
    final months =
        gradeHistory.courses.map((course) => course.examMonth).toSet().toList();
    months.sort();
    return ['All', ...months];
  }

  List<Course> _getFilteredCourses(GradeHistory gradeHistory) {
    if (selectedFilter == 'All') {
      return gradeHistory.courses.toList();
    }
    return gradeHistory.courses
        .where((course) => course.examMonth == selectedFilter)
        .toList();
  }

  Map<String, List<Course>> _groupCoursesByMonth(List<Course> courses) {
    final Map<String, List<Course>> grouped = {};
    for (var course in courses) {
      final month = course.examMonth;
      if (!grouped.containsKey(month)) {
        grouped[month] = [];
      }
      grouped[month]!.add(course);
    }
    return grouped;
  }

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'S':
      case 'A+':
      case 'A':
        return const Color(0xFF4CAF50); // Green for excellent grades
      case 'B+':
      case 'B':
        return const Color(0xFF8BC34A); // Light green for good grades
      case 'C+':
      case 'C':
        return const Color(0xFFFF9800); // Orange for average grades
      case 'D':
        return const Color(0xFFFF5722); // Red-orange for poor grades
      case 'F':
      case 'RA':
        return const Color(0xFFF44336); // Red for failing grades
      case 'W':
      case 'I':
        return const Color(0xFF9E9E9E); // Grey for withdrawn/incomplete
      case 'P':
        return const Color(0xFF2196F3); // Blue for pass
      default:
        return const Color(0xFF607D8B); // Blue-grey for unknown grades
    }
  }

  String _getGradeDescription(String grade) {
    switch (grade.toUpperCase()) {
      case 'S':
        return 'Outstanding';
      case 'A+':
        return 'Excellent+';
      case 'A':
        return 'Excellent';
      case 'B+':
        return 'Very Good+';
      case 'B':
        return 'Very Good';
      case 'C+':
        return 'Good+';
      case 'C':
        return 'Good';
      case 'D':
        return 'Satisfactory';
      case 'F':
        return 'Fail';
      case 'RA':
        return 'Re-appear';
      case 'W':
        return 'Withdrawn';
      case 'I':
        return 'Incomplete';
      case 'P':
        return 'Pass';
      default:
        return grade;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final gradeHistory = user?.profile.target?.gradeHistory.target;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 75,
            backgroundColor: Theme.of(context).colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grade History",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 18,
                              ),
                    ),
                    if (gradeHistory != null && gradeHistory.courses.isNotEmpty)
                      Text(
                        "${_getFilteredCourses(gradeHistory).length} courses",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (user == null)
            SliverFillRemaining(
              child: ErrorContentView(
                error: "User not found!",
              ),
            )
          else if (gradeHistory == null || gradeHistory.courses.isEmpty)
            SliverFillRemaining(
              child: EmptyContentView(
                primaryText: "No grades available",
                secondaryText:
                    "Your grade history will appear here once available.",
              ),
            )
          else ...[
            // Filter chips
            SliverToBoxAdapter(
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _getUniqueExamMonths(gradeHistory).length,
                  itemBuilder: (context, index) {
                    final filter = _getUniqueExamMonths(gradeHistory)[index];
                    final isSelected = selectedFilter == filter;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Grouped courses
            if (selectedFilter == 'All')
              ..._buildGroupedCourses(gradeHistory)
            else
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final courses = _getFilteredCourses(gradeHistory);
                      final course = courses[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: GradeCard(
                          course: course,
                          gradeColor: _getGradeColor(course.grade),
                          gradeDescription: _getGradeDescription(course.grade),
                        ),
                      );
                    },
                    childCount: _getFilteredCourses(gradeHistory).length,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildGroupedCourses(GradeHistory gradeHistory) {
    final groupedCourses = _groupCoursesByMonth(gradeHistory.courses.toList());
    final sortedMonths = groupedCourses.keys.toList()..sort();

    List<Widget> slivers = [];

    for (final month in sortedMonths) {
      final courses = groupedCourses[month]!;

      // Add section header
      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              month,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ),
      );

      // Add courses for this month
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final course = courses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GradeCard(
                    course: course,
                    gradeColor: _getGradeColor(course.grade),
                    gradeDescription: _getGradeDescription(course.grade),
                  ),
                );
              },
              childCount: courses.length,
            ),
          ),
        ),
      );
    }

    return slivers;
  }
}
