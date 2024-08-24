import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/utils/provider/providers.dart';

class MyGradesTile extends ConsumerStatefulWidget {
  const MyGradesTile({super.key});

  @override
  MyGradesTileState createState() => MyGradesTileState();
}

class MyGradesTileState extends ConsumerState<MyGradesTile> {
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
    final bool isPrivacyModeEnabled = ref.read(privacyModeProvider);
    if (isPrivacyModeEnabled) {
      return SizedBox(
        height: 0,
      );
    } else if (gradesMap == null) {
      return Center(
        child: CircularProgressIndicator(),
      ); // Show a loading spinner while data is being fetched
    }

    // Ensure gradesMap is not null before accessing its properties
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
