import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

    // Initialize the plugin with the settings
    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );

    // Create the notification channel for Android
    await _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'classes', // Channel ID
      'upcomingClasses', // Channel Name
      description: 'Some cute desc', // Channel Description
      importance: Importance.max, // Importance level
    );

    // Create the channel on the device
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Class',
        'Class Schedule',
        channelDescription: 'Some cute desc',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'appstore',
        ticker: 'ticker',
        styleInformation:
            InboxStyleInformation(['Style text 1', 'Style text 2']),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

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
}
