import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/provider/student_provider.dart';

class DeanDetailsPage extends ConsumerStatefulWidget {
  const DeanDetailsPage({super.key});

  @override
  ConsumerState<DeanDetailsPage> createState() => _DeanDetailsPageState();
}

class _DeanDetailsPageState extends ConsumerState<DeanDetailsPage> {
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

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dean"),
      ),
      body: studentState.when(
        data: (student) {
          final deanInfo = student.profile.hodAndDeanInfo;
          Uint8List imageBytes = base64Decode(deanInfo.imageBase64);
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: MemoryImage(imageBytes),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              _buildListTile(
                context,
                "Name",
                deanInfo.title,
              ),
              _buildListTile(
                context,
                "Designation",
                deanInfo.designation,
              ),
              _buildListTile(
                context,
                "Cabin Number",
                deanInfo.cabinNumber,
              ),
              _buildListTile(
                context,
                "Email",
                deanInfo.emailId,
              ),
            ],
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return Text("Error: $error");
        },
        loading: () {
          return CircularProgressIndicator.adaptive();
        },
      ),
    );
  }
}
