import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> checkForUpdate(BuildContext context, bool needSnackbar) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;
  log(currentVersion);
  DocumentSnapshot latestVersionDoc = await FirebaseFirestore.instance
      .collection('app_version')
      .doc('latest')
      .get();

  String latestVersion = latestVersionDoc['version'];
  String downloadUrl = latestVersionDoc['download_url'];
  String changeLogs =
      latestVersionDoc['change_logs'].toString().replaceAll("\\n", "\n");
  log(changeLogs);
  String changeLogUrl = latestVersionDoc['change_log_url'];

  if (currentVersion != latestVersion) {
    showUpdateDialog(
      context,
      downloadUrl,
      latestVersion,
      changeLogs,
      changeLogUrl,
    );
  }
  if (needSnackbar == true) {
    if (currentVersion == latestVersion) {
      final snackBar = SnackBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        content: Text(
          "You're on the latest version 🤘",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).colorScheme.primary,
          label: 'Close',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

void showUpdateDialog(
  BuildContext context,
  String downloadUrl,
  String latestVersion,
  String changeLogs,
  String changeLogUrl,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Update Available',
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
              'A new version (v$latestVersion) of the app is available. Please update the app for a better experice.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Improvements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              changeLogs,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'For full changelog ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextButton(
                  child: Text(
                    'click here',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.all(0)),
                  ),
                  onPressed: () => launchUrl(Uri.parse(changeLogUrl)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Later'),
          ),
          TextButton(
            onPressed: () {
              // Navigate to the download link
              launchUrl(Uri.parse(downloadUrl));
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}
