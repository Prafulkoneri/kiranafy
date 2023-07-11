import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_supper_market/main.dart';

Future<void> handleBackGroundMessage(RemoteMessage message)async{
  print("Title : ${message.notification?.title}");
  print("Body : ${message.notification?.body}");
  print("Payload : ${message.data}");
}

Future<void> initPushNotification()async{
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.getInitialMessage().then((handleBackGroundMessage){});
  FirebaseMessaging.onMessageOpenedApp.listen(handleBackGroundMessage);
  FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
}

class FireBaseApi {
  final firebasemessaging = FirebaseMessaging.instance;

  final androidChannel=const AndroidNotification();
  final localNotification=  FlutterLocalNotificationsPlugin(

  );

  Future<void> initNotification() async {
    await firebasemessaging.requestPermission();
    fcmToken=await firebasemessaging.getToken();
    print("Token : ${fcmToken}");
    initPushNotification();
  }

}
