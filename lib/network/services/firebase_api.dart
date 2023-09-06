// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_supper_market/main.dart';
// import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
// import 'package:local_supper_market/screen/shop_owner/notification/view/notification_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

// Future<void> handleBackGroundMessage(RemoteMessage message) async {
//   print("Title : ${message.notification?.title}");
//   print("Body : ${message.notification?.body}");
//   print("Payload : ${message.data}");
// }

// class FireBaseApi {
//   final firebasemessaging = FirebaseMessaging.instance;
//   final androidChannel = const AndroidNotificationChannel(
//       'high_importance_channel', 'High Importance Notification',
//       description: 'this channel is used for important notification',
//       importance: Importance.defaultImportance);
//   final _localNotification = FlutterLocalNotificationsPlugin();
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     // navigatorKey.currentState?.pushNamed(NotificationsScreen.route, arguments:
//     // message);
//   }

//   ///

//   Future initLocalNotifications() async {
//     const iOS = IOSInitializationSettings();
//     const android = AndroidInitializationSettings('@drawable/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: iOS);
//     await _localNotification.initialize(settings,
//         onSelectNotification: (payload) {
//           final message = RemoteMessage.fromMap(
//             jsonDecode(payload!),
//           );
//           handleMessage(message);
//         });
//     final platform = _localNotification.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(androidChannel);
//   }

//   ///////////////////
//   Future<void> initPushNotification() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((handleBackGroundMessage) {});
//     FirebaseMessaging.onMessageOpenedApp.listen(handleBackGroundMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;
//       // _showNotification();
//       _localNotification.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//               android: AndroidNotificationDetails(
//                   androidChannel.id, androidChannel.name,
//                   channelDescription: androidChannel.description,
//                   icon: '@drawable/ic_launcher')),
//           payload: jsonEncode(message.toMap()));
//     });
//   }

//   // Future<void> _showNotification() async {
//   //   final android = AndroidNotificationDetails('0', 'Adun Accounts',
//   //       channelDescription: 'channel description',
//   //       importance: Importance.max,
//   //       icon: '');
//   //   final iOS = IOSNotificationDetails();
//   //   final platform = NotificationDetails(android: android, iOS: iOS);
//   //   FirebaseMessaging.onMessage.listen((message) async {
//   //     final notification = message.notification;
//   //     if (notification == null) return;
//   //     await flutterLocalNotificationsPlugin.show(
//   //         0, // notification id
//   //         "vdddfsn",
//   //         'Download complete.',
//   //         platform,
//   //         payload: '');
//   //     // _showNotification();
//   //     // await flutterLocalNotificationsPlugin.show(notification.hashCode,
//   //     //     notification.title, notification.body, platform,
//   //     //     // NotificationDetails(
//   //     //     //     android: AndroidNotificationDetails(
//   //     //     //         androidChannel.id, androidChannel.name,
//   //     //     //         channelDescription: androidChannel.description,
//   //     //     //         icon: '@drawable/ic_launcher')),
//   //     //     payload: jsonEncode(message.toMap()));
//   //   });
//   //   // await flutterLocalNotificationsPlugin.show(
//   //   //     0, // notification id
//   //   //     "${fileName}",
//   //   //     'Download complete.',
//   //   //     platform,
//   //   //     payload: '$savePath');
//   // }

//   //////////////////////////////////////
//   // Future<void> initPushNotifications() async {
//   //   await FirebaseMessaging.instance
//   //       .setForegroundNotificationPresentationOptions(
//   //     alert: true,
//   //     badge: true,
//   //     sound: true,
//   //   );
//   //   FirebaseMessaging.instance
//   //       .getInitialMessage()
//   //       .then((handleForegroundMessage) {});
//   //   FirebaseMessaging.onMessageOpenedApp.listen(handleForegroundMessage);
//   //   FirebaseMessaging.onBackgroundMessage(handleForegroundMessage);
//   //   FirebaseMessaging.onMessage.listen((message) {
//   //     final notification = message.notification;
//   //     if (notification == null) return;
//   //     _localNotification.show(
//   //         notification.hashCode,
//   //         notification.title,
//   //         notification.body,
//   //         NotificationDetails(
//   //             android: AndroidNotificationDetails(
//   //                 androidChannel.id, androidChannel.name,
//   //                 channelDescription: androidChannel.description,
//   //                 icon: '@drawable/ic_launcher')),
//   //         payload: jsonEncode(message.toMap()));
//   //   });
//   // }

//   Future<void> initNotification() async {
//     await firebasemessaging.requestPermission();
//     fcmToken = await firebasemessaging.getToken();
//     log("Token : ${fcmToken}");
//     initPushNotification();
//     initLocalNotifications();
//     // initPushNotifications();
//   }
// }

