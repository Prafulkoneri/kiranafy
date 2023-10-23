// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_supper_market/main.dart';

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
//   @pragma('vm:entry-point')
//   void handleMessage(RemoteMessage? message) {

//     if (message == null) return;
//     // navigatorKey.currentState?.pushNamed(NotificationsScreen.route, arguments:
//     // message);
//   }

//   ///

//   Future initLocalNotifications() async {
//     const iOS = IOSInitializationSettings();
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: iOS);
//     await _localNotification.initialize(settings,
//         onSelectNotification: (payload) {
//       final message = RemoteMessage.fromMap(
//         jsonDecode(payload!),
//       );
//       handleMessage(message);
//     });
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
//       @pragma('vm:entry-point')
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
//                   icon: '@mipmap/ic_launcher')),
//           payload: jsonEncode(message.toMap()));
//     });
//   }

//   Future<void> initNotification() async {
//     await firebasemessaging.requestPermission();
//     fcmToken = await firebasemessaging.getToken();
//     log("Token : ${fcmToken}");
//     initPushNotification();
//     initLocalNotifications();
//     // initPushNotifications();
//   }
// }
// import 'dart:convert';
// import 'dart:developer';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_supper_market/main.dart';
// import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';

// // Future<void> handleBackGroundMessage(RemoteMessage message) async {
// //   print("Title : ${message.notification?.title}");
// //   print("Body : ${message.notification?.body}");
// //   print("Payload : ${message.data}");
// // }

// // class FireBaseApi {
// //   final firebasemessaging = FirebaseMessaging.instance;
// //   final androidChannel = const AndroidNotificationChannel(
// //       'high_importance_channel', 'High Importance Notification',
// //       description: 'this channel is used for important notification',
// //       importance: Importance.defaultImportance);
// //   final _localNotification = FlutterLocalNotificationsPlugin();
// //   @pragma('vm:entry-point')
// //   void handleMessage(RemoteMessage? message) {
// //     if (message == null) return;
// //     // navigatorKey.currentState?.pushNamed(NotificationsScreen.route, arguments:
// //     // message);
// //   }

// //   ///

// //   Future initLocalNotifications() async {
// //     const iOS = IOSInitializationSettings();
// //     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
// //     const settings = InitializationSettings(android: android, iOS: iOS);
// //     await _localNotification.initialize(settings,
// //         onSelectNotification: (payload) {
// //       final message = RemoteMessage.fromMap(
// //         jsonDecode(payload!),
// //       );
// //       handleMessage(message);
// //     });
// //     final platform = _localNotification.resolvePlatformSpecificImplementation<
// //         AndroidFlutterLocalNotificationsPlugin>();
// //     await platform?.createNotificationChannel(androidChannel);
// //   }

// //   ///////////////////
// //   Future<void> initPushNotification() async {
// //     await FirebaseMessaging.instance
// //         .setForegroundNotificationPresentationOptions(
// //       alert: true,
// //       badge: true,
// //       sound: true,
// //     );

// //     FirebaseMessaging.instance
// //         .getInitialMessage()
// //         .then((handleBackGroundMessage) {});
// //     FirebaseMessaging.onMessageOpenedApp.listen(handleBackGroundMessage);
// //     FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);

// //     FirebaseMessaging.onMessage.listen((message) {
// //       @pragma('vm:entry-point')
// //       final notification = message.notification;
// //       if (notification == null) return;
// //       // _showNotification();
// //       _localNotification.show(
// //           notification.hashCode,
// //           notification.title,
// //           notification.body,
// //           NotificationDetails(
// //               android: AndroidNotificationDetails(
// //                   androidChannel.id, androidChannel.name,
// //                   channelDescription: androidChannel.description,
// //                   icon: '@mipmap/ic_launcher')),
// //           payload: jsonEncode(message.toMap()));
// //     });
// //   }

// //   Future<void> initNotification() async {
// //     await firebasemessaging.requestPermission();
// //     fcmToken = await firebasemessaging.getToken();
// //     log("Token : ${fcmToken}");
// //     initPushNotification();
// //     initLocalNotifications();
// //     // initPushNotifications();
// //   }
// // }

