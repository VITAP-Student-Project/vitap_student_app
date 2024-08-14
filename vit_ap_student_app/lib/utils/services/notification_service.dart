import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void backgroundNotificationHandler(NotificationResponse notificationResponse) {
  print(
      'Notification received in the background: ${notificationResponse.payload}');
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    // Initialize Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appstore');

    // Initialize iOS settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    // Combine Android and iOS settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    // Initialize timezone
    tz.initializeTimeZones();

    // Get Notification Permissions
    _getNotificationPermissions();
    // Initialize the plugin with the settings
    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
    );
  }

  _getNotificationPermissions() async {
    // Request notification permission
    PermissionStatus status = await Permission.notification.request();
    Permission.notification.request();

    if (status.isGranted) {
      // If permission is granted, show the notification
      return;
    } else if (status.isDenied) {
      status = await Permission.notification.request();
    }
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Class',
        'Class schedule',
        channelDescription: 'Send upcoming class notification',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'appstore',
        ticker: 'ticker',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

//This method can be implemented anywhere just to check the notification is working or not
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: payload,
    );
  }

  void cancelAllNotifications() {
    notificationPlugin.cancelAll();
    print("All notification schedules are cancelled");
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
  }) async {
    await notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
