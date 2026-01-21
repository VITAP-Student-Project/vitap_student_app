import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/course_page/model/courses_response.dart';
import 'package:vit_ap_student_app/features/course_page/model/slots_response.dart';
import 'package:vit_ap_student_app/features/course_page/view/pages/lectures_page.dart';
import 'package:vit_ap_student_app/features/course_page/view/widgets/class_entry_card.dart';
import 'package:vit_ap_student_app/features/course_page/viewmodel/courses_viewmodel.dart';
import 'package:vit_ap_student_app/features/course_page/viewmodel/course_detail_viewmodel.dart';
import 'package:vit_ap_student_app/features/course_page/viewmodel/slots_viewmodel.dart';

class CoursePage extends ConsumerStatefulWidget {
  const CoursePage({super.key});

  @override
  ConsumerState<CoursePage> createState() => _CoursePageMainState();
}

class _CoursePageMainState extends ConsumerState<CoursePage> {
  CourseOptionModel? _selectedCourse;
  String? _selectedSlotFilter;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('CoursePageMain');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCourses();
    });
  }

  void _fetchCourses() {
    ref.read(coursesViewmodelProvider.notifier).fetchCourses();
  }

  void _onCourseSelected(CourseOptionModel? course) {
    setState(() {
      _selectedCourse = course;
      _selectedSlotFilter = null; // Reset slot filter when course changes
    });

    if (course != null) {
      ref
          .read(slotsViewmodelProvider.notifier)
          .fetchSlots(classId: course.value);
    }
  }

  void _onSlotFilterSelected(String? slot) {
    setState(() {
      _selectedSlotFilter = slot;
    });
  }

  void _onClassEntrySelected(CourseClassEntryModel entry) {
    if (_selectedCourse == null) return;

    // Fetch course detail for selected class entry
    ref.read(courseDetailViewmodelProvider.notifier).fetchCourseDetail(
          erpId: entry.erpId,
          classId: entry.classId,
        );

    // Navigate to lectures page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LecturesPage(
          courseCode: _selectedCourse!.courseCode,
          courseTitle: _selectedCourse!.courseTitle,
          faculty: entry.faculty,
          erpId: entry.erpId,
          classId: entry.classId,
        ),
      ),
    );
  }

  String _getCourseTypeLabel(String courseType) {
    switch (courseType.toUpperCase()) {
      case 'ETH':
        return 'Theory';
      case 'ELA':
        return 'Lab';
      case 'EPJ':
        return 'Project';
      case 'TH':
        return 'Theory';
      case 'LO':
        return 'Lab';
      default:
        return courseType;
    }
  }

  List<String> _extractUniqueSlots(List<CourseClassEntryModel> entries) {
    final slots = <String>{};
    for (final entry in entries) {
      // Extract individual slots (e.g., "E1+TE1" -> ["E1", "TE1"])
      final slotParts = entry.slot.split('+');
      for (final part in slotParts) {
        final trimmed = part.trim();
        if (trimmed.isNotEmpty) {
          // Extract base slot (e.g., "E1" from "E1", "TE1" -> "E1")
          final baseSlot = trimmed.replaceAll(RegExp(r'^T'), '');
          slots.add(baseSlot);
        }
      }
    }
    // Sort slots naturally (A1, A2, B1, B2, etc.)
    final sortedSlots = slots.toList()..sort();
    return sortedSlots;
  }

  List<CourseClassEntryModel> _filterEntriesBySlot(
      List<CourseClassEntryModel> entries, String? slotFilter) {
    if (slotFilter == null) return entries;
    return entries.where((entry) {
      return entry.slot.contains(slotFilter);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final coursesState = ref.watch(coursesViewmodelProvider);
    final slotsState = ref.watch(slotsViewmodelProvider);

    ref.listen(
      coursesViewmodelProvider,
      (_, next) {
        next?.whenOrNull(
          error: (error, st) {
            showSnackBar(context, error.toString(), SnackBarType.error);
          },
        );
      },
    );

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
        title: Text(
          "Course Page",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        
      ),
      body: _buildBody(coursesState, slotsState),
    );
  }

  Widget _buildBody(AsyncValue? coursesState, AsyncValue? slotsState) {
    if (coursesState == null) {
      return const Loader();
    }

    return coursesState.when(
      data: (coursesResponse) {
        if (coursesResponse.courses.isEmpty) {
          return const EmptyContentView(
            primaryText: "No courses found",
            secondaryText: "No courses available for this semester",
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Dropdown
              _buildCourseDropdown(coursesResponse.courses),

              // Show slots and faculty entries when a course is selected
              if (_selectedCourse != null)
                _buildSlotsSection(slotsState)
              else
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 128),
                        Icon(
                          Iconsax.book_1_copy,
                          size: 64,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Select a course",
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildCourseDropdown(List<CourseOptionModel> courses) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<CourseOptionModel>(
        initialValue: _selectedCourse,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Select Course',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIcon: const Icon(Iconsax.book_copy),
        ),
        hint: const Text('Choose a course'),
        items: courses.map((course) {
          return DropdownMenuItem<CourseOptionModel>(
            value: course,
            child: Text(
              '${course.courseTitle} - ${_getCourseTypeLabel(course.courseType)}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }).toList(),
        onChanged: _onCourseSelected,
      ),
    );
  }

  Widget _buildSlotsSection(AsyncValue? slotsState) {
    if (slotsState == null) {
      return const Loader();
    }

    return slotsState.when(
      data: (slotsResponse) {
        if (slotsResponse.classEntries.isEmpty) {
          return const EmptyContentView(
            primaryText: "No faculty found",
            secondaryText: "No faculty/slots available for this course",
          );
        }

        final uniqueSlots = _extractUniqueSlots(slotsResponse.classEntries);
        final filteredEntries = _filterEntriesBySlot(
            slotsResponse.classEntries, _selectedSlotFilter);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slot Filter Chips
            if (uniqueSlots.isNotEmpty) _buildSlotFilterChips(uniqueSlots),

            // Faculty Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Select Faculty",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),

            // Faculty List
            if (filteredEntries.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Text(
                    'No faculty found for selected slot',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: filteredEntries.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final entry = filteredEntries[index];
                  return ClassEntryCard(
                    entry: entry,
                    onTap: () => _onClassEntrySelected(entry),
                  );
                },
              ),
          ],
        );
      },
      loading: () => const Loader(),
      error: (error, st) => ErrorContentView(
        error: error.toString(),
      ),
    );
  }

  Widget _buildSlotFilterChips(List<String> slots) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
                label: const Text('All'),
                selected: _selectedSlotFilter == null,
                onSelected: (selected) {
                  _onSlotFilterSelected(null);
                },
                selectedColor: Theme.of(context).colorScheme.secondaryContainer,
                checkmarkColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(30),
                )),
          ),
          // Slot chips
          ...slots.map((slot) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(slot),
                selected: _selectedSlotFilter == slot,
                onSelected: (selected) {
                  _onSlotFilterSelected(selected ? slot : null);
                },
                selectedColor: Theme.of(context).colorScheme.secondaryContainer,
                checkmarkColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(30),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
