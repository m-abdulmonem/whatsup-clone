// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class Notify extends ChangeNotifier {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future initialize() async {
//     tz.initializeTimeZones();
//     final String currentTimeZone =
//         await FlutterNativeTimezone.getLocalTimezone();
//
//     tz.setLocalLocation(tz.getLocation(currentTimeZone));
//
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//
//     AndroidInitializationSettings androidInitializationSettings =
//         const AndroidInitializationSettings('@mipmap/launcher_icon');
//
//     IOSInitializationSettings iosInitializationSettings =
//         const IOSInitializationSettings();
//
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: androidInitializationSettings,
//             iOS: iosInitializationSettings);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   //Instant Notifications
//   Future normalNotify({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     var android =
//         const AndroidNotificationDetails("id", "channel", "description");
//
//     var ios = const IOSNotificationDetails();
//
//     var platform = NotificationDetails(android: android, iOS: ios);
//
//     await _flutterLocalNotificationsPlugin.show(id, title, body, platform,
//         payload: payload);
//   }
//
//   //Image notification
//   Future imageNotify({
//     int id = 0,
//     String? title,
//     String? body,
//     AndroidBitmap<Object>? image,
//     String? payload,
//   }) async {
//     var bigPicture = BigPictureStyleInformation(
//         image ?? const DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         largeIcon: image ?? const DrawableResourceAndroidBitmap("ic_launcher"),
//         contentTitle: title,
//         summaryText: body,
//         htmlFormatContent: true,
//         htmlFormatContentTitle: true);
//
//     var android = AndroidNotificationDetails("id", "channel", "description",
//         styleInformation: bigPicture);
//
//     var platform = NotificationDetails(android: android);
//
//     await _flutterLocalNotificationsPlugin.show(id, title, body, platform,
//         payload: payload);
//   }
//
//   //Stylish Notification
//   Future stylishNotify({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     var android = const AndroidNotificationDetails(
//         "id", "channel", "description",
//         color: Colors.deepOrange,
//         enableLights: true,
//         enableVibration: true,
//         largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         styleInformation: MediaStyleInformation(
//             htmlFormatContent: true, htmlFormatTitle: true));
//
//     var platform = NotificationDetails(android: android);
//
//     await _flutterLocalNotificationsPlugin.show(id, title, body, platform);
//   }
//
//   Future scheduleNotify({
//     int id = 0,
//     String? title,
//     String? body,
//     AndroidBitmap<Object>? image,
//     String? payload,
//   }) async {
//     var interval = RepeatInterval.weekly;
//     var bigPicture = BigPictureStyleInformation(
//         const DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         contentTitle: title,
//         summaryText: body,
//         htmlFormatContent: true,
//         htmlFormatContentTitle: true);
//
//     var android = AndroidNotificationDetails("id", "channel", "description",
//         styleInformation: bigPicture);
//
//     var platform = NotificationDetails(android: android);
//
//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         id, title, body, interval, platform);
//   }
//
//   Future backgroundServiceNotify({
//     int id = 0,
//     String? title,
//     String? body,
//     int? secondsDuration,
//     Duration? duration,
//     AndroidBitmap<Object>? image,
//     String? payload,
//   }) async {
//     var bigPicture = BigPictureStyleInformation(
//         const DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         // largeIcon: const DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         contentTitle: title,
//         summaryText: body,
//         htmlFormatContent: true,
//         htmlFormatContentTitle: true);
//
//     var android = const AndroidNotificationDetails("id", "channel", "description");
//
//     var platform = NotificationDetails(android: android);
//
//     await _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
//         tz.TZDateTime.now(tz.local).add(duration ?? Duration(seconds: secondsDuration!)), platform,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }
//
//   //Cancel notification
//
//   Future cancelNotification() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
