import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> checkForUpdate(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;
  log(currentVersion);
  DocumentSnapshot latestVersionDoc = await FirebaseFirestore.instance
      .collection('app_version')
      .doc('latest')
      .get();

  String latestVersion = latestVersionDoc['version'];
  log(latestVersion);
  String downloadUrl = latestVersionDoc['download_url'];
  log(downloadUrl);
  String changeLogs = latestVersionDoc['change_logs'];
  log(changeLogs);
  String changeLogUrl = latestVersionDoc['change_log_url'];

  if (currentVersion != latestVersion) {
    showUpdateDialog(
        context, downloadUrl, latestVersion, changeLogs, changeLogUrl);
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
        title: Text('Update Available'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'A new version(v$latestVersion) of the app is available. Please update the app for a better experice.',
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Improvements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              changeLogs,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'For full changelog : ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  child: Text(
                    'Click here',
                    style: TextStyle(color: Colors.blue),
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
