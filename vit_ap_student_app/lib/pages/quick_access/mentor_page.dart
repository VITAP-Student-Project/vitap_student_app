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
  Map _mentor_details = {};
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
          shape: RoundedRectangleBorder(
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
      _mentor_details =
          jsonDecode(prefs.getString('profile')!)["mentor_details"];
    });
  }

  @override
  Widget build(BuildContext context) {
    String _facultyName = _mentor_details["faculty_name"];
    String _facultyID = _mentor_details["faculty_id"];
    String _facultyDesignation = _mentor_details["faculty_designation"];
    String _facultyDepartment = _mentor_details["faculty_department"];
    String _facultyCabin = _mentor_details["cabin"];
    String _facultyEmail = _mentor_details["faculty_email"];
    String _facultyMobileNo = _mentor_details["faculty_mobile_number"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Mentor Info"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/pfp/default.jpg'),
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
    return Container(
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
          onTap: () => _copyToClipboard(title),
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
