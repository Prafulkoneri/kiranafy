import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/shop_owner/notification/view/notification_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

Future<void> handleBackGroundMessage(RemoteMessage message) async {
  print("Title : ${message.notification?.title}");
  print("Body : ${message.notification?.body}");
  print("Payload : ${message.data}");
}

class FireBaseApi {
  final firebasemessaging = FirebaseMessaging.instance;
  final androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notification',
      description: 'this channel is used for important notification',
      importance: Importance.defaultImportance);
  final _localNotification = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // navigatorKey.currentState?.pushNamed(NotificationsScreen.route, arguments:
    // message);
  }

  ///

  Future initLocalNotifications() async {
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotification.initialize(settings,
        onSelectNotification: (payload) {
      final message = RemoteMessage.fromMap(
        jsonDecode(payload!),
      );
      handleMessage(message);
    });
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }

  ///////////////////
  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((handleBackGroundMessage) {});
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackGroundMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  androidChannel.id, androidChannel.name,
                  channelDescription: androidChannel.description,
                  icon: '@drawable/ic_launcher')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotification() async {
    await firebasemessaging.requestPermission();
    fcmToken = await firebasemessaging.getToken();
    log("Token : ${fcmToken}");
    initPushNotification();
    initLocalNotifications();
  }
}
