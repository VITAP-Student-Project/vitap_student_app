import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMsgApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final FcmToken = await _firebaseMessaging.getToken();
    print(FcmToken);
  }
  
}
