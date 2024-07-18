import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/models/widgets/timetable/my_semester_dropdown.dart';
import '../pfp_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? selectedSemSubID;
  String? _profileImagePath;
  late String _username = "";
  late String _applicationNumber = "";
  late String _emailID = "";
  late String _dob = "";
  late String _gender = "";
  late String _bloodGroup = "";
  @override
  void initState() {
    super.initState();
    _loadProfileDetails();
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

  Future<void> _loadProfileDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath =
          prefs.getString('pfpPath') ?? 'assets/images/pfp/default.jpg';
      _username = jsonDecode(prefs.getString('profile')!)['student_name'];
      _applicationNumber =
          jsonDecode(prefs.getString('profile')!)['application_number'];
      _emailID = jsonDecode(prefs.getString('profile')!)['email'];
      _dob = jsonDecode(prefs.getString('profile')!)['dob'];
      _gender = jsonDecode(prefs.getString('profile')!)['gender'];
      _bloodGroup = jsonDecode(prefs.getString('profile')!)['blood_group'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Account"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        _profileImagePath ?? 'assets/images/pfp/default.jpg'),
                  ),
                ),
                TextButton(
                  child: Text(
                    "Change avatar",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfilePicScreen(
                                  instructionText:
                                      "Choose a profile picture that best represents you",
                                  nextPage: AccountPage(),
                                )));
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: MySemesterDropDownWidget(
                    onSelected: (value) {
                      setState(() {
                        selectedSemSubID = value;
                      });
                    },
                  ),
                ),
                _buildListTile("Name", _username),
                _buildListTile("Application Number", _applicationNumber),
                _buildListTile("Email", _emailID),
                _buildListTile("Date of birth", _dob),
                _buildListTile("Gender", _gender),
                _buildListTile("Blood group", _bloodGroup),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: MaterialButton(
                    elevation: 0,
                    onPressed: () {},
                    height: 50,
                    minWidth: 150,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 16),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
