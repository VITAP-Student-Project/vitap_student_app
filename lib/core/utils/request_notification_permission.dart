import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
    return;
  } else if (status.isDenied) {
    status = await Permission.notification.request();
  }
}
