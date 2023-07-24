import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';



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
  final androidChannel=const AndroidNotification(

  );
  final localNotification=  FlutterLocalNotificationsPlugin(

  );

  Future<void> initNotification() async {
     await firebasemessaging.requestPermission();
    fcmToken=await firebasemessaging.getToken();
    log("Token : ${fcmToken}");
    initPushNotification();
  }

}
