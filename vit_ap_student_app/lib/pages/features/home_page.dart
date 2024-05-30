import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/models/widgets/my_home_appbar.dart';
import 'package:vit_ap_student_app/models/widgets/my_upcoming_class_widget.dart';
import 'package:vit_ap_student_app/models/widgets/my_weather_widget.dart';
import 'package:vit_ap_student_app/models/widgets/quick_access.dart';
import '../../models/widgets/my_swipeable_cards.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: MyHomeAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Schedule',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Next class,',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyUpcomingClassWidget(),
              Text(
                'Weather',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyWeatherWidget(),
              Text(
                'Quick access',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyQuickAccess(),
              Container(height: 5000, child: SwipeableCards()),
            ],
          ),
        ),
      ),
    );
  }
}