// class NotificationServices {
//   static Future<void> initalizeNotification() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           criticalAlerts: true,
//           onlyAlertOnce: true,
//           channelShowBadge: true,
//           importance: NotificationImportance.Max,
//           ledColor: Colors.white,
//           defaultColor: Colors.red,
//           channelKey: 'call_channel',
//           /* same name */
//           /* same name */
//           channelGroupKey: 'high_importance_channel',
//           channelName: 'Basic Notification',
//           channelDescription: 'Notification Channel for Basic Test',
//         )
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//             channelGroupKey: 'high_importance_channel',
//             channelGroupName: 'Group 1')
//       ],
//       debug: true,
//     );
//     await AwesomeNotifications()
//         .isNotificationAllowed()
//         .then((isAllowed) async {
//       if (!isAllowed) {
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
// // awa
//     await AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayMethod,
//       onDismissActionReceivedMethod: onDismissactionReceivedMethos,
//     );
//     // await AwesomeNotifications().setListeners(
//     //   onAction
//     // );
//   }

//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationCreatedMethod');
//   }

//   static Future<void> onNotificationDisplayMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationDisplayMethod');
//   }

//   static Future<void> onDismissactionReceivedMethos(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onDismissactionReceivedMethos');
//   }

//   static Future<void> onActionReceivedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onActionReceviedMethod');
//     // final payload = receivedAction.payload ?? {};
//     // if (payload["navigation"] == "true") {
//     //   MainApp.NavigatorKey.currentState?.push(
//     //     MaterialPageRoute(builder: (_) => HomeScreenView(refreshPage: ) );
//     //   );
//     // }
//   }

//   static Future<void> showNotification({
//     final String? title,
//     final String? body,
//     final String? summery,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final String? bigPicture,
//   }) async {
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//       id: -1,
//       channelKey: 'call_channel',
//       /* same name */
//       title: title,
//       body: body,
//       actionType: actionType,
//       summary: summery,
//       bigPicture: bigPicture,
//     ));
//   }
// }
/////////////////////////////////////////////10/19/2023////////////////////////////////////////////////////
// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_supper_market/main.dart';

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
//   @pragma('vm:entry-point')
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     // navigatorKey.currentState?.pushNamed(NotificationsScreen.route, arguments:
//     // message);
//   }

//   ///

//   Future initLocalNotifications() async {
//     const iOS = IOSInitializationSettings();
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: iOS);
//     await _localNotification.initialize(settings,
//         onSelectNotification: (payload) {
//       final message = RemoteMessage.fromMap(
//         jsonDecode(payload!),
//       );
//       handleMessage(message);
//     });
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

  //   FirebaseMessaging.onMessage.listen((message) async {
  //     @pragma('vm:entry-point')
  //     final notification = message.notification;
  //     if (notification == null) return;
  //     final http.Response response = await http.get(Uri.parse(
  //         "http://thewowstyle.com/wp-content/uploads/2015/01/nature-images.jpg"));
  //     BigPictureStyleInformation bigPictureStyleInformation =
  //         BigPictureStyleInformation(
  //       ByteArrayAndroidBitmap.fromBase64String(
  //           base64Encode(response.bodyBytes)),
  //       largeIcon: ByteArrayAndroidBitmap.fromBase64String(
  //           base64Encode(response.bodyBytes)),
  //     );
  //     // _showNotification();
  //     _localNotification.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         // notification.
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //                 androidChannel.id, androidChannel.name,
  //                 channelDescription: androidChannel.description,
  //                 styleInformation: bigPictureStyleInformation,
  //                 icon: '@mipmap/ic_launcher')),
  //         payload: jsonEncode(message.toMap()));
  //   });
  // }

//   Future<void> initNotification() async {
//     await firebasemessaging.requestPermission();
//     fcmToken = await firebasemessaging.getToken();
//     log("Token : ${fcmToken}");
//     initPushNotification();
//     initLocalNotifications();
//     // initPushNotifications();
//   }
// }
