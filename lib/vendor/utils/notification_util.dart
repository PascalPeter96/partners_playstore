// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:wena/utils/const.dart';
//
// // import '../main.dart';
// import '../config/local_storage.dart';
// import '../main.dart';
//
// import 'package:timezone/data/latest.dart';
// import 'package:timezone/timezone.dart' as t;
//
// class NotificationUtil {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static NotificationAppLaunchDetails? notificationAppLaunchDetails;
//
//   static Future<void> initializeNotification(var listner) async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_launcher');
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true,
//             onDidReceiveLocalNotification: (int? id, String? title,
//                 String? body, String? payload) async {});
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS);
//
//     listner(flutterLocalNotificationsPlugin, initializationSettings);
//     await registerNotification();
//   }
//
//   static registerNotification() async {
//     // 1. Initialize the Firebase app
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//
//     // 2. Instantiate Firebase Messaging
//     FirebaseMessaging _messaging = FirebaseMessaging.instance;
//
//     // 3. On iOS, this helps to take the user permissions
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.instance.getToken().then((token) {
//         FCM_TOKEN = token as String;
//         LocalStorage.setFCMId(token as String);
//         print(token);
//       });
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         // ...
//
//         const AndroidNotificationDetails androidPlatformChannelSpecifics =
//             AndroidNotificationDetails(
//           'dntl',
//           'dntl',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//           autoCancel: true,
//           color: Color(0xffffffff),
//           channelShowBadge: true,
//           playSound: true,
//           styleInformation: BigTextStyleInformation(''),
//         );
//         const IOSNotificationDetails iOSPlatformChannelSpecifics =
//             IOSNotificationDetails(
//                 presentSound: true, presentAlert: true, presentBadge: true);
//         const NotificationDetails platformChannelSpecifics =
//             NotificationDetails(
//                 android: androidPlatformChannelSpecifics,
//                 iOS: iOSPlatformChannelSpecifics);
//
//         flutterLocalNotificationsPlugin.show(12345, message.notification!.title,
//             message.notification!.body, platformChannelSpecifics,
//             payload: message.data["type"]);
//       });
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
// }
