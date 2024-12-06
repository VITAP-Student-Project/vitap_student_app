import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/provider/student_provider.dart';

class MyMentorPage extends ConsumerWidget {
  const MyMentorPage({super.key});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          dismissDirection: DismissDirection.down,
          width: 400,
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          content: Text(
            '$text Copied to Clipboard! ✂️',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentState = ref.watch(studentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mentor Info"),
      ),
      body: studentState.when(
        data: (data) {
          final mentorDetails = data.profile["mentor_details"] ?? {};
          final String facultyName = mentorDetails["faculty_name"] ?? "N/A";
          final String facultyID = mentorDetails["faculty_id"] ?? "N/A";
          final String facultyDesignation =
              mentorDetails["faculty_designation"] ?? "N/A";
          final String facultyDepartment =
              mentorDetails["faculty_department"] ?? "N/A";
          final String facultyCabin = mentorDetails["cabin"] ?? "N/A";
          final String facultyEmail =
              mentorDetails["faculty_email"]?.contains("protected") ?? false
                  ? "N/A"
                  : mentorDetails["faculty_email"] ?? "N/A";
          final String facultyMobileNo =
              mentorDetails["faculty_mobile_number"] ?? "N/A";

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/pfp/default.png'),
                ),
              ),
              _buildListTile(context, "Name", facultyName),
              _buildListTile(context, "ID", facultyID),
              _buildListTile(context, "Designation", facultyDesignation),
              _buildListTile(context, "Department", facultyDepartment),
              _buildListTile(context, "Cabin", facultyCabin),
              _buildListTile(context, "Email", facultyEmail),
              _buildListTile(context, "Mobile Number", facultyMobileNo),
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              "Error loading mentor details: $error",
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String subtitle) {
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
          onLongPress: () => _copyToClipboard(context, subtitle),
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