// //////////////////////////////////
// // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
// // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// //   @override
// //   void initState() {
// // var initializationSettingsAndroid =
// //         new AndroidInitializationSettings('@mipmap/ic_launcher');
// //     var initializationSettingsIOS = new IOSInitializationSettings();
// //     var initializationSettings = new InitializationSettings(
// //         initializationSettingsAndroid, initializationSettingsIOS);
// //     flutterLocalNotificationsPlugin.initialize(initializationSettings,
// //         onSelectNotification: onSelectNotification);
// //     _firebaseMessaging.configure(
// //       onMessage: (Map<String, dynamic> message) async {
// //         showNotification(
// //             message['notification']['title'], message['notification']['body']);
// //         print("onMessage: $message");
// //       },
// //       onLaunch: (Map<String, dynamic> message) async {
// //         print("onLaunch: $message");
// //         Navigator.pushNamed(context, '/notify');
// //       },
// //       onResume: (Map<String, dynamic> message) async {
// //         print("onResume: $message");
// //       },
// //     );
// // }
// // Future onSelectNotification(String payload) async {
// //     showDialog(
// //       context: context,
// //       builder: (_) {
// //         return new AlertDialog(
// //           title: Text("PayLoad"),
// //           content: Text("Payload : $payload"),
// //         );
// //       },
// //     );
// //   }
// // void showNotification(String title, String body) async {
// //     await _demoNotification(title, body);
// //   }

// //   Future<void> _demoNotification(String title, String body) async {
// //     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
// //         'channel_ID', 'channel name', 'channel description',
// //         importance: Importance.Max,
// //         playSound: true,
// //         sound: 'sound',
// //         showProgress: true,
// //         priority: Priority.High,
// //         ticker: 'test ticker');

// //     var iOSChannelSpecifics = IOSNotificationDetails();
// //     var platformChannelSpecifics = NotificationDetails(
// //         androidPlatformChannelSpecifics, iOSChannelSpecifics);
// //     await flutterLocalNotificationsPlugin
// //         .show(0, title, body, platformChannelSpecifics, payload: 'test');
// //   }
///////////////////////////////9/6/2023//////////////////////////
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

// Future<void> handleForegroundMessage(RemoteMessage message) async {
//   print("Title : ${message.notification?.title}");
//   print("Body : ${message.notification?.body}");
//   print("Payload : ${message.data}");
// }

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
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
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
      // _showNotification();
      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  androidChannel.id, androidChannel.name,
                  channelDescription: androidChannel.description,
                  icon: 'mipmap/ic_launcher')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> _showNotification() async {
    final android = AndroidNotificationDetails('0', 'Adun Accounts',
        channelDescription: 'channel description',
        importance: Importance.max,
        icon: '');
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification == null) return;
      // _showNotification("abc", "cyu");
      await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  androidChannel.id, androidChannel.name,
                  channelDescription: androidChannel.description,
                  icon: 'mipmap/ic_launcher')),
          payload: jsonEncode(message.toMap()));
    });
    // await flutterLocalNotificationsPlugin.show(
    //     0, // notification id
    //     "${fileName}",
    //     'Download complete.',
    //     platform,
    //     payload: '$savePath');
  }

  //////////////////////////////////////
  // Future<void> initPushNotifications() async {
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((handleForegroundMessage) {});
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleForegroundMessage);
  //   FirebaseMessaging.onBackgroundMessage(handleForegroundMessage);
  //   FirebaseMessaging.onMessage.listen((message) {
  //     final notification = message.notification;
  //     if (notification == null) return;
  //     _localNotification.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //                 androidChannel.id, androidChannel.name,
  //                 channelDescription: androidChannel.description,
  //                 icon: '@drawable/ic_launcher')),
  //         payload: jsonEncode(message.toMap()));
  //   });
  // }

  Future<void> initNotification() async {
    await firebasemessaging.requestPermission();
    fcmToken = await firebasemessaging.getToken();
    log("Token : ${fcmToken}");
    initPushNotification();
    initLocalNotifications();
    // initPushNotifications();
  }
}


















//////////////////////////////////
// FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   @override
//   void initState() {
// var initializationSettingsAndroid =
//         new AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = new IOSInitializationSettings();
//     var initializationSettings = new InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         showNotification(
//             message['notification']['title'], message['notification']['body']);
//         print("onMessage: $message");
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         Navigator.pushNamed(context, '/notify');
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//     );
// }
// Future onSelectNotification(String payload) async {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return new AlertDialog(
//           title: Text("PayLoad"),
//           content: Text("Payload : $payload"),
//         );
//       },
//     );
//   }
// void showNotification(String title, String body) async {
//     await _demoNotification(title, body);
//   }

//   Future<void> _demoNotification(String title, String body) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'channel_ID', 'channel name', 'channel description',
//         importance: Importance.Max,
//         playSound: true,
//         sound: 'sound',
//         showProgress: true,
//         priority: Priority.High,
//         ticker: 'test ticker');

//     var iOSChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSChannelSpecifics);
//     await flutterLocalNotificationsPlugin
//         .show(0, title, body, platformChannelSpecifics, payload: 'test');
//   }