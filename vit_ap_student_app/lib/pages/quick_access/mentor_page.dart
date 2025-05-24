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
          final mentorDetails = data.profile.mentorDetails;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/pfp/default.png'),
                ),
              ),
              _buildListTile(
                context,
                "Name",
                mentorDetails.facultyName,
              ),
              _buildListTile(
                context,
                "ID",
                mentorDetails.facultyId,
              ),
              _buildListTile(
                context,
                "Designation",
                mentorDetails.facultyDesignation,
              ),
              _buildListTile(
                context,
                "Department",
                mentorDetails.facultyDepartment,
              ),
              _buildListTile(
                context,
                "Cabin",
                mentorDetails.cabin,
              ),
              _buildListTile(
                context,
                "Email",
                mentorDetails.facultyEmail,
              ),
              _buildListTile(
                context,
                "Mobile Number",
                mentorDetails.facultyMobileNumber,
              ),
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
