import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/provider/student_provider.dart';
import '../../widgets/custom/loading_dialogue_box.dart';
import '../../widgets/timetable/my_semester_dropdown.dart';
import '../onboarding/pfp_page.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  String? newSemSubId;

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Account"),
      ),
      body: SingleChildScrollView(
        child: studentState.when(
          data: (student) {
            final profile = student.profile;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(student.pfpPath),
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
                              newSemSubId = value;
                            });
                          },
                        ),
                      ),
                      _buildListTile("Name", profile.studentName),
                      _buildListTile(
                          "Application Number", profile.applicationNumber),
                      _buildListTile("Email", profile.email),
                      _buildListTile("Date of birth", profile.dob),
                      _buildListTile("Gender", profile.gender),
                      _buildListTile("Blood group", profile.bloodGroup),
                      _buildListTile(
                          "Registration Number", student.registrationNumber),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: () {
                            String? oldSem = student.semSubId;
                            log("$oldSem");
                            if (oldSem != newSemSubId!) {
                              showChangeSemDialog(student.registrationNumber);
                              log("$newSemSubId");
                            }
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
            );
          },
          error: (error, stackTrace) => Center(
            child: Text(
              "Error loading profile: $error",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
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

  void showChangeSemDialog(String regNo) async {
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
          content: Text(
            'It looks like you\'ve recently updated your semester. Would you like to sync the app with the new semester?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Later'),
            ),
            TextButton(
              onPressed: () async {
                await showLoadingDialog(
                    context, "Fetching latest data from VTOP...");
                await ref
                    .read(studentProvider.notifier)
                    .changeStudentSemester(newSemSubId!);

                Navigator.pop(context);
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
          content: Text('$text Copied to Clipboard! ✂️'),
        ),
      );
    });
  }
}
