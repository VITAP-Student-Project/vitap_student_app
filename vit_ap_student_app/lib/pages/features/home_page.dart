import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/models/widgets/home/my_upcoming_class_widget.dart';
import 'package:vit_ap_student_app/models/widgets/home/my_weather_widget.dart';
import 'package:vit_ap_student_app/models/widgets/home/quick_access.dart';
import '../../models/widgets/home/my_home_appbar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          MyHomeSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today's Schedule
                  Row(
                    children: [
                      Lottie.asset(
                        "assets/images/lottie/schedule.json",
                        frameRate: FrameRate(60),
                        width: 36,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Today\'s Schedule',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  MyUpcomingClassWidget(),

                  // Weather Text
                  Row(
                    children: [
                      Lottie.asset(
                        "assets/weather_icons/umbrella.json",
                        frameRate: FrameRate(60),
                        width: 48,
                      ),
                      const Text(
                        'Weather',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Weather Widget
                  MyWeatherWidget(),
                  SizedBox(height: 10),

                  // Quick access
                  Stack(
                    children: [
                      Positioned(
                        top: -5,
                        left: -16,
                        child: Lottie.asset(
                          "assets/images/lottie/cards.json",
                          frameRate: FrameRate(60),
                          width: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0),
                        child: Text(
                          'Quick access',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  MyQuickAccess(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
