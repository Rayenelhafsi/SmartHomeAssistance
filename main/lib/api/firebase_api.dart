import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
