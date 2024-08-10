import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';
import 'package:vit_ap_student_app/models/widgets/home/my_upcoming_class_widget.dart';
import 'package:vit_ap_student_app/models/widgets/home/my_weather_widget.dart';
import 'package:vit_ap_student_app/models/widgets/home/quick_access.dart';
import '../../models/widgets/home/my_grades_widget.dart';
import '../../models/widgets/home/my_home_appbar.dart';
import '../../utils/services/notification_service.dart';
import '../../utils/services/schedule_notification.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          MyHomeSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Grades
                  // SizedBox(height: 8),
                  // MyGradesTile(),
                  // SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      // Request notification permission
                      PermissionStatus status =
                          await Permission.notification.request();
                      Permission.notification.request();

                      if (status.isGranted) {
                        // If permission is granted, show the notification
                        NotificationService().showNotification(
                          title: "Check",
                          body: "Some beautiful notification",
                          payload: "Payload",
                        );
                      } else if (status.isDenied) {
                        status = await Permission.notification.request();

                        if (status.isGranted) {
                          // If permission is granted on the second request
                          NotificationService().showNotification(
                            title: "Check",
                            body: "Some beautiful notification",
                            payload: "Payload",
                          );
                        } else {
                          print("Notification permission denied again.");
                        }
                      } else if (status.isPermanentlyDenied) {
                        // Handle the case when the permission is permanently denied
                        // Optionally guide the user to the app settings
                        openAppSettings();
                      }

                      // Additional check for location permission if needed
                      if (await Permission.location.isRestricted) {
                        print("Location permission is restricted");
                      }
                    },
                    child: Text("Check Notification"),
                  ),
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
