import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  Future foregroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await firebaseMessage.requestPermission(alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission");
    } else {
      print("User Denied Permission");
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      String? token = await firebaseMessage.getToken();
      return token;
    } catch (e) {
      print("Error fetching device token: $e");
      return null;
    }
  }

  void isTokenRefresh() async {
    firebaseMessage.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }

  void initLocalNotification(RemoteMessage message, BuildContext context) async {
    var androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSetting, onDidReceiveNotificationResponse: (payload) {

    });
  }

  void firebaseInit(BuildContext context) {  ///Physical device
  // void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {

      if (kDebugMode){
        print("title: ${message.notification!.title}");
        print("body: ${message.notification!.body}");
      }
      /// Physical device
      if (Platform.isAndroid) {
        initLocalNotification(message, context);
        showNotifications(message);
      }
      ///

      // showNotifications(message);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(), "High Importance Notifications", importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(channel.id.toString(), channel.name.toString(),
        channelDescription: "your channel description", importance:Importance.high,
        priority: Priority.high, ticker: "ticker");
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(presentAlert: true,
        presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0, message.notification!.title, message.notification!.body, notificationDetails
        // notificationDetails
      );
    });
  }
}