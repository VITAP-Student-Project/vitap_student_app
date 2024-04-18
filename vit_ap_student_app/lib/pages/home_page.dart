import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/utils/text_turncation.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, String>> apiData = [
    {
      "Time": "9 : 00 - 9 : 50",
      "Course": "Object Oriented Programming",
      "Venue": "420-AB1"
    },
    {
      "Time": "10 : 00 - 10 : 50",
      "Course": "Data Structures and Algorithms",
      "Venue": "320-CD2"
    },
    {
      "Time": "11 : 00 - 11 : 50",
      "Course": "Introduction to Quantitative, Logical and Verbal Ability",
      "Venue": "510-EF3"
    },
    // Add more sets of data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile_image.jpg'),
            ),
            SizedBox(width: 10), // Add space between the avatar and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Text(
                  'Udhay Adithya',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upcoming Classes,',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              // Displaying API data dynamically inside a row with horizontal scroll
              SizedBox(
                height: 120, // Set the height of the row
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: apiData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                          right: 10), // Add margin between boxes
                      constraints: BoxConstraints(
                        maxWidth: 170, // Set max width for the container
                        minHeight: 150,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:
                            Color.fromRGBO(209, 228, 255, 1), // Set box color
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: apiData[index]
                            .entries
                            .map(
                              (entry) => Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(
                                  truncateText(entry.value, 30),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(2, 98, 165, 1),
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}