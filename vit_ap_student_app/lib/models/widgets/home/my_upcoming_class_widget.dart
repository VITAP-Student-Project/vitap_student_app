import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/provider/timetable_provider.dart';
import '../../../utils/text_newline.dart';

class MyUpcomingClassWidget extends ConsumerStatefulWidget {
  const MyUpcomingClassWidget({super.key});

  @override
  _MyUpcomingClassWidgetState createState() => _MyUpcomingClassWidgetState();
}

class _MyUpcomingClassWidgetState extends ConsumerState<MyUpcomingClassWidget> {
  int currentPageIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String day =
        DateFormat('EEEE').format(now); // Get the current day of the week
    final timetable = ref.watch(timetableProvider);

    if (timetable.isEmpty || !timetable.containsKey(day)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(9),
          ),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset("assets/images/lottie/cat_sleep.json",
                    frameRate: const FrameRate(60), width: 150),
                Text(
                  'No classes found',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Text(
                  'Seems like a day off 😪',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    List<Map<String, dynamic>> upcomingClasses = [];

    // Collect upcoming classes
    final data = timetable[day] as List<dynamic>; // Cast to List<dynamic>

    for (var classItem in data) {
      final classMap = classItem as Map<String, dynamic>;
      classMap.forEach((time, classInfo) {
        final startTimeString = time.split('-')[0];
        final startTime = DateFormat('HH:mm').parse(startTimeString);

        upcomingClasses.add({
          'day': day,
          'CourseName': classInfo['course_name'],
          'CourseCode': classInfo['course_code'],
          'CourseType': classInfo['course_type'],
          'Venue': classInfo['venue'],
          'time': time,
          'startTime': startTime,
        });
      });
    }

    // Sort classes by time
    upcomingClasses.sort((a, b) => a['startTime'].compareTo(b['startTime']));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: upcomingClasses.length,
              itemBuilder: (context, index, realIndex) {
                final classInfo = upcomingClasses[index];
                return _buildClassCard(classInfo, context);
              },
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlayCurve: Curves.fastOutSlowIn,
                height: 175,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                initialPage: 0,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(upcomingClasses.length, (index) {
                bool isSelected = currentPageIndex == index;
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                  },
                  child: AnimatedContainer(
                    width: isSelected ? 30 : 15,
                    height: 10,
                    margin: EdgeInsets.symmetric(
                      horizontal: isSelected ? 6 : 3,
                    ),
                    decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(9)),
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classInfo, BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startTime = classInfo['startTime'];
    DateTime endTime = startTime.add(Duration(minutes: 50));

    String status;
    Color statusColor;

    if (now.isBefore(startTime)) {
      status = 'Upcoming';
      statusColor = Colors.blue;
    } else if (now.isAfter(endTime)) {
      status = 'Completed';
      statusColor = Colors.green;
    } else {
      status = 'Ongoing';
      statusColor = Colors.orange;
    }

    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(9)),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${classInfo['time']}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: statusColor,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.2),
                            borderRadius: BorderRadius.circular(9)),
                        child: Center(
                          child: Text(
                            status,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${addNewlines(classInfo['CourseName'], 30)} (${classInfo['CourseType']})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${classInfo['CourseCode']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 1,
                ),
                Text(
                  '${classInfo['Venue']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
