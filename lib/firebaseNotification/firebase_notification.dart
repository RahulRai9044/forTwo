import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';

Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
  log('Background Message Recived! ${message.notification!.title}');
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications',
      description: 'High Importance Notification from Firebase',
      importance: Importance.high,
      playSound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('Firebase Initialize');
      String? token = await FirebaseMessaging.instance.getToken();
      print('token : $token');
      if (token != null) {
        await Prefrence.setFCMToken(token);
        log("APNTOKEN $token");
      }

      FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        // AndroidNotification? android = message.notification?.android;
        if (notification != null) {
          Prefrence.setBadgeStatus(true);
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  icon: "@mipmap/launcher_icon",
                  playSound: true,
                ),
              ));
        }
      });
    }
  }
}