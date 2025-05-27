import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/get_classes.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/timetable_empty_state.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/carousel_indicator.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/upcoming_classes/upcoming_classes_card.dart';

class UpcomingClassesCarousel extends ConsumerStatefulWidget {
  const UpcomingClassesCarousel({super.key});

  @override
  ConsumerState<UpcomingClassesCarousel> createState() =>
      _UpcomingClassesCarouselState();
}

class _UpcomingClassesCarouselState
    extends ConsumerState<UpcomingClassesCarousel> {
  int currentPageIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final timetable = user?.timetable.target;
    final day = DateFormat('EEEE').format(DateTime.now());

    if (timetable == null) {
      return const TimetableEmptyState();
    }
    final List<Day> classes = getClassesForDay(timetable, day);

    if (classes.isEmpty) {
      return const TimetableEmptyState(
        primaryText: "No classes found",
        secondaryText: "Seems like a day off 😪",
      );
    }

    final upcomingClasses = _getUpcomingClasses(classes, day);
    if (upcomingClasses.isEmpty) return const TimetableEmptyState();

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: upcomingClasses.length,
          itemBuilder: (context, index, _) {
            final classInfo = upcomingClasses[index];
            final startTimeString = classInfo.courseTime?.split('-')[0].trim();
            final parsedTime = DateFormat('HH:mm').parse(startTimeString ?? "");
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
              ),
              child: Column(
                children: [
                  UpcomingClassCard(
                    classInfo: classInfo,
                    startTime: parsedTime,
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 175,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, _) =>
                setState(() => currentPageIndex = index),
          ),
        ),
        const SizedBox(height: 10),
        CarouselIndicator(
          itemCount: upcomingClasses.length,
          currentIndex: currentPageIndex,
          controller: _carouselController,
        ),
      ],
    );
  }

  List<Day> _getUpcomingClasses(List<Day> classes, String day) {
    final now = DateTime.now();

    return classes.where((classItem) {
      final courseTime = classItem.courseTime;
      if (courseTime == null || courseTime == "Lunch") return false;

      final startTimeString = courseTime.split('-')[0].trim();
      final parsedTime = DateFormat('HH:mm').parse(startTimeString);

      final classStartDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        parsedTime.hour,
        parsedTime.minute,
      );

      return classStartDateTime.isAfter(now);
    }).toList();
  }
}
