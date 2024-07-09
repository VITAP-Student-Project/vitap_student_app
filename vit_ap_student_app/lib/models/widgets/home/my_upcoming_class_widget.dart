import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/provider/timetable_provider.dart';

class MyUpcomingClassWidget extends ConsumerStatefulWidget {
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

    if (timetable.isEmpty || !timetable["timetable"].containsKey(day)) {
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
                    frameRate: FrameRate(60), width: 150),
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
    timetable["timetable"].forEach((key, value) {
      if (key == day) {
        value.forEach((time, classInfo) {
          final startTimeString = time.split('-')[0];
          final startTime = DateFormat('HH:mm').parse(startTimeString);

          upcomingClasses.add({
            'day': key,
            'CourseName': classInfo['CourseName'],
            'CourseCode': classInfo['CourseCode'],
            'CourseType': classInfo['CourseType'],
            'Venue': classInfo['Venue'],
            'time': time,
            'startTime': startTime,
          });
        });
      }
    });

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
                scrollPhysics: BouncingScrollPhysics(),
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
            SizedBox(
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
                    width: isSelected ? 55 : 17,
                    height: 10,
                    margin: EdgeInsets.symmetric(
                      horizontal: isSelected ? 6 : 3,
                    ),
                    decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(9)),
                    duration: Duration(milliseconds: 300),
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
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(9)),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 20,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${classInfo['time']}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${classInfo['Venue']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${classInfo['CourseName']} (${classInfo['CourseType']})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${classInfo['CourseCode']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
