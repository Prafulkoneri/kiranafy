import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_supper_market/main.dart';

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
  @pragma('vm:entry-point')
  void handleMessage(RemoteMessage? message) {

    if (message == null) return;
    // navigatorKey.currentState?.pushNamed(NotificationsScreen.route, arguments:
    // message);
  }

  ///

  Future initLocalNotifications() async {
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
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
      @pragma('vm:entry-point')
      final notification = message.notification;
      if (notification == null) return;
      // _showNotification();
      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  androidChannel.id, androidChannel.name,
                  channelDescription: androidChannel.description,
                  icon: '@mipmap/ic_launcher')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotification() async {
    await firebasemessaging.requestPermission();
    fcmToken = await firebasemessaging.getToken();
    log("Token : ${fcmToken}");
    initPushNotification();
    initLocalNotifications();
    // initPushNotifications();
  }
}
