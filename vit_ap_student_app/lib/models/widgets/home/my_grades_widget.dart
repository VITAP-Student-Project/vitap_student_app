import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGradesTile extends StatefulWidget {
  const MyGradesTile({super.key});

  @override
  State<MyGradesTile> createState() => _MyGradesTileState();
}

class _MyGradesTileState extends State<MyGradesTile> {
  Map<String, dynamic>? gradesMap;

  @override
  void initState() {
    super.initState();
    fetchGrades();
  }

  void fetchGrades() async {
    final prefs = await SharedPreferences.getInstance();
    final String? profileJson = prefs.getString('profile');

    if (profileJson != null) {
      gradesMap = jsonDecode(profileJson)['grade_history'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    int _creditsEarned = int.parse(gradesMap!['credits_earned'].split(".")[0]);
    int _creditsRegistered =
        int.parse(gradesMap!['credits_registered'].split(".")[0]);
    return Container(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(context).colorScheme.secondary,
            ),
            width: 170,
            height: 125,
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${gradesMap!['cgpa']}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 44,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Overall CGPA earned',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (index == 1)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_creditsEarned',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 44,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Overall credits earned',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (index == 2)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_creditsRegistered',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 44,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Overall credits registered',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
