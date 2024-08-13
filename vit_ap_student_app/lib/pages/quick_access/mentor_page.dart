import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMentorPage extends StatefulWidget {
  const MyMentorPage({super.key});

  @override
  State<MyMentorPage> createState() => _MyMentorPageState();
}

class _MyMentorPageState extends State<MyMentorPage> {
  late Map mentorDetails = {};
  @override
  void initState() {
    super.initState();
    _loadMentorDetails();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          dismissDirection: DismissDirection.down,
          width: 400,
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          content: Text(
            '$text Copied! Easy peasy! 😊',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      );
    });
  }

  Future<void> _loadMentorDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mentorDetails = jsonDecode(prefs.getString('profile')!)["mentor_details"];
    });
  }

  @override
  Widget build(BuildContext context) {
    String _facultyName = mentorDetails["faculty_name"];
    String _facultyID = mentorDetails["faculty_id"];
    String _facultyDesignation = mentorDetails["faculty_designation"];
    String _facultyDepartment = mentorDetails["faculty_department"];
    String _facultyCabin = mentorDetails["cabin"];
    String _facultyEmail = mentorDetails["faculty_email"];
    String _facultyMobileNo = mentorDetails["faculty_mobile_number"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mentor Info"),
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/pfp/default.png'),
          ),
        ),
        _buildListTile("Name", _facultyName),
        _buildListTile("ID", _facultyID),
        _buildListTile("Designation", _facultyDesignation),
        _buildListTile("Department", _facultyDepartment),
        _buildListTile("Cabin", _facultyCabin),
        _buildListTile("Email", _facultyEmail),
        _buildListTile("Mobile Number", _facultyMobileNo),
      ]),
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width - 16,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 14,
          ),
        ),
        subtitle: GestureDetector(
          onLongPress: () => _copyToClipboard(title),
          child: Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
