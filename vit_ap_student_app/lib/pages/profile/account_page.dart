import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/widgets/timetable/my_semester_dropdown.dart';
import '../../widgets/custom/loading_dialogue_box.dart';
import '../../utils/provider/providers.dart';
import '../onboarding/pfp_page.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  String? selectedSemSubID;
  String? _profileImagePath;
  late String _username = "";
  late String _applicationNumber = "";
  late String _emailID = "";
  late String _dob = "";
  late String _gender = "";
  late String _bloodGroup = "";
  String _regNo = '';
  String _sec = '';
  @override
  void initState() {
    super.initState();
    _loadProfileDetails();
  }

  void showChangeSemDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Semester Changed',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'It looks like you\'ve recently updated your semester. Would you like to sync the app with the new semester?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Later'),
            ),
            TextButton(
              onPressed: () async {
                await showLoadingDialog(
                    context, "Fetching latest data from\nVTOP..");
                await ref
                    .read(loginProvider.notifier)
                    .login(_regNo, _sec, selectedSemSubID!, context)
                    .then(
                      (_) {},
                    );

                // final snackBar = SnackBar(
                //   backgroundColor: Theme.of(context).colorScheme.surface,
                //   behavior: SnackBarBehavior.floating,
                //   content: Text(
                //     'Successfully synced with the new semester 🤘',
                //     style: TextStyle(
                //       color: Theme.of(context).colorScheme.primary,
                //     ),
                //   ),
                //   action: SnackBarAction(
                //     textColor: Theme.of(context).colorScheme.primary,
                //     label: 'Close',
                //     onPressed: () {},
                //   ),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Sync'),
            ),
          ],
        );
      },
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          dismissDirection: DismissDirection.down,
          width: 400,
          backgroundColor: Theme.of(context).colorScheme.surface,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          content: Text(
            '$text Copied to Clipboard! ✂️',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          action: SnackBarAction(
            textColor: Theme.of(context).colorScheme.primary,
            label: "X",
            onPressed: () {},
          ),
        ),
      );
    });
  }

  Future<void> _loadProfileDetails() async {
    final prefs = await SharedPreferences.getInstance();
    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    final secStorage = new FlutterSecureStorage(aOptions: _getAndroidOptions());
    String password = await secStorage.read(key: 'password') ?? '';
    setState(() {
      _profileImagePath =
          prefs.getString('pfpPath') ?? 'assets/images/pfp/default.png';
      _username = jsonDecode(prefs.getString('profile')!)['student_name'];
      _applicationNumber =
          jsonDecode(prefs.getString('profile')!)['application_number'];
      _emailID =
          jsonDecode(prefs.getString('profile')!)['email'].contains("protected")
              ? "N/A"
              : "";
      _dob = jsonDecode(prefs.getString('profile')!)['dob'];
      _gender = jsonDecode(prefs.getString('profile')!)['gender'];
      _bloodGroup = jsonDecode(prefs.getString('profile')!)['blood_group'];
      _regNo = prefs.getString('username')!;
      _sec = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          _profileImagePath ?? 'assets/images/pfp/default.png'),
                    ),
                  ),
                  TextButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          type: PageTransitionType.fade,
                          child: const MyProfilePicScreen(
                            instructionText:
                                "Choose a profile picture that best represents you",
                            nextPage: AccountPage(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Change avatar",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        String? oldSem = prefs.getString('semSubID');
                        log("$oldSem");
                        if (oldSem != selectedSemSubID!) {
                          showChangeSemDialog();
                          log("$selectedSemSubID");
                        }
                        await prefs.setString('semSubID', selectedSemSubID!);
                      },
                      height: 50,
                      minWidth: 150,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      textColor: Colors.blue,
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
