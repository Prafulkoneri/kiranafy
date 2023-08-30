// // import 'package:flutter/material.dart';
// // import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// //
// // class CustomNavBarWidget extends StatelessWidget {
// //   final int ? selectedIndex;
// //   final List<PersistentBottomNavBarItem> ?  items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
// //   final ValueChanged<int> ? onItemSelected;
// //
// //   CustomNavBarWidget(
// //       {Key ? key,
// //         this.selectedIndex,
// //         @required this.items,
// //         this.onItemSelected,});
// //
// //   Widget _buildItem(
// //       PersistentBottomNavBarItem item, bool isSelected) {
// //     return Container(
// //       alignment: Alignment.center,
// //       height: 60.0,
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         mainAxisSize: MainAxisSize.min,
// //         children: <Widget>[
// //           Flexible(
// //             child: IconTheme(
// //               data: IconThemeData(
// //                   size: 26.0,
// //                   color: isSelected
// //                       ? (item.activeColorSecondary == null
// //                       ? item.activeColorPrimary
// //                       : item.activeColorSecondary)
// //                       : item.inactiveColorPrimary == null
// //                       ? item.activeColorPrimary
// //                       : item.inactiveColorPrimary),
// //               child: item.icon,
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.only(top: 5.0),
// //             child: Material(
// //               type: MaterialType.transparency,
// //               child: FittedBox(
// //                   child: Text(
// //                     item.title??"",
// //                     style: TextStyle(
// //                         color: isSelected
// //                             ? (item.activeColorSecondary == null
// //                             ? item.activeColorPrimary
// //                             : item.activeColorSecondary)
// //                             : item.inactiveColorPrimary,
// //                         fontWeight: FontWeight.w400,
// //                         fontSize: 12.0),
// //                   )),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Colors.white,
// //       child: Container(
// //         width: double.infinity,
// //         height: 60.0,
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //           children: items.map((item) {
// //             int index = items?.indexOf(item)??0;
// //             return Flexible(
// //               child: GestureDetector(
// //                 onTap: () {
// //                   this.onItemSelected!(index);
// //                 },
// //                 child: _buildItem(
// //                     item, selectedIndex == index),
// //               ),
// //             );
// //           }).toList(),
// //         ),
// //       ),
// //     );
// //   }
// // }













// //  ElevatedButton(
//                          import 'dart:convert';
// import 'dart:developer';
// // import 'dart:js';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_supper_market/main.dart';
// import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
// import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
// import 'package:local_supper_market/screen/shop_owner/notification/view/notification_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

// Future<void> handleBackGroundMessage(RemoteMessage message) async {
//   print("notification");
//   print("Title : ${message.notification?.title}");
//   print("Body : ${message.notification?.body}");
//   print("Payload : ${message.data}");
// }

// // Future<void> handleForegroundMessage(RemoteMessage message) async {
// //   print("Title : ${message.notification?.title}");
// //   print("Body : ${message.notification?.body}");
// //   print("Payload : ${message.data}");
// // }

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

//   Future initLocalNotifications(context) async {
//     const iOS = IOSInitializationSettings();
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: iOS);
//     await _localNotification.initialize(settings,
//         onSelectNotification: (payload) {
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         print('Just received a notification when app is opened');
//         // showNotification(message, context);
//         if (message.notification != null) {
//           //"route" will be your root parameter you sending from firebase
//           final routeFromNotification = message.data["user_type"];
//           var res = jsonDecode(payload.toString());
//           print(res["data"]["user_type"]);
//           if (res["data"] == "shop_owner") {
//             context
//                 .read<SMainScreenController>()
//                 .onOrderTypeNotification(context, res["data"]["redirect_id"]);
//           }
//           if (res["data"] == "customer") {
//             context
//                 .read<MainScreenController>()
//                 .onOrderTypeNotification(context, res["data"]["redirect_id"]);
//           }
//         }
//       }
//       );
//       // final message = RemoteMessage.fromMap(
//       //   jsonDecode(payload!),
//       // );
//       // print(payload);
//       // var res = jsonDecode(payload.toString());
//       // print(res["data"]["user_type"]);
//       // if (res["data"] == "shop_owner") {
//       //   context
//       //       .read<SMainScreenController>()
//       //       .onOrderTypeNotification(context, res["data"]["redirect_id"]);
//       // }
//       // print("notificationnnnnnnnnnnnnnnnnnn");
//       // handleMessage(message);
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
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // localNotification(message, context);
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

//   //

//   Future<void> initNotification() async {
//     await firebasemessaging.requestPermission();
//     fcmToken = await firebasemessaging.getToken();
//     log("Token : ${fcmToken}");
//     initPushNotification();
//     initLocalNotifications(BuildContext);
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
