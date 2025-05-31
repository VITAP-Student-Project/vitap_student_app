import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();
  Permission.notification.request();

  if (status.isGranted) {
    // If permission is granted, show the notification
    return;
  } else if (status.isDenied) {
    status = await Permission.notification.request();
  }
}
